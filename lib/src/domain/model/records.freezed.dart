// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Records {

 int? get id; int get projectId; String? get recordStatus; List<String>? get tags; String? get comment; DateTime? get createdAt; List<Images>? get images; String? get question; int? get recordId;
/// Create a copy of Records
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordsCopyWith<Records> get copyWith => _$RecordsCopyWithImpl<Records>(this as Records, _$identity);

  /// Serializes this Records to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Records&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.recordStatus, recordStatus) || other.recordStatus == recordStatus)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.question, question) || other.question == question)&&(identical(other.recordId, recordId) || other.recordId == recordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,recordStatus,const DeepCollectionEquality().hash(tags),comment,createdAt,const DeepCollectionEquality().hash(images),question,recordId);

@override
String toString() {
  return 'Records(id: $id, projectId: $projectId, recordStatus: $recordStatus, tags: $tags, comment: $comment, createdAt: $createdAt, images: $images, question: $question, recordId: $recordId)';
}


}

/// @nodoc
abstract mixin class $RecordsCopyWith<$Res>  {
  factory $RecordsCopyWith(Records value, $Res Function(Records) _then) = _$RecordsCopyWithImpl;
@useResult
$Res call({
 int? id, int projectId, String? recordStatus, List<String>? tags, String? comment, DateTime? createdAt, List<Images>? images, String? question, int? recordId
});




}
/// @nodoc
class _$RecordsCopyWithImpl<$Res>
    implements $RecordsCopyWith<$Res> {
  _$RecordsCopyWithImpl(this._self, this._then);

  final Records _self;
  final $Res Function(Records) _then;

/// Create a copy of Records
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? projectId = null,Object? recordStatus = freezed,Object? tags = freezed,Object? comment = freezed,Object? createdAt = freezed,Object? images = freezed,Object? question = freezed,Object? recordId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,recordStatus: freezed == recordStatus ? _self.recordStatus : recordStatus // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<Images>?,question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String?,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Records].
extension RecordsPatterns on Records {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Records value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Records() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Records value)  $default,){
final _that = this;
switch (_that) {
case _Records():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Records value)?  $default,){
final _that = this;
switch (_that) {
case _Records() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int projectId,  String? recordStatus,  List<String>? tags,  String? comment,  DateTime? createdAt,  List<Images>? images,  String? question,  int? recordId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Records() when $default != null:
return $default(_that.id,_that.projectId,_that.recordStatus,_that.tags,_that.comment,_that.createdAt,_that.images,_that.question,_that.recordId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int projectId,  String? recordStatus,  List<String>? tags,  String? comment,  DateTime? createdAt,  List<Images>? images,  String? question,  int? recordId)  $default,) {final _that = this;
switch (_that) {
case _Records():
return $default(_that.id,_that.projectId,_that.recordStatus,_that.tags,_that.comment,_that.createdAt,_that.images,_that.question,_that.recordId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int projectId,  String? recordStatus,  List<String>? tags,  String? comment,  DateTime? createdAt,  List<Images>? images,  String? question,  int? recordId)?  $default,) {final _that = this;
switch (_that) {
case _Records() when $default != null:
return $default(_that.id,_that.projectId,_that.recordStatus,_that.tags,_that.comment,_that.createdAt,_that.images,_that.question,_that.recordId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Records implements Records {
   _Records({this.id, required this.projectId, required this.recordStatus, required final  List<String>? tags, required this.comment, this.createdAt, final  List<Images>? images, this.question, this.recordId}): _tags = tags,_images = images;
  factory _Records.fromJson(Map<String, dynamic> json) => _$RecordsFromJson(json);

@override final  int? id;
@override final  int projectId;
@override final  String? recordStatus;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? comment;
@override final  DateTime? createdAt;
 final  List<Images>? _images;
@override List<Images>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? question;
@override final  int? recordId;

/// Create a copy of Records
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordsCopyWith<_Records> get copyWith => __$RecordsCopyWithImpl<_Records>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecordsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Records&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.recordStatus, recordStatus) || other.recordStatus == recordStatus)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.question, question) || other.question == question)&&(identical(other.recordId, recordId) || other.recordId == recordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,recordStatus,const DeepCollectionEquality().hash(_tags),comment,createdAt,const DeepCollectionEquality().hash(_images),question,recordId);

@override
String toString() {
  return 'Records(id: $id, projectId: $projectId, recordStatus: $recordStatus, tags: $tags, comment: $comment, createdAt: $createdAt, images: $images, question: $question, recordId: $recordId)';
}


}

/// @nodoc
abstract mixin class _$RecordsCopyWith<$Res> implements $RecordsCopyWith<$Res> {
  factory _$RecordsCopyWith(_Records value, $Res Function(_Records) _then) = __$RecordsCopyWithImpl;
@override @useResult
$Res call({
 int? id, int projectId, String? recordStatus, List<String>? tags, String? comment, DateTime? createdAt, List<Images>? images, String? question, int? recordId
});




}
/// @nodoc
class __$RecordsCopyWithImpl<$Res>
    implements _$RecordsCopyWith<$Res> {
  __$RecordsCopyWithImpl(this._self, this._then);

  final _Records _self;
  final $Res Function(_Records) _then;

/// Create a copy of Records
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? projectId = null,Object? recordStatus = freezed,Object? tags = freezed,Object? comment = freezed,Object? createdAt = freezed,Object? images = freezed,Object? question = freezed,Object? recordId = freezed,}) {
  return _then(_Records(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,recordStatus: freezed == recordStatus ? _self.recordStatus : recordStatus // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<Images>?,question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String?,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
