// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MypageState {

 bool get isLoading; User? get user; XFile? get previewImage;
/// Create a copy of MypageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MypageStateCopyWith<MypageState> get copyWith => _$MypageStateCopyWithImpl<MypageState>(this as MypageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MypageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.user, user) || other.user == user)&&(identical(other.previewImage, previewImage) || other.previewImage == previewImage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,user,previewImage);

@override
String toString() {
  return 'MypageState(isLoading: $isLoading, user: $user, previewImage: $previewImage)';
}


}

/// @nodoc
abstract mixin class $MypageStateCopyWith<$Res>  {
  factory $MypageStateCopyWith(MypageState value, $Res Function(MypageState) _then) = _$MypageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, User? user, XFile? previewImage
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$MypageStateCopyWithImpl<$Res>
    implements $MypageStateCopyWith<$Res> {
  _$MypageStateCopyWithImpl(this._self, this._then);

  final MypageState _self;
  final $Res Function(MypageState) _then;

/// Create a copy of MypageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? user = freezed,Object? previewImage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,previewImage: freezed == previewImage ? _self.previewImage : previewImage // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}
/// Create a copy of MypageState
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


/// Adds pattern-matching-related methods to [MypageState].
extension MypageStatePatterns on MypageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MypageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MypageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MypageState value)  $default,){
final _that = this;
switch (_that) {
case _MypageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MypageState value)?  $default,){
final _that = this;
switch (_that) {
case _MypageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  User? user,  XFile? previewImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MypageState() when $default != null:
return $default(_that.isLoading,_that.user,_that.previewImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  User? user,  XFile? previewImage)  $default,) {final _that = this;
switch (_that) {
case _MypageState():
return $default(_that.isLoading,_that.user,_that.previewImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  User? user,  XFile? previewImage)?  $default,) {final _that = this;
switch (_that) {
case _MypageState() when $default != null:
return $default(_that.isLoading,_that.user,_that.previewImage);case _:
  return null;

}
}

}

/// @nodoc


class _MypageState implements MypageState {
   _MypageState({required this.isLoading, required this.user, this.previewImage});
  

@override final  bool isLoading;
@override final  User? user;
@override final  XFile? previewImage;

/// Create a copy of MypageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MypageStateCopyWith<_MypageState> get copyWith => __$MypageStateCopyWithImpl<_MypageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MypageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.user, user) || other.user == user)&&(identical(other.previewImage, previewImage) || other.previewImage == previewImage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,user,previewImage);

@override
String toString() {
  return 'MypageState(isLoading: $isLoading, user: $user, previewImage: $previewImage)';
}


}

/// @nodoc
abstract mixin class _$MypageStateCopyWith<$Res> implements $MypageStateCopyWith<$Res> {
  factory _$MypageStateCopyWith(_MypageState value, $Res Function(_MypageState) _then) = __$MypageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, User? user, XFile? previewImage
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$MypageStateCopyWithImpl<$Res>
    implements _$MypageStateCopyWith<$Res> {
  __$MypageStateCopyWithImpl(this._self, this._then);

  final _MypageState _self;
  final $Res Function(_MypageState) _then;

/// Create a copy of MypageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? user = freezed,Object? previewImage = freezed,}) {
  return _then(_MypageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,previewImage: freezed == previewImage ? _self.previewImage : previewImage // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}

/// Create a copy of MypageState
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
