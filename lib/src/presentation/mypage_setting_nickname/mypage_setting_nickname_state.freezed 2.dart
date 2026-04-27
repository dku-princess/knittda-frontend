// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_setting_nickname_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MypageSettingNicknameState {

 bool get isLoading; User? get user;
/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MypageSettingNicknameStateCopyWith<MypageSettingNicknameState> get copyWith => _$MypageSettingNicknameStateCopyWithImpl<MypageSettingNicknameState>(this as MypageSettingNicknameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MypageSettingNicknameState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,user);

@override
String toString() {
  return 'MypageSettingNicknameState(isLoading: $isLoading, user: $user)';
}


}

/// @nodoc
abstract mixin class $MypageSettingNicknameStateCopyWith<$Res>  {
  factory $MypageSettingNicknameStateCopyWith(MypageSettingNicknameState value, $Res Function(MypageSettingNicknameState) _then) = _$MypageSettingNicknameStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, User? user
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$MypageSettingNicknameStateCopyWithImpl<$Res>
    implements $MypageSettingNicknameStateCopyWith<$Res> {
  _$MypageSettingNicknameStateCopyWithImpl(this._self, this._then);

  final MypageSettingNicknameState _self;
  final $Res Function(MypageSettingNicknameState) _then;

/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? user = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}
/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [MypageSettingNicknameState].
extension MypageSettingNicknameStatePatterns on MypageSettingNicknameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MypageSettingNicknameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MypageSettingNicknameState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MypageSettingNicknameState value)  $default,){
final _that = this;
switch (_that) {
case _MypageSettingNicknameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MypageSettingNicknameState value)?  $default,){
final _that = this;
switch (_that) {
case _MypageSettingNicknameState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  User? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MypageSettingNicknameState() when $default != null:
return $default(_that.isLoading,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  User? user)  $default,) {final _that = this;
switch (_that) {
case _MypageSettingNicknameState():
return $default(_that.isLoading,_that.user);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  User? user)?  $default,) {final _that = this;
switch (_that) {
case _MypageSettingNicknameState() when $default != null:
return $default(_that.isLoading,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _MypageSettingNicknameState implements MypageSettingNicknameState {
   _MypageSettingNicknameState({required this.isLoading, required this.user});
  

@override final  bool isLoading;
@override final  User? user;

/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MypageSettingNicknameStateCopyWith<_MypageSettingNicknameState> get copyWith => __$MypageSettingNicknameStateCopyWithImpl<_MypageSettingNicknameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MypageSettingNicknameState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,user);

@override
String toString() {
  return 'MypageSettingNicknameState(isLoading: $isLoading, user: $user)';
}


}

/// @nodoc
abstract mixin class _$MypageSettingNicknameStateCopyWith<$Res> implements $MypageSettingNicknameStateCopyWith<$Res> {
  factory _$MypageSettingNicknameStateCopyWith(_MypageSettingNicknameState value, $Res Function(_MypageSettingNicknameState) _then) = __$MypageSettingNicknameStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, User? user
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$MypageSettingNicknameStateCopyWithImpl<$Res>
    implements _$MypageSettingNicknameStateCopyWith<$Res> {
  __$MypageSettingNicknameStateCopyWithImpl(this._self, this._then);

  final _MypageSettingNicknameState _self;
  final $Res Function(_MypageSettingNicknameState) _then;

/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? user = freezed,}) {
  return _then(_MypageSettingNicknameState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

/// Create a copy of MypageSettingNicknameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
