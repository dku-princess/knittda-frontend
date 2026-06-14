import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// 배너 초기 로딩 전체를 Sentry Performance transaction 1개로 측정합니다.
///
/// transaction 이름: `banner_initial_load`
///
/// span 구성
///   - `vm_init_to_request`  : T1 → T2 (ViewModel 시작 ~ Directus HTTP 전송 직전)
///   - `api_round_trip`      : T2 → T3 (HTTP 전송 ~ 응답 수신)
///   - `response_to_render`  : T3 → T4 (응답 파싱 ~ 배너 위젯 첫 프레임)
///   - `image_download`      : T4 → T5 (Image.network 다운로드·디코딩, 이미지 없으면 생략)
///
/// custom measurements (ms)
///   - `total_banner_ms`    = T5(또는 T4) - T1
///   - `request_prep_ms`    = T2 - T1
///   - `api_round_trip_ms`  = T3 - T2
///   - `render_ms`          = T4 - T3
///   - `image_load_ms`      = T5 - T4  (이미지 있는 경우에만)
///
/// 배너가 없거나 오류 발생 시 [abortSession]으로 transaction을 비정상 종료합니다.
class BannerLoadTracker {
  BannerLoadTracker._();

  static final instance = BannerLoadTracker._();

  static const String _transactionName = 'banner_initial_load';
  static const String _operation = 'ui.load';
  static const String _spanVmToRequest = 'vm_init_to_request';
  static const String _spanApiRoundTrip = 'api_round_trip';
  static const String _spanResponseToRender = 'response_to_render';
  static const String _spanImageDownload = 'image_download';

  ISentrySpan? _transaction;
  ISentrySpan? _currentSpan;

  bool _sessionActive = false;
  DateTime? _t1;
  DateTime? _t2;
  DateTime? _t3;
  DateTime? _t4;
  DateTime? _t5;

  bool get isSessionActive => _sessionActive;

  /// T1: HomeViewModel.loadBanners() 진입 시점.
  void markT1() {
    if (_sessionActive) return;

    _sessionActive = true;
    _t1 = DateTime.now();

    _transaction = Sentry.startTransaction(
      _transactionName,
      _operation,
      bindToScope: true,
    );
    _currentSpan = _transaction?.startChild(
      _spanVmToRequest,
      description: 'T1→T2: ViewModel init to Directus HTTP send',
    );

    _debugLog('T1 banner load start');
  }

  /// T2: Directus HTTP 요청 전송 직전.
  void markT2() {
    if (!_sessionActive) return;

    _t2 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = _transaction?.startChild(
      _spanApiRoundTrip,
      description: 'T2→T3: HTTP request to Directus in flight',
    );

    final t1 = _t1;
    if (t1 != null) {
      _debugLog('T2 HTTP about to send (+${_t2!.difference(t1).inMilliseconds}ms from T1)');
    }
  }

  /// T3: Directus HTTP 응답 수신 완료.
  void markT3() {
    if (!_sessionActive) return;

    _t3 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = _transaction?.startChild(
      _spanResponseToRender,
      description: 'T3→T4: response parsed to banner widget first frame',
    );

    final t2 = _t2;
    if (t2 != null) {
      _debugLog('T3 HTTP received (round-trip ${_t3!.difference(t2).inMilliseconds}ms)');
    }
  }

  /// T4: 배너 위젯이 처음 화면에 그려진 프레임.
  ///
  /// [hasImage] 배너에 썸네일 이미지가 있으면 `image_download` span을 추가로 시작하고,
  /// 없으면 이 시점에서 transaction을 정상 종료합니다.
  void markT4({required bool hasImage}) {
    if (!_sessionActive) return;

    _t4 = DateTime.now();
    _finishCurrentSpan(SpanStatus.ok());

    if (hasImage) {
      _currentSpan = _transaction?.startChild(
        _spanImageDownload,
        description: 'T4→T5: Image.network download and decode',
      );
      _debugLog('T4 banner widget rendered, image download starting');
    } else {
      _currentSpan = null;
      _attachMeasurements(t5: null);
      _debugLogSummary(t5: null);
      final tx = _transaction;
      _transaction = null;
      if (tx != null) unawaited(tx.finish(status: SpanStatus.ok()));
      _reset();
    }
  }

  /// T5: Image.network 이미지 디코딩 완료 (첫 프레임 표시).
  void markT5() {
    if (!_sessionActive) return;

    _t5 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = null;

    _attachMeasurements(t5: _t5);
    _debugLogSummary(t5: _t5);

    final tx = _transaction;
    _transaction = null;
    if (tx != null) unawaited(tx.finish(status: SpanStatus.ok()));

    _reset();
  }

  /// 이미지 로드 실패 시 호출. image_download span을 오류로 닫고 transaction은 정상 종료합니다.
  /// 배너 자체는 표시됐으므로 transaction status는 ok로 유지합니다.
  void markT5ImageError() {
    if (!_sessionActive) return;

    _t5 = DateTime.now();

    _finishCurrentSpan(SpanStatus.unknownError());
    _currentSpan = null;

    _attachMeasurements(t5: _t5);
    _debugLogSummary(t5: _t5);

    final tx = _transaction;
    _transaction = null;
    if (tx != null) unawaited(tx.finish(status: SpanStatus.ok()));

    _reset();
  }

  /// API 오류 또는 활성 배너 없음으로 조기 종료할 때 호출.
  void abortSession() {
    if (!_sessionActive) return;

    _debugLog('session aborted (no banner or error)');

    _finishCurrentSpan(SpanStatus.internalError());
    _currentSpan = null;

    final tx = _transaction;
    _transaction = null;
    if (tx != null) unawaited(tx.finish(status: SpanStatus.internalError()));

    _reset();
  }

  void _finishCurrentSpan(SpanStatus status) {
    final span = _currentSpan;
    if (span == null) return;
    unawaited(span.finish(status: status));
  }

  void _attachMeasurements({required DateTime? t5}) {
    final tx = _transaction;
    final t1 = _t1;
    final t2 = _t2;
    final t3 = _t3;
    final t4 = _t4;
    if (tx == null || t1 == null) return;

    const unit = DurationSentryMeasurementUnit.milliSecond;
    final end = t5 ?? t4;
    if (end != null) {
      tx.setMeasurement('total_banner_ms', end.difference(t1).inMilliseconds, unit: unit);
    }
    if (t2 != null) {
      tx.setMeasurement('request_prep_ms', t2.difference(t1).inMilliseconds, unit: unit);
    }
    if (t2 != null && t3 != null) {
      tx.setMeasurement('api_round_trip_ms', t3.difference(t2).inMilliseconds, unit: unit);
    }
    if (t3 != null && t4 != null) {
      tx.setMeasurement('render_ms', t4.difference(t3).inMilliseconds, unit: unit);
    }
    if (t4 != null && t5 != null) {
      tx.setMeasurement('image_load_ms', t5.difference(t4).inMilliseconds, unit: unit);
    }
  }

  void _debugLog(String message) {
    if (!kDebugMode) return;
    debugPrint('[Perf][Banner] $message');
  }

  void _debugLogSummary({required DateTime? t5}) {
    if (!kDebugMode) return;
    final t1 = _t1;
    final t2 = _t2;
    final t3 = _t3;
    final t4 = _t4;
    if (t1 == null || t2 == null || t3 == null || t4 == null) return;
    final end = t5 ?? t4;
    debugPrint(
      '[Perf][Banner] done — '
      'total=${end.difference(t1).inMilliseconds}ms '
      'T2-T1=${t2.difference(t1).inMilliseconds}ms '
      'T3-T2=${t3.difference(t2).inMilliseconds}ms '
      'T4-T3=${t4.difference(t3).inMilliseconds}ms'
      '${t5 != null ? ' T5-T4=${t5.difference(t4).inMilliseconds}ms' : ''}',
    );
  }

  void _reset() {
    _sessionActive = false;
    _t1 = null;
    _t2 = null;
    _t3 = null;
    _t4 = null;
    _t5 = null;
  }
}
