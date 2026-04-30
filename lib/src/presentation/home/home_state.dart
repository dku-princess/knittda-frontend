import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();

  factory HomeState({required List<InAppBanner> activeBanners}) = _HomeState;

  InAppBanner? get currentBanner =>
      activeBanners.isEmpty ? null : activeBanners.first;
}
