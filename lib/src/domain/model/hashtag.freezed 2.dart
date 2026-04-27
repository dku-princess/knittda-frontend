// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hashtag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hashtag {

 String? get hashtag; String? get description;
/// Create a copy of Hashtag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HashtagCopyWith<Hashtag> get copyWith => _$HashtagCopyWithImpl<Hashtag>(this as Hashtag, _$identity);

  /// Serializes this Hashtag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hashtag&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hashtag,description);

@override
String toString() {
  return 'Hashtag(hashtag: $hashtag, description: $description)';
}


}

/// @nodoc
abstract mixin class $HashtagCopyWith<$Res>  {
  factory $HashtagCopyWith(Hashtag value, $Res Function(Hashtag) _then) = _$HashtagCopyWithImpl;
@useResult
$Res call({
 String? hashtag, String? description
});




}
/// @nodoc
class _$HashtagCopyWithImpl<$Res>
    implements $HashtagCopyWith<$Res> {
  _$HashtagCopyWithImpl(this._self, this._then);

  final Hashtag _self;
  final $Res Function(Hashtag) _then;

/// Create a copy of Hashtag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hashtag = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Hashtag].
extension HashtagPatterns on Hashtag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hashtag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hashtag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hashtag value)  $default,){
final _that = this;
switch (_that) {
case _Hashtag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hashtag value)?  $default,){
final _that = this;
switch (_that) {
case _Hashtag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? hashtag,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hashtag() when $default != null:
return $default(_that.hashtag,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? hashtag,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Hashtag():
return $default(_that.hashtag,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? hashtag,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Hashtag() when $default != null:
return $default(_that.hashtag,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hashtag implements Hashtag {
   _Hashtag({required this.hashtag, required this.description});
  factory _Hashtag.fromJson(Map<String, dynamic> json) => _$HashtagFromJson(json);

@override final  String? hashtag;
@override final  String? description;

/// Create a copy of Hashtag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HashtagCopyWith<_Hashtag> get copyWith => __$HashtagCopyWithImpl<_Hashtag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HashtagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hashtag&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hashtag,description);

@override
String toString() {
  return 'Hashtag(hashtag: $hashtag, description: $description)';
}


}

/// @nodoc
abstract mixin class _$HashtagCopyWith<$Res> implements $HashtagCopyWith<$Res> {
  factory _$HashtagCopyWith(_Hashtag value, $Res Function(_Hashtag) _then) = __$HashtagCopyWithImpl;
@override @useResult
$Res call({
 String? hashtag, String? description
});




}
/// @nodoc
class __$HashtagCopyWithImpl<$Res>
    implements _$HashtagCopyWith<$Res> {
  __$HashtagCopyWithImpl(this._self, this._then);

  final _Hashtag _self;
  final $Res Function(_Hashtag) _then;

/// Create a copy of Hashtag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hashtag = freezed,Object? description = freezed,}) {
  return _then(_Hashtag(
hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
