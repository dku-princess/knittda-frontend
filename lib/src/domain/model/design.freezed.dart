// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'design.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Design {

 int? get id; String? get title; String? get designer; String? get needleInfo; String? get yarnInfo; String? get description; DateTime? get createdAt;
/// Create a copy of Design
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesignCopyWith<Design> get copyWith => _$DesignCopyWithImpl<Design>(this as Design, _$identity);

  /// Serializes this Design to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Design&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.needleInfo, needleInfo) || other.needleInfo == needleInfo)&&(identical(other.yarnInfo, yarnInfo) || other.yarnInfo == yarnInfo)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,designer,needleInfo,yarnInfo,description,createdAt);

@override
String toString() {
  return 'Design(id: $id, title: $title, designer: $designer, needleInfo: $needleInfo, yarnInfo: $yarnInfo, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DesignCopyWith<$Res>  {
  factory $DesignCopyWith(Design value, $Res Function(Design) _then) = _$DesignCopyWithImpl;
@useResult
$Res call({
 int? id, String? title, String? designer, String? needleInfo, String? yarnInfo, String? description, DateTime? createdAt
});




}
/// @nodoc
class _$DesignCopyWithImpl<$Res>
    implements $DesignCopyWith<$Res> {
  _$DesignCopyWithImpl(this._self, this._then);

  final Design _self;
  final $Res Function(Design) _then;

/// Create a copy of Design
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? designer = freezed,Object? needleInfo = freezed,Object? yarnInfo = freezed,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,needleInfo: freezed == needleInfo ? _self.needleInfo : needleInfo // ignore: cast_nullable_to_non_nullable
as String?,yarnInfo: freezed == yarnInfo ? _self.yarnInfo : yarnInfo // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Design].
extension DesignPatterns on Design {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Design value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Design() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Design value)  $default,){
final _that = this;
switch (_that) {
case _Design():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Design value)?  $default,){
final _that = this;
switch (_that) {
case _Design() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? title,  String? designer,  String? needleInfo,  String? yarnInfo,  String? description,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Design() when $default != null:
return $default(_that.id,_that.title,_that.designer,_that.needleInfo,_that.yarnInfo,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? title,  String? designer,  String? needleInfo,  String? yarnInfo,  String? description,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Design():
return $default(_that.id,_that.title,_that.designer,_that.needleInfo,_that.yarnInfo,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? title,  String? designer,  String? needleInfo,  String? yarnInfo,  String? description,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Design() when $default != null:
return $default(_that.id,_that.title,_that.designer,_that.needleInfo,_that.yarnInfo,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Design implements Design {
   _Design({this.id, required this.title, required this.designer, required this.needleInfo, required this.yarnInfo, required this.description, this.createdAt});
  factory _Design.fromJson(Map<String, dynamic> json) => _$DesignFromJson(json);

@override final  int? id;
@override final  String? title;
@override final  String? designer;
@override final  String? needleInfo;
@override final  String? yarnInfo;
@override final  String? description;
@override final  DateTime? createdAt;

/// Create a copy of Design
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesignCopyWith<_Design> get copyWith => __$DesignCopyWithImpl<_Design>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesignToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Design&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.needleInfo, needleInfo) || other.needleInfo == needleInfo)&&(identical(other.yarnInfo, yarnInfo) || other.yarnInfo == yarnInfo)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,designer,needleInfo,yarnInfo,description,createdAt);

@override
String toString() {
  return 'Design(id: $id, title: $title, designer: $designer, needleInfo: $needleInfo, yarnInfo: $yarnInfo, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DesignCopyWith<$Res> implements $DesignCopyWith<$Res> {
  factory _$DesignCopyWith(_Design value, $Res Function(_Design) _then) = __$DesignCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? title, String? designer, String? needleInfo, String? yarnInfo, String? description, DateTime? createdAt
});




}
/// @nodoc
class __$DesignCopyWithImpl<$Res>
    implements _$DesignCopyWith<$Res> {
  __$DesignCopyWithImpl(this._self, this._then);

  final _Design _self;
  final $Res Function(_Design) _then;

/// Create a copy of Design
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? designer = freezed,Object? needleInfo = freezed,Object? yarnInfo = freezed,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_Design(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,needleInfo: freezed == needleInfo ? _self.needleInfo : needleInfo // ignore: cast_nullable_to_non_nullable
as String?,yarnInfo: freezed == yarnInfo ? _self.yarnInfo : yarnInfo // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
