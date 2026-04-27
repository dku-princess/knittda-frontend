// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Project {

 int? get id; Design? get design; int? get userId; String get nickname; String? get status; String? get thumbnailUrl; DateTime? get lastRecordAt; DateTime? get createdAt; String get startDate; String? get endDate; String get goalDate; int? get projectId; String? get yarnInfo; String? get needleInfo; String? get designTitle; String? get designer; bool? get visible;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, id) || other.id == id)&&(identical(other.design, design) || other.design == design)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.lastRecordAt, lastRecordAt) || other.lastRecordAt == lastRecordAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.goalDate, goalDate) || other.goalDate == goalDate)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.yarnInfo, yarnInfo) || other.yarnInfo == yarnInfo)&&(identical(other.needleInfo, needleInfo) || other.needleInfo == needleInfo)&&(identical(other.designTitle, designTitle) || other.designTitle == designTitle)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.visible, visible) || other.visible == visible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,design,userId,nickname,status,thumbnailUrl,lastRecordAt,createdAt,startDate,endDate,goalDate,projectId,yarnInfo,needleInfo,designTitle,designer,visible);

@override
String toString() {
  return 'Project(id: $id, design: $design, userId: $userId, nickname: $nickname, status: $status, thumbnailUrl: $thumbnailUrl, lastRecordAt: $lastRecordAt, createdAt: $createdAt, startDate: $startDate, endDate: $endDate, goalDate: $goalDate, projectId: $projectId, yarnInfo: $yarnInfo, needleInfo: $needleInfo, designTitle: $designTitle, designer: $designer, visible: $visible)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 int? id, Design? design, int? userId, String nickname, String? status, String? thumbnailUrl, DateTime? lastRecordAt, DateTime? createdAt, String startDate, String? endDate, String goalDate, int? projectId, String? yarnInfo, String? needleInfo, String? designTitle, String? designer, bool? visible
});


$DesignCopyWith<$Res>? get design;

}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? design = freezed,Object? userId = freezed,Object? nickname = null,Object? status = freezed,Object? thumbnailUrl = freezed,Object? lastRecordAt = freezed,Object? createdAt = freezed,Object? startDate = null,Object? endDate = freezed,Object? goalDate = null,Object? projectId = freezed,Object? yarnInfo = freezed,Object? needleInfo = freezed,Object? designTitle = freezed,Object? designer = freezed,Object? visible = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,design: freezed == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as Design?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,lastRecordAt: freezed == lastRecordAt ? _self.lastRecordAt : lastRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,goalDate: null == goalDate ? _self.goalDate : goalDate // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,yarnInfo: freezed == yarnInfo ? _self.yarnInfo : yarnInfo // ignore: cast_nullable_to_non_nullable
as String?,needleInfo: freezed == needleInfo ? _self.needleInfo : needleInfo // ignore: cast_nullable_to_non_nullable
as String?,designTitle: freezed == designTitle ? _self.designTitle : designTitle // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesignCopyWith<$Res>? get design {
    if (_self.design == null) {
    return null;
  }

  return $DesignCopyWith<$Res>(_self.design!, (value) {
    return _then(_self.copyWith(design: value));
  });
}
}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  Design? design,  int? userId,  String nickname,  String? status,  String? thumbnailUrl,  DateTime? lastRecordAt,  DateTime? createdAt,  String startDate,  String? endDate,  String goalDate,  int? projectId,  String? yarnInfo,  String? needleInfo,  String? designTitle,  String? designer,  bool? visible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.design,_that.userId,_that.nickname,_that.status,_that.thumbnailUrl,_that.lastRecordAt,_that.createdAt,_that.startDate,_that.endDate,_that.goalDate,_that.projectId,_that.yarnInfo,_that.needleInfo,_that.designTitle,_that.designer,_that.visible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  Design? design,  int? userId,  String nickname,  String? status,  String? thumbnailUrl,  DateTime? lastRecordAt,  DateTime? createdAt,  String startDate,  String? endDate,  String goalDate,  int? projectId,  String? yarnInfo,  String? needleInfo,  String? designTitle,  String? designer,  bool? visible)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.design,_that.userId,_that.nickname,_that.status,_that.thumbnailUrl,_that.lastRecordAt,_that.createdAt,_that.startDate,_that.endDate,_that.goalDate,_that.projectId,_that.yarnInfo,_that.needleInfo,_that.designTitle,_that.designer,_that.visible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  Design? design,  int? userId,  String nickname,  String? status,  String? thumbnailUrl,  DateTime? lastRecordAt,  DateTime? createdAt,  String startDate,  String? endDate,  String goalDate,  int? projectId,  String? yarnInfo,  String? needleInfo,  String? designTitle,  String? designer,  bool? visible)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.design,_that.userId,_that.nickname,_that.status,_that.thumbnailUrl,_that.lastRecordAt,_that.createdAt,_that.startDate,_that.endDate,_that.goalDate,_that.projectId,_that.yarnInfo,_that.needleInfo,_that.designTitle,_that.designer,_that.visible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
   _Project({this.id, this.design, this.userId, required this.nickname, this.status, this.thumbnailUrl, this.lastRecordAt, this.createdAt, required this.startDate, this.endDate, required this.goalDate, this.projectId, this.yarnInfo, this.needleInfo, this.designTitle, this.designer, this.visible});
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  int? id;
@override final  Design? design;
@override final  int? userId;
@override final  String nickname;
@override final  String? status;
@override final  String? thumbnailUrl;
@override final  DateTime? lastRecordAt;
@override final  DateTime? createdAt;
@override final  String startDate;
@override final  String? endDate;
@override final  String goalDate;
@override final  int? projectId;
@override final  String? yarnInfo;
@override final  String? needleInfo;
@override final  String? designTitle;
@override final  String? designer;
@override final  bool? visible;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.design, design) || other.design == design)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.lastRecordAt, lastRecordAt) || other.lastRecordAt == lastRecordAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.goalDate, goalDate) || other.goalDate == goalDate)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.yarnInfo, yarnInfo) || other.yarnInfo == yarnInfo)&&(identical(other.needleInfo, needleInfo) || other.needleInfo == needleInfo)&&(identical(other.designTitle, designTitle) || other.designTitle == designTitle)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.visible, visible) || other.visible == visible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,design,userId,nickname,status,thumbnailUrl,lastRecordAt,createdAt,startDate,endDate,goalDate,projectId,yarnInfo,needleInfo,designTitle,designer,visible);

@override
String toString() {
  return 'Project(id: $id, design: $design, userId: $userId, nickname: $nickname, status: $status, thumbnailUrl: $thumbnailUrl, lastRecordAt: $lastRecordAt, createdAt: $createdAt, startDate: $startDate, endDate: $endDate, goalDate: $goalDate, projectId: $projectId, yarnInfo: $yarnInfo, needleInfo: $needleInfo, designTitle: $designTitle, designer: $designer, visible: $visible)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 int? id, Design? design, int? userId, String nickname, String? status, String? thumbnailUrl, DateTime? lastRecordAt, DateTime? createdAt, String startDate, String? endDate, String goalDate, int? projectId, String? yarnInfo, String? needleInfo, String? designTitle, String? designer, bool? visible
});


@override $DesignCopyWith<$Res>? get design;

}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? design = freezed,Object? userId = freezed,Object? nickname = null,Object? status = freezed,Object? thumbnailUrl = freezed,Object? lastRecordAt = freezed,Object? createdAt = freezed,Object? startDate = null,Object? endDate = freezed,Object? goalDate = null,Object? projectId = freezed,Object? yarnInfo = freezed,Object? needleInfo = freezed,Object? designTitle = freezed,Object? designer = freezed,Object? visible = freezed,}) {
  return _then(_Project(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,design: freezed == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as Design?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,lastRecordAt: freezed == lastRecordAt ? _self.lastRecordAt : lastRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,goalDate: null == goalDate ? _self.goalDate : goalDate // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,yarnInfo: freezed == yarnInfo ? _self.yarnInfo : yarnInfo // ignore: cast_nullable_to_non_nullable
as String?,needleInfo: freezed == needleInfo ? _self.needleInfo : needleInfo // ignore: cast_nullable_to_non_nullable
as String?,designTitle: freezed == designTitle ? _self.designTitle : designTitle // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesignCopyWith<$Res>? get design {
    if (_self.design == null) {
    return null;
  }

  return $DesignCopyWith<$Res>(_self.design!, (value) {
    return _then(_self.copyWith(design: value));
  });
}
}

// dart format on
