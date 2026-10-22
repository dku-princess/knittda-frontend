import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 로딩 표시(중앙 스피너).
///
/// 화면·영역이 로딩 중일 때 중앙에 `primary` 색 스피너를 그린다.
/// 색을 토큰으로 고정해 화면마다 제각각이던 인디케이터를 통일한다.
class KnittdaLoadingView extends StatelessWidget {
  const KnittdaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

/// Knittda 공통 로딩 오버레이(딤 + 스피너).
///
/// 콘텐츠 위에 [AppColors.scrim] 딤을 덮고 입력을 막으며 중앙에 스피너를 둔다.
/// **`Stack`의 `Positioned.fill` 자식으로** 배치한다.
///
/// ```dart
/// Stack(children: [
///   content,
///   if (state.isLoading) const Positioned.fill(child: KnittdaLoadingOverlay()),
/// ]);
/// ```
class KnittdaLoadingOverlay extends StatelessWidget {
  const KnittdaLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const AbsorbPointer(
      child: ColoredBox(
        color: AppColors.scrim,
        child: KnittdaLoadingView(),
      ),
    );
  }
}
