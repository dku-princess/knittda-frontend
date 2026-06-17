import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

/// Home 진입 후 탭별 **초기 로딩 1건**을 Sentry Performance transaction 1개로 측정합니다.
///
/// - transaction 이름
///   - [projectPreviews] → `project_previews_initial_load`
///   - [feed]            → `feed_initial_load`
/// - transaction 내부 span 구성 (T1~T4 구간)
///   - `vm_init_to_request`  : T1 → T2 (ViewModel 시작 ~ HTTP 전송 직전)
///   - `api_round_trip`      : T2 → T3 (HTTP 전송 ~ 응답 수신)
///   - `response_to_usable`  : T3 → T4 (응답 수신 ~ usable UI 첫 프레임)
/// - transaction custom measurements (ms)
///   - `total_load_ms`      = T4 - T1
///   - `request_prep_ms`    = T2 - T1
///   - `api_round_trip_ms`  = T3 - T2
///   - `render_ms`          = T4 - T3
///
class InitialLoadTracker {
  InitialLoadTracker._(this._transactionName);

  final String _transactionName;

  static final projectPreviews = InitialLoadTracker._(
    'project_previews_initial_load',
  );
  static final feed = InitialLoadTracker._(
    'feed_initial_load',
  );

  static const String _operation = 'ui.load';
  static const String _spanVmToRequest = 'vm_init_to_request';
  static const String _spanApiRoundTrip = 'api_round_trip';
  static const String _spanResponseToUsable = 'response_to_usable';

  ISentrySpan? _transaction;
  ISentrySpan? _currentSpan;

  bool _sessionActive = false;
  DateTime? _t1;
  DateTime? _t2;
  DateTime? _t3;
  DateTime? _t4;

  bool get isSessionActive => _sessionActive;

  /// T1: ViewModel의 초기 로딩 시작 시점.
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
      description: 'T1 → T2: ViewModel init to HTTP send',
    );
  }

  /// T2: HTTP 요청 전송 직전.
  void markT2() {
    if (!_sessionActive) return;

    _t2 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = _transaction?.startChild(
      _spanApiRoundTrip,
      description: 'T2 → T3: HTTP request in flight',
    );
  }

  /// T3: HTTP 응답 수신 완료.
  void markT3() {
    if (!_sessionActive) return;

    _t3 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = _transaction?.startChild(
      _spanResponseToUsable,
      description: 'T3 → T4: response parsed to usable UI frame',
    );
  }

  /// T4: usable UI가 실제로 그려진 첫 프레임.
  void markT4() {
    if (!_sessionActive) return;

    _t4 = DateTime.now();

    _finishCurrentSpan(SpanStatus.ok());
    _currentSpan = null;

    _attachMeasurements();

    final tx = _transaction;
    _transaction = null;
    if (tx != null) {
      unawaited(tx.finish(status: SpanStatus.ok()));
    }

    _reset();
  }

  /// API 오류 등으로 T4(usable UI)까지 가지 못할 때 transaction을 비정상 종료합니다.
  void abortSession() {
    if (!_sessionActive) return;

    _finishCurrentSpan(SpanStatus.internalError());
    _currentSpan = null;

    final tx = _transaction;
    _transaction = null;
    if (tx != null) {
      unawaited(tx.finish(status: SpanStatus.internalError()));
    }

    _reset();
  }

  void _finishCurrentSpan(SpanStatus status) {
    final span = _currentSpan;
    if (span == null) return;
    unawaited(span.finish(status: status));
  }

  void _attachMeasurements() {
    final tx = _transaction;
    final t1 = _t1;
    final t2 = _t2;
    final t3 = _t3;
    final t4 = _t4;
    if (tx == null || t1 == null || t4 == null) return;

    const unit = DurationSentryMeasurementUnit.milliSecond;

    tx.setMeasurement(
      'total_load_ms',
      t4.difference(t1).inMilliseconds,
      unit: unit,
    );
    if (t2 != null) {
      tx.setMeasurement(
        'request_prep_ms',
        t2.difference(t1).inMilliseconds,
        unit: unit,
      );
    }
    if (t2 != null && t3 != null) {
      tx.setMeasurement(
        'api_round_trip_ms',
        t3.difference(t2).inMilliseconds,
        unit: unit,
      );
    }
    if (t3 != null) {
      tx.setMeasurement(
        'render_ms',
        t4.difference(t3).inMilliseconds,
        unit: unit,
      );
    }
  }

  void _reset() {
    _sessionActive = false;
    _t1 = null;
    _t2 = null;
    _t3 = null;
    _t4 = null;
  }
}
