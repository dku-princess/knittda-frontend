// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {

 SocialLoginType get type;
/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEventCopyWith<LoginEvent> get copyWith => _$LoginEventCopyWithImpl<LoginEvent>(this as LoginEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'LoginEvent(type: $type)';
}


}

/// @nodoc
abstract mixin class $LoginEventCopyWith<$Res>  {
  factory $LoginEventCopyWith(LoginEvent value, $Res Function(LoginEvent) _then) = _$LoginEventCopyWithImpl;
@useResult
$Res call({
 SocialLoginType type
});


$SocialLoginTypeCopyWith<$Res> get type;

}
/// @nodoc
class _$LoginEventCopyWithImpl<$Res>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._self, this._then);

  final LoginEvent _self;
  final $Res Function(LoginEvent) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialLoginType,
  ));
}
/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLoginTypeCopyWith<$Res> get type {
  
  return $SocialLoginTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SocialLogin value)?  socialLogin,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SocialLogin() when socialLogin != null:
return socialLogin(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SocialLogin value)  socialLogin,}){
final _that = this;
switch (_that) {
case SocialLogin():
return socialLogin(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SocialLogin value)?  socialLogin,}){
final _that = this;
switch (_that) {
case SocialLogin() when socialLogin != null:
return socialLogin(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SocialLoginType type)?  socialLogin,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SocialLogin() when socialLogin != null:
return socialLogin(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SocialLoginType type)  socialLogin,}) {final _that = this;
switch (_that) {
case SocialLogin():
return socialLogin(_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SocialLoginType type)?  socialLogin,}) {final _that = this;
switch (_that) {
case SocialLogin() when socialLogin != null:
return socialLogin(_that.type);case _:
  return null;

}
}

}

/// @nodoc


class SocialLogin implements LoginEvent {
  const SocialLogin({required this.type});
  

@override final  SocialLoginType type;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginCopyWith<SocialLogin> get copyWith => _$SocialLoginCopyWithImpl<SocialLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLogin&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'LoginEvent.socialLogin(type: $type)';
}


}

/// @nodoc
abstract mixin class $SocialLoginCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $SocialLoginCopyWith(SocialLogin value, $Res Function(SocialLogin) _then) = _$SocialLoginCopyWithImpl;
@override @useResult
$Res call({
 SocialLoginType type
});


@override $SocialLoginTypeCopyWith<$Res> get type;

}
/// @nodoc
class _$SocialLoginCopyWithImpl<$Res>
    implements $SocialLoginCopyWith<$Res> {
  _$SocialLoginCopyWithImpl(this._self, this._then);

  final SocialLogin _self;
  final $Res Function(SocialLogin) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(SocialLogin(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialLoginType,
  ));
}

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLoginTypeCopyWith<$Res> get type {
  
  return $SocialLoginTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}

// dart format on
