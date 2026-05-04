// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_setting_nickname_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MypageSettingNicknameEvent {

 String get nickname;
/// Create a copy of MypageSettingNicknameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MypageSettingNicknameEventCopyWith<MypageSettingNicknameEvent> get copyWith => _$MypageSettingNicknameEventCopyWithImpl<MypageSettingNicknameEvent>(this as MypageSettingNicknameEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MypageSettingNicknameEvent&&(identical(other.nickname, nickname) || other.nickname == nickname));
}


@override
int get hashCode => Object.hash(runtimeType,nickname);

@override
String toString() {
  return 'MypageSettingNicknameEvent(nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $MypageSettingNicknameEventCopyWith<$Res>  {
  factory $MypageSettingNicknameEventCopyWith(MypageSettingNicknameEvent value, $Res Function(MypageSettingNicknameEvent) _then) = _$MypageSettingNicknameEventCopyWithImpl;
@useResult
$Res call({
 String nickname
});




}
/// @nodoc
class _$MypageSettingNicknameEventCopyWithImpl<$Res>
    implements $MypageSettingNicknameEventCopyWith<$Res> {
  _$MypageSettingNicknameEventCopyWithImpl(this._self, this._then);

  final MypageSettingNicknameEvent _self;
  final $Res Function(MypageSettingNicknameEvent) _then;

/// Create a copy of MypageSettingNicknameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nickname = null,}) {
  return _then(_self.copyWith(
nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MypageSettingNicknameEvent].
extension MypageSettingNicknameEventPatterns on MypageSettingNicknameEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SettingNickname value)?  settingNickname,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SettingNickname() when settingNickname != null:
return settingNickname(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SettingNickname value)  settingNickname,}){
final _that = this;
switch (_that) {
case SettingNickname():
return settingNickname(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SettingNickname value)?  settingNickname,}){
final _that = this;
switch (_that) {
case SettingNickname() when settingNickname != null:
return settingNickname(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nickname)?  settingNickname,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SettingNickname() when settingNickname != null:
return settingNickname(_that.nickname);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nickname)  settingNickname,}) {final _that = this;
switch (_that) {
case SettingNickname():
return settingNickname(_that.nickname);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nickname)?  settingNickname,}) {final _that = this;
switch (_that) {
case SettingNickname() when settingNickname != null:
return settingNickname(_that.nickname);case _:
  return null;

}
}

}

/// @nodoc


class SettingNickname implements MypageSettingNicknameEvent {
  const SettingNickname(this.nickname);
  

@override final  String nickname;

/// Create a copy of MypageSettingNicknameEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingNicknameCopyWith<SettingNickname> get copyWith => _$SettingNicknameCopyWithImpl<SettingNickname>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingNickname&&(identical(other.nickname, nickname) || other.nickname == nickname));
}


@override
int get hashCode => Object.hash(runtimeType,nickname);

@override
String toString() {
  return 'MypageSettingNicknameEvent.settingNickname(nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $SettingNicknameCopyWith<$Res> implements $MypageSettingNicknameEventCopyWith<$Res> {
  factory $SettingNicknameCopyWith(SettingNickname value, $Res Function(SettingNickname) _then) = _$SettingNicknameCopyWithImpl;
@override @useResult
$Res call({
 String nickname
});




}
/// @nodoc
class _$SettingNicknameCopyWithImpl<$Res>
    implements $SettingNicknameCopyWith<$Res> {
  _$SettingNicknameCopyWithImpl(this._self, this._then);

  final SettingNickname _self;
  final $Res Function(SettingNickname) _then;

/// Create a copy of MypageSettingNicknameEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nickname = null,}) {
  return _then(SettingNickname(
null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
