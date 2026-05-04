// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectSection {

 int get id; String get title; String get description;@JsonKey(name: 'project_item_block') List<ProjectItemBlock> get projectItemBlock;
/// Create a copy of ProjectSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectSectionCopyWith<ProjectSection> get copyWith => _$ProjectSectionCopyWithImpl<ProjectSection>(this as ProjectSection, _$identity);

  /// Serializes this ProjectSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.projectItemBlock, projectItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(projectItemBlock));

@override
String toString() {
  return 'ProjectSection(id: $id, title: $title, description: $description, projectItemBlock: $projectItemBlock)';
}


}

/// @nodoc
abstract mixin class $ProjectSectionCopyWith<$Res>  {
  factory $ProjectSectionCopyWith(ProjectSection value, $Res Function(ProjectSection) _then) = _$ProjectSectionCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description,@JsonKey(name: 'project_item_block') List<ProjectItemBlock> projectItemBlock
});




}
/// @nodoc
class _$ProjectSectionCopyWithImpl<$Res>
    implements $ProjectSectionCopyWith<$Res> {
  _$ProjectSectionCopyWithImpl(this._self, this._then);

  final ProjectSection _self;
  final $Res Function(ProjectSection) _then;

/// Create a copy of ProjectSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? projectItemBlock = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,projectItemBlock: null == projectItemBlock ? _self.projectItemBlock : projectItemBlock // ignore: cast_nullable_to_non_nullable
as List<ProjectItemBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectSection].
extension ProjectSectionPatterns on ProjectSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectSection value)  $default,){
final _that = this;
switch (_that) {
case _ProjectSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectSection value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description, @JsonKey(name: 'project_item_block')  List<ProjectItemBlock> projectItemBlock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.projectItemBlock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description, @JsonKey(name: 'project_item_block')  List<ProjectItemBlock> projectItemBlock)  $default,) {final _that = this;
switch (_that) {
case _ProjectSection():
return $default(_that.id,_that.title,_that.description,_that.projectItemBlock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description, @JsonKey(name: 'project_item_block')  List<ProjectItemBlock> projectItemBlock)?  $default,) {final _that = this;
switch (_that) {
case _ProjectSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.projectItemBlock);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectSection implements ProjectSection {
  const _ProjectSection({this.id = 0, this.title = '', this.description = '', @JsonKey(name: 'project_item_block') final  List<ProjectItemBlock> projectItemBlock = const []}): _projectItemBlock = projectItemBlock;
  factory _ProjectSection.fromJson(Map<String, dynamic> json) => _$ProjectSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
 final  List<ProjectItemBlock> _projectItemBlock;
@override@JsonKey(name: 'project_item_block') List<ProjectItemBlock> get projectItemBlock {
  if (_projectItemBlock is EqualUnmodifiableListView) return _projectItemBlock;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projectItemBlock);
}


/// Create a copy of ProjectSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectSectionCopyWith<_ProjectSection> get copyWith => __$ProjectSectionCopyWithImpl<_ProjectSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._projectItemBlock, _projectItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(_projectItemBlock));

@override
String toString() {
  return 'ProjectSection(id: $id, title: $title, description: $description, projectItemBlock: $projectItemBlock)';
}


}

/// @nodoc
abstract mixin class _$ProjectSectionCopyWith<$Res> implements $ProjectSectionCopyWith<$Res> {
  factory _$ProjectSectionCopyWith(_ProjectSection value, $Res Function(_ProjectSection) _then) = __$ProjectSectionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description,@JsonKey(name: 'project_item_block') List<ProjectItemBlock> projectItemBlock
});




}
/// @nodoc
class __$ProjectSectionCopyWithImpl<$Res>
    implements _$ProjectSectionCopyWith<$Res> {
  __$ProjectSectionCopyWithImpl(this._self, this._then);

  final _ProjectSection _self;
  final $Res Function(_ProjectSection) _then;

/// Create a copy of ProjectSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? projectItemBlock = null,}) {
  return _then(_ProjectSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,projectItemBlock: null == projectItemBlock ? _self._projectItemBlock : projectItemBlock // ignore: cast_nullable_to_non_nullable
as List<ProjectItemBlock>,
  ));
}


}


/// @nodoc
mixin _$ProjectItemBlock {

 int get id; String get status;@JsonKey(name: 'project_id') int get projectId;
/// Create a copy of ProjectItemBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectItemBlockCopyWith<ProjectItemBlock> get copyWith => _$ProjectItemBlockCopyWithImpl<ProjectItemBlock>(this as ProjectItemBlock, _$identity);

  /// Serializes this ProjectItemBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.projectId, projectId) || other.projectId == projectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,projectId);

@override
String toString() {
  return 'ProjectItemBlock(id: $id, status: $status, projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class $ProjectItemBlockCopyWith<$Res>  {
  factory $ProjectItemBlockCopyWith(ProjectItemBlock value, $Res Function(ProjectItemBlock) _then) = _$ProjectItemBlockCopyWithImpl;
@useResult
$Res call({
 int id, String status,@JsonKey(name: 'project_id') int projectId
});




}
/// @nodoc
class _$ProjectItemBlockCopyWithImpl<$Res>
    implements $ProjectItemBlockCopyWith<$Res> {
  _$ProjectItemBlockCopyWithImpl(this._self, this._then);

  final ProjectItemBlock _self;
  final $Res Function(ProjectItemBlock) _then;

/// Create a copy of ProjectItemBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? projectId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectItemBlock].
extension ProjectItemBlockPatterns on ProjectItemBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectItemBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectItemBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectItemBlock value)  $default,){
final _that = this;
switch (_that) {
case _ProjectItemBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectItemBlock value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectItemBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String status, @JsonKey(name: 'project_id')  int projectId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectItemBlock() when $default != null:
return $default(_that.id,_that.status,_that.projectId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String status, @JsonKey(name: 'project_id')  int projectId)  $default,) {final _that = this;
switch (_that) {
case _ProjectItemBlock():
return $default(_that.id,_that.status,_that.projectId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String status, @JsonKey(name: 'project_id')  int projectId)?  $default,) {final _that = this;
switch (_that) {
case _ProjectItemBlock() when $default != null:
return $default(_that.id,_that.status,_that.projectId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectItemBlock implements ProjectItemBlock {
  const _ProjectItemBlock({this.id = 0, this.status = '', @JsonKey(name: 'project_id') this.projectId = 0});
  factory _ProjectItemBlock.fromJson(Map<String, dynamic> json) => _$ProjectItemBlockFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'project_id') final  int projectId;

/// Create a copy of ProjectItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectItemBlockCopyWith<_ProjectItemBlock> get copyWith => __$ProjectItemBlockCopyWithImpl<_ProjectItemBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectItemBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.projectId, projectId) || other.projectId == projectId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,projectId);

@override
String toString() {
  return 'ProjectItemBlock(id: $id, status: $status, projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class _$ProjectItemBlockCopyWith<$Res> implements $ProjectItemBlockCopyWith<$Res> {
  factory _$ProjectItemBlockCopyWith(_ProjectItemBlock value, $Res Function(_ProjectItemBlock) _then) = __$ProjectItemBlockCopyWithImpl;
@override @useResult
$Res call({
 int id, String status,@JsonKey(name: 'project_id') int projectId
});




}
/// @nodoc
class __$ProjectItemBlockCopyWithImpl<$Res>
    implements _$ProjectItemBlockCopyWith<$Res> {
  __$ProjectItemBlockCopyWithImpl(this._self, this._then);

  final _ProjectItemBlock _self;
  final $Res Function(_ProjectItemBlock) _then;

/// Create a copy of ProjectItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? projectId = null,}) {
  return _then(_ProjectItemBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
