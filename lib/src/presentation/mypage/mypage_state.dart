import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/user.dart';

part 'mypage_state.freezed.dart';

@freezed
abstract class MypageState with _$MypageState {
  factory MypageState({required bool isLoading, required User? user}) =
      _MypageState;
}
