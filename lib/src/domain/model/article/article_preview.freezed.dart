// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticlePreview {

 int get projectId; String get projectName; String? get thumbnailUrl; String? get nickname;
/// Create a copy of ArticlePreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticlePreviewCopyWith<ArticlePreview> get copyWith => _$ArticlePreviewCopyWithImpl<ArticlePreview>(this as ArticlePreview, _$identity);

  /// Serializes this ArticlePreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticlePreview&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,projectName,thumbnailUrl,nickname);

@override
String toString() {
  return 'ArticlePreview(projectId: $projectId, projectName: $projectName, thumbnailUrl: $thumbnailUrl, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $ArticlePreviewCopyWith<$Res>  {
  factory $ArticlePreviewCopyWith(ArticlePreview value, $Res Function(ArticlePreview) _then) = _$ArticlePreviewCopyWithImpl;
@useResult
$Res call({
 int projectId, String projectName, String? thumbnailUrl, String? nickname
});




}
/// @nodoc
class _$ArticlePreviewCopyWithImpl<$Res>
    implements $ArticlePreviewCopyWith<$Res> {
  _$ArticlePreviewCopyWithImpl(this._self, this._then);

  final ArticlePreview _self;
  final $Res Function(ArticlePreview) _then;

/// Create a copy of ArticlePreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? projectName = null,Object? thumbnailUrl = freezed,Object? nickname = freezed,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticlePreview].
extension ArticlePreviewPatterns on ArticlePreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticlePreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticlePreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticlePreview value)  $default,){
final _that = this;
switch (_that) {
case _ArticlePreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticlePreview value)?  $default,){
final _that = this;
switch (_that) {
case _ArticlePreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int projectId,  String projectName,  String? thumbnailUrl,  String? nickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticlePreview() when $default != null:
return $default(_that.projectId,_that.projectName,_that.thumbnailUrl,_that.nickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int projectId,  String projectName,  String? thumbnailUrl,  String? nickname)  $default,) {final _that = this;
switch (_that) {
case _ArticlePreview():
return $default(_that.projectId,_that.projectName,_that.thumbnailUrl,_that.nickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int projectId,  String projectName,  String? thumbnailUrl,  String? nickname)?  $default,) {final _that = this;
switch (_that) {
case _ArticlePreview() when $default != null:
return $default(_that.projectId,_that.projectName,_that.thumbnailUrl,_that.nickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticlePreview implements ArticlePreview {
   _ArticlePreview({required this.projectId, required this.projectName, this.thumbnailUrl, this.nickname});
  factory _ArticlePreview.fromJson(Map<String, dynamic> json) => _$ArticlePreviewFromJson(json);

@override final  int projectId;
@override final  String projectName;
@override final  String? thumbnailUrl;
@override final  String? nickname;

/// Create a copy of ArticlePreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticlePreviewCopyWith<_ArticlePreview> get copyWith => __$ArticlePreviewCopyWithImpl<_ArticlePreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticlePreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticlePreview&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,projectName,thumbnailUrl,nickname);

@override
String toString() {
  return 'ArticlePreview(projectId: $projectId, projectName: $projectName, thumbnailUrl: $thumbnailUrl, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class _$ArticlePreviewCopyWith<$Res> implements $ArticlePreviewCopyWith<$Res> {
  factory _$ArticlePreviewCopyWith(_ArticlePreview value, $Res Function(_ArticlePreview) _then) = __$ArticlePreviewCopyWithImpl;
@override @useResult
$Res call({
 int projectId, String projectName, String? thumbnailUrl, String? nickname
});




}
/// @nodoc
class __$ArticlePreviewCopyWithImpl<$Res>
    implements _$ArticlePreviewCopyWith<$Res> {
  __$ArticlePreviewCopyWithImpl(this._self, this._then);

  final _ArticlePreview _self;
  final $Res Function(_ArticlePreview) _then;

/// Create a copy of ArticlePreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? projectName = null,Object? thumbnailUrl = freezed,Object? nickname = freezed,}) {
  return _then(_ArticlePreview(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ArticlePreviewData {

 int get num; List<ArticlePreview> get projects;
/// Create a copy of ArticlePreviewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticlePreviewDataCopyWith<ArticlePreviewData> get copyWith => _$ArticlePreviewDataCopyWithImpl<ArticlePreviewData>(this as ArticlePreviewData, _$identity);

  /// Serializes this ArticlePreviewData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticlePreviewData&&(identical(other.num, num) || other.num == num)&&const DeepCollectionEquality().equals(other.projects, projects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,const DeepCollectionEquality().hash(projects));

@override
String toString() {
  return 'ArticlePreviewData(num: $num, projects: $projects)';
}


}

/// @nodoc
abstract mixin class $ArticlePreviewDataCopyWith<$Res>  {
  factory $ArticlePreviewDataCopyWith(ArticlePreviewData value, $Res Function(ArticlePreviewData) _then) = _$ArticlePreviewDataCopyWithImpl;
@useResult
$Res call({
 int num, List<ArticlePreview> projects
});




}
/// @nodoc
class _$ArticlePreviewDataCopyWithImpl<$Res>
    implements $ArticlePreviewDataCopyWith<$Res> {
  _$ArticlePreviewDataCopyWithImpl(this._self, this._then);

  final ArticlePreviewData _self;
  final $Res Function(ArticlePreviewData) _then;

/// Create a copy of ArticlePreviewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? num = null,Object? projects = null,}) {
  return _then(_self.copyWith(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<ArticlePreview>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticlePreviewData].
extension ArticlePreviewDataPatterns on ArticlePreviewData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticlePreviewData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticlePreviewData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticlePreviewData value)  $default,){
final _that = this;
switch (_that) {
case _ArticlePreviewData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticlePreviewData value)?  $default,){
final _that = this;
switch (_that) {
case _ArticlePreviewData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int num,  List<ArticlePreview> projects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticlePreviewData() when $default != null:
return $default(_that.num,_that.projects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int num,  List<ArticlePreview> projects)  $default,) {final _that = this;
switch (_that) {
case _ArticlePreviewData():
return $default(_that.num,_that.projects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int num,  List<ArticlePreview> projects)?  $default,) {final _that = this;
switch (_that) {
case _ArticlePreviewData() when $default != null:
return $default(_that.num,_that.projects);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticlePreviewData implements ArticlePreviewData {
   _ArticlePreviewData({required this.num, required final  List<ArticlePreview> projects}): _projects = projects;
  factory _ArticlePreviewData.fromJson(Map<String, dynamic> json) => _$ArticlePreviewDataFromJson(json);

@override final  int num;
 final  List<ArticlePreview> _projects;
@override List<ArticlePreview> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}


/// Create a copy of ArticlePreviewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticlePreviewDataCopyWith<_ArticlePreviewData> get copyWith => __$ArticlePreviewDataCopyWithImpl<_ArticlePreviewData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticlePreviewDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticlePreviewData&&(identical(other.num, num) || other.num == num)&&const DeepCollectionEquality().equals(other._projects, _projects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,num,const DeepCollectionEquality().hash(_projects));

@override
String toString() {
  return 'ArticlePreviewData(num: $num, projects: $projects)';
}


}

/// @nodoc
abstract mixin class _$ArticlePreviewDataCopyWith<$Res> implements $ArticlePreviewDataCopyWith<$Res> {
  factory _$ArticlePreviewDataCopyWith(_ArticlePreviewData value, $Res Function(_ArticlePreviewData) _then) = __$ArticlePreviewDataCopyWithImpl;
@override @useResult
$Res call({
 int num, List<ArticlePreview> projects
});




}
/// @nodoc
class __$ArticlePreviewDataCopyWithImpl<$Res>
    implements _$ArticlePreviewDataCopyWith<$Res> {
  __$ArticlePreviewDataCopyWithImpl(this._self, this._then);

  final _ArticlePreviewData _self;
  final $Res Function(_ArticlePreviewData) _then;

/// Create a copy of ArticlePreviewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? num = null,Object? projects = null,}) {
  return _then(_ArticlePreviewData(
num: null == num ? _self.num : num // ignore: cast_nullable_to_non_nullable
as int,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ArticlePreview>,
  ));
}


}

// dart format on
