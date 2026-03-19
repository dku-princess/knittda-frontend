import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/user.dart';

part 'mypage_setting_nickname_state.freezed.dart';

@freezed
abstract class MypageSettingNicknameState with _$MypageSettingNicknameState {
  factory MypageSettingNicknameState({required bool isLoading, required User? user}) =
  _MypageSettingNicknameState;
}
