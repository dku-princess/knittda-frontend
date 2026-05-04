// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialLoginType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLoginType()';
}


}

/// @nodoc
class $SocialLoginTypeCopyWith<$Res>  {
$SocialLoginTypeCopyWith(SocialLoginType _, $Res Function(SocialLoginType) __);
}


/// Adds pattern-matching-related methods to [SocialLoginType].
extension SocialLoginTypePatterns on SocialLoginType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Kakao value)?  kakao,TResult Function( Apple value)?  apple,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Kakao() when kakao != null:
return kakao(_that);case Apple() when apple != null:
return apple(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Kakao value)  kakao,required TResult Function( Apple value)  apple,}){
final _that = this;
switch (_that) {
case Kakao():
return kakao(_that);case Apple():
return apple(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Kakao value)?  kakao,TResult? Function( Apple value)?  apple,}){
final _that = this;
switch (_that) {
case Kakao() when kakao != null:
return kakao(_that);case Apple() when apple != null:
return apple(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  kakao,TResult Function()?  apple,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Kakao() when kakao != null:
return kakao();case Apple() when apple != null:
return apple();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  kakao,required TResult Function()  apple,}) {final _that = this;
switch (_that) {
case Kakao():
return kakao();case Apple():
return apple();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  kakao,TResult? Function()?  apple,}) {final _that = this;
switch (_that) {
case Kakao() when kakao != null:
return kakao();case Apple() when apple != null:
return apple();case _:
  return null;

}
}

}

/// @nodoc


class Kakao implements SocialLoginType {
  const Kakao();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Kakao);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLoginType.kakao()';
}


}




/// @nodoc


class Apple implements SocialLoginType {
  const Apple();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Apple);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLoginType.apple()';
}


}




// dart format on
