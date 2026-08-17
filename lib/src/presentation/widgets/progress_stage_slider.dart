import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knittda/src/core/constants/color.dart';

/// 기록 진행도 입력용 슬라이더(시안 B).
///
/// - 바 전체가 히트 영역이라 탭 사각지대가 없다(탭·드래그 모두 지원).
/// - 좌→현재 단계까지 primary로 채우고, 단계 눈금 5개와 Ø28 핸들을 그린다.
/// - 눈금(tick)은 놓이는 배경이 채움(녹색)·미채움(회색 트랙)으로 다르므로
///   상태별 2색 + 테두리로 대비를 확보한다:
///   채움 위 = 흰색 + primary 링 / 미채움 = 진회색 + 흰색 halo.
/// - 단계가 바뀌는 순간에만 햅틱을 1회 준다.
/// - Semantics(slider)로 스크린리더·색상 외 단서를 제공한다.
class ProgressStageSlider extends StatelessWidget {
  const ProgressStageSlider({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  /// 각 단계의 표시 라벨(좌→우). 길이 = 단계 수.
  final List<String> labels;

  /// 현재 선택된 단계 인덱스. 미선택이면 null(또는 음수).
  final int? selectedIndex;

  /// 단계가 바뀔 때 호출. 값은 0..labels.length-1.
  final ValueChanged<int> onChanged;

  static const double _thumbSize = 28;
  static const double _trackHeight = 4;
  static const double _tickSize = 8;
  static const double _barHeight = 44; // 터치 타깃 높이
  static const Color _unfilledTick = Color(0xFF757575);
  static const Color _mutedThumbBorder = Color(0xFFBDBDBD);
  static const Color _endLabel = Color(0xFFAAAAAA);

  int get _count => labels.length;

  int get _selected {
    final i = selectedIndex;
    if (i == null || i < 0) return -1;
    return i.clamp(0, _count - 1);
  }

  /// 로컬 x좌표를 가장 가까운 단계로 스냅해서, 값이 바뀌면 햅틱 + 콜백.
  void _handlePosition(double localX, double width) {
    final inset = _thumbSize / 2;
    final trackW = width - inset * 2;
    if (trackW <= 0 || _count <= 1) return;
    final ratio = ((localX - inset) / trackW).clamp(0.0, 1.0);
    final index = (ratio * (_count - 1)).round().clamp(0, _count - 1);
    if (index != _selected) {
      HapticFeedback.selectionClick();
      onChanged(index);
    }
  }

  void _step(int delta) {
    final base = _selected < 0 ? 0 : _selected;
    final next = (_selected < 0 ? 0 : base + delta).clamp(0, _count - 1);
    if (next != _selected) {
      HapticFeedback.selectionClick();
      onChanged(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final grey300 = Colors.grey[300]!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final inset = _thumbSize / 2;
        final trackW = width - inset * 2;
        final centers = List<double>.generate(
          _count,
          (i) => inset + (_count == 1 ? 0.0 : trackW * i / (_count - 1)),
        );
        final selected = _selected;
        final thumbX = centers[selected < 0 ? 0 : selected];
        // 현재 라벨을 썸 위에 맞춰 정렬(가장자리에서는 자동으로 클램프된다).
        final labelAlignX =
            width <= 0 ? 0.0 : (thumbX / width * 2 - 1).clamp(-1.0, 1.0);

        return Semantics(
          slider: true,
          label: '진행 상태',
          value: selected < 0 ? '미선택' : labels[selected],
          onIncrease: () => _step(1),
          onDecrease: () => _step(-1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 현재 단계 라벨(썸 상단)
              SizedBox(
                height: 22,
                child: Align(
                  alignment: Alignment(labelAlignX, 0),
                  child: selected < 0
                      ? const Text(
                          '진행 상태를 선택해주세요',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        )
                      : Text(
                          labels[selected],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 6),
              // 바(탭·드래그 영역) — 전체 폭이 히트 영역
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (d) => _handlePosition(d.localPosition.dx, width),
                onHorizontalDragStart: (d) =>
                    _handlePosition(d.localPosition.dx, width),
                onHorizontalDragUpdate: (d) =>
                    _handlePosition(d.localPosition.dx, width),
                child: SizedBox(
                  height: _barHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // 트랙(미채움)
                      Positioned(
                        left: inset,
                        right: inset,
                        top: (_barHeight - _trackHeight) / 2,
                        child: Container(
                          height: _trackHeight,
                          decoration: BoxDecoration(
                            color: grey300,
                            borderRadius:
                                BorderRadius.circular(_trackHeight / 2),
                          ),
                        ),
                      ),
                      // 트랙(채움: 좌→현재)
                      if (selected > 0)
                        Positioned(
                          left: inset,
                          top: (_barHeight - _trackHeight) / 2,
                          child: Container(
                            width: (thumbX - inset).clamp(0.0, trackW),
                            height: _trackHeight,
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius:
                                  BorderRadius.circular(_trackHeight / 2),
                            ),
                          ),
                        ),
                      // 단계 눈금(tick)
                      for (int i = 0; i < _count; i++)
                        Positioned(
                          left: centers[i] - _tickSize / 2,
                          top: (_barHeight - _tickSize) / 2,
                          child: _Tick(filled: selected >= 0 && i <= selected),
                        ),
                      // 핸들(썸)
                      Positioned(
                        left: thumbX - _thumbSize / 2,
                        top: (_barHeight - _thumbSize) / 2,
                        child: _Thumb(active: selected >= 0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // 양 끝 기준 라벨
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(labels.first, style: _endLabelStyle),
                  Text(labels.last, style: _endLabelStyle),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static const TextStyle _endLabelStyle = TextStyle(
    fontSize: 12,
    color: _endLabel,
  );
}

/// 단계 눈금. 채움/미채움 배경 모두에서 대비를 확보하는 2색 + 테두리 방식.
class _Tick extends StatelessWidget {
  const _Tick({required this.filled});

  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ProgressStageSlider._tickSize,
      height: ProgressStageSlider._tickSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // 채움(녹색) 위 = 흰색 점 + primary 링 / 미채움 = 진회색 점 + 흰색 halo
        color: filled ? Colors.white : ProgressStageSlider._unfilledTick,
        border: Border.all(
          color: filled ? PRIMARY_COLOR : Colors.white,
          width: filled ? 1 : 1.5,
        ),
      ),
    );
  }
}

/// 핸들(썸). 선택 전에는 회색 테두리로 muted 처리.
class _Thumb extends StatelessWidget {
  const _Thumb({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ProgressStageSlider._thumbSize,
      height: ProgressStageSlider._thumbSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: active ? PRIMARY_COLOR : ProgressStageSlider._mutedThumbBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}
