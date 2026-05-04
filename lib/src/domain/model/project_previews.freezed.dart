// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_previews.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectPreviews {

 int get projectId; String? get userName; String get projectName; int get recordNum; DateTime? get lastRecordAt; List<String>? get recentImageUrls;
/// Create a copy of ProjectPreviews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectPreviewsCopyWith<ProjectPreviews> get copyWith => _$ProjectPreviewsCopyWithImpl<ProjectPreviews>(this as ProjectPreviews, _$identity);

  /// Serializes this ProjectPreviews to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectPreviews&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.recordNum, recordNum) || other.recordNum == recordNum)&&(identical(other.lastRecordAt, lastRecordAt) || other.lastRecordAt == lastRecordAt)&&const DeepCollectionEquality().equals(other.recentImageUrls, recentImageUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,userName,projectName,recordNum,lastRecordAt,const DeepCollectionEquality().hash(recentImageUrls));

@override
String toString() {
  return 'ProjectPreviews(projectId: $projectId, userName: $userName, projectName: $projectName, recordNum: $recordNum, lastRecordAt: $lastRecordAt, recentImageUrls: $recentImageUrls)';
}


}

/// @nodoc
abstract mixin class $ProjectPreviewsCopyWith<$Res>  {
  factory $ProjectPreviewsCopyWith(ProjectPreviews value, $Res Function(ProjectPreviews) _then) = _$ProjectPreviewsCopyWithImpl;
@useResult
$Res call({
 int projectId, String? userName, String projectName, int recordNum, DateTime? lastRecordAt, List<String>? recentImageUrls
});




}
/// @nodoc
class _$ProjectPreviewsCopyWithImpl<$Res>
    implements $ProjectPreviewsCopyWith<$Res> {
  _$ProjectPreviewsCopyWithImpl(this._self, this._then);

  final ProjectPreviews _self;
  final $Res Function(ProjectPreviews) _then;

/// Create a copy of ProjectPreviews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? userName = freezed,Object? projectName = null,Object? recordNum = null,Object? lastRecordAt = freezed,Object? recentImageUrls = freezed,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,recordNum: null == recordNum ? _self.recordNum : recordNum // ignore: cast_nullable_to_non_nullable
as int,lastRecordAt: freezed == lastRecordAt ? _self.lastRecordAt : lastRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recentImageUrls: freezed == recentImageUrls ? _self.recentImageUrls : recentImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectPreviews].
extension ProjectPreviewsPatterns on ProjectPreviews {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectPreviews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectPreviews() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectPreviews value)  $default,){
final _that = this;
switch (_that) {
case _ProjectPreviews():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectPreviews value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectPreviews() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int projectId,  String? userName,  String projectName,  int recordNum,  DateTime? lastRecordAt,  List<String>? recentImageUrls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectPreviews() when $default != null:
return $default(_that.projectId,_that.userName,_that.projectName,_that.recordNum,_that.lastRecordAt,_that.recentImageUrls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int projectId,  String? userName,  String projectName,  int recordNum,  DateTime? lastRecordAt,  List<String>? recentImageUrls)  $default,) {final _that = this;
switch (_that) {
case _ProjectPreviews():
return $default(_that.projectId,_that.userName,_that.projectName,_that.recordNum,_that.lastRecordAt,_that.recentImageUrls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int projectId,  String? userName,  String projectName,  int recordNum,  DateTime? lastRecordAt,  List<String>? recentImageUrls)?  $default,) {final _that = this;
switch (_that) {
case _ProjectPreviews() when $default != null:
return $default(_that.projectId,_that.userName,_that.projectName,_that.recordNum,_that.lastRecordAt,_that.recentImageUrls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectPreviews implements ProjectPreviews {
   _ProjectPreviews({required this.projectId, this.userName, required this.projectName, required this.recordNum, this.lastRecordAt, final  List<String>? recentImageUrls}): _recentImageUrls = recentImageUrls;
  factory _ProjectPreviews.fromJson(Map<String, dynamic> json) => _$ProjectPreviewsFromJson(json);

@override final  int projectId;
@override final  String? userName;
@override final  String projectName;
@override final  int recordNum;
@override final  DateTime? lastRecordAt;
 final  List<String>? _recentImageUrls;
@override List<String>? get recentImageUrls {
  final value = _recentImageUrls;
  if (value == null) return null;
  if (_recentImageUrls is EqualUnmodifiableListView) return _recentImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ProjectPreviews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectPreviewsCopyWith<_ProjectPreviews> get copyWith => __$ProjectPreviewsCopyWithImpl<_ProjectPreviews>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectPreviewsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectPreviews&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.recordNum, recordNum) || other.recordNum == recordNum)&&(identical(other.lastRecordAt, lastRecordAt) || other.lastRecordAt == lastRecordAt)&&const DeepCollectionEquality().equals(other._recentImageUrls, _recentImageUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,userName,projectName,recordNum,lastRecordAt,const DeepCollectionEquality().hash(_recentImageUrls));

@override
String toString() {
  return 'ProjectPreviews(projectId: $projectId, userName: $userName, projectName: $projectName, recordNum: $recordNum, lastRecordAt: $lastRecordAt, recentImageUrls: $recentImageUrls)';
}


}

/// @nodoc
abstract mixin class _$ProjectPreviewsCopyWith<$Res> implements $ProjectPreviewsCopyWith<$Res> {
  factory _$ProjectPreviewsCopyWith(_ProjectPreviews value, $Res Function(_ProjectPreviews) _then) = __$ProjectPreviewsCopyWithImpl;
@override @useResult
$Res call({
 int projectId, String? userName, String projectName, int recordNum, DateTime? lastRecordAt, List<String>? recentImageUrls
});




}
/// @nodoc
class __$ProjectPreviewsCopyWithImpl<$Res>
    implements _$ProjectPreviewsCopyWith<$Res> {
  __$ProjectPreviewsCopyWithImpl(this._self, this._then);

  final _ProjectPreviews _self;
  final $Res Function(_ProjectPreviews) _then;

/// Create a copy of ProjectPreviews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? userName = freezed,Object? projectName = null,Object? recordNum = null,Object? lastRecordAt = freezed,Object? recentImageUrls = freezed,}) {
  return _then(_ProjectPreviews(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,recordNum: null == recordNum ? _self.recordNum : recordNum // ignore: cast_nullable_to_non_nullable
as int,lastRecordAt: freezed == lastRecordAt ? _self.lastRecordAt : lastRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recentImageUrls: freezed == recentImageUrls ? _self._recentImageUrls : recentImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
