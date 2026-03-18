import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/user.dart';

part 'mypage_setting_nick_name_state.freezed.dart';

@freezed
abstract class MypageSettingNickNameState with _$MypageSettingNickNameState {
  factory MypageSettingNickNameState({required bool isLoading, required User? user}) =
  _MypageSettingNickNameState;
}
