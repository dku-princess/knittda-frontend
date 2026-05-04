// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectDetailsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDetailsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailsEvent()';
}


}

/// @nodoc
class $ProjectDetailsEventCopyWith<$Res>  {
$ProjectDetailsEventCopyWith(ProjectDetailsEvent _, $Res Function(ProjectDetailsEvent) __);
}


/// Adds pattern-matching-related methods to [ProjectDetailsEvent].
extension ProjectDetailsEventPatterns on ProjectDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProject value)?  loadProject,TResult Function( DeleteProject value)?  deleteProject,TResult Function( ChangeProgress value)?  changeProgress,TResult Function( LoadRecords value)?  loadRecords,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case DeleteProject() when deleteProject != null:
return deleteProject(_that);case ChangeProgress() when changeProgress != null:
return changeProgress(_that);case LoadRecords() when loadRecords != null:
return loadRecords(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProject value)  loadProject,required TResult Function( DeleteProject value)  deleteProject,required TResult Function( ChangeProgress value)  changeProgress,required TResult Function( LoadRecords value)  loadRecords,}){
final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that);case DeleteProject():
return deleteProject(_that);case ChangeProgress():
return changeProgress(_that);case LoadRecords():
return loadRecords(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProject value)?  loadProject,TResult? Function( DeleteProject value)?  deleteProject,TResult? Function( ChangeProgress value)?  changeProgress,TResult? Function( LoadRecords value)?  loadRecords,}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case DeleteProject() when deleteProject != null:
return deleteProject(_that);case ChangeProgress() when changeProgress != null:
return changeProgress(_that);case LoadRecords() when loadRecords != null:
return loadRecords(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int projectId,  Project? project)?  loadProject,TResult Function( int projectId)?  deleteProject,TResult Function()?  changeProgress,TResult Function( int projectId)?  loadRecords,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.projectId,_that.project);case DeleteProject() when deleteProject != null:
return deleteProject(_that.projectId);case ChangeProgress() when changeProgress != null:
return changeProgress();case LoadRecords() when loadRecords != null:
return loadRecords(_that.projectId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int projectId,  Project? project)  loadProject,required TResult Function( int projectId)  deleteProject,required TResult Function()  changeProgress,required TResult Function( int projectId)  loadRecords,}) {final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that.projectId,_that.project);case DeleteProject():
return deleteProject(_that.projectId);case ChangeProgress():
return changeProgress();case LoadRecords():
return loadRecords(_that.projectId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int projectId,  Project? project)?  loadProject,TResult? Function( int projectId)?  deleteProject,TResult? Function()?  changeProgress,TResult? Function( int projectId)?  loadRecords,}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.projectId,_that.project);case DeleteProject() when deleteProject != null:
return deleteProject(_that.projectId);case ChangeProgress() when changeProgress != null:
return changeProgress();case LoadRecords() when loadRecords != null:
return loadRecords(_that.projectId);case _:
  return null;

}
}

}

/// @nodoc


class LoadProject implements ProjectDetailsEvent {
  const LoadProject({required this.projectId, this.project});
  

 final  int projectId;
 final  Project? project;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProjectCopyWith<LoadProject> get copyWith => _$LoadProjectCopyWithImpl<LoadProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProject&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,projectId,project);

@override
String toString() {
  return 'ProjectDetailsEvent.loadProject(projectId: $projectId, project: $project)';
}


}

/// @nodoc
abstract mixin class $LoadProjectCopyWith<$Res> implements $ProjectDetailsEventCopyWith<$Res> {
  factory $LoadProjectCopyWith(LoadProject value, $Res Function(LoadProject) _then) = _$LoadProjectCopyWithImpl;
@useResult
$Res call({
 int projectId, Project? project
});


$ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class _$LoadProjectCopyWithImpl<$Res>
    implements $LoadProjectCopyWith<$Res> {
  _$LoadProjectCopyWithImpl(this._self, this._then);

  final LoadProject _self;
  final $Res Function(LoadProject) _then;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? project = freezed,}) {
  return _then(LoadProject(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,
  ));
}

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get project {
    if (_self.project == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.project!, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

/// @nodoc


class DeleteProject implements ProjectDetailsEvent {
  const DeleteProject({required this.projectId});
  

 final  int projectId;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteProjectCopyWith<DeleteProject> get copyWith => _$DeleteProjectCopyWithImpl<DeleteProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteProject&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode => Object.hash(runtimeType,projectId);

@override
String toString() {
  return 'ProjectDetailsEvent.deleteProject(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class $DeleteProjectCopyWith<$Res> implements $ProjectDetailsEventCopyWith<$Res> {
  factory $DeleteProjectCopyWith(DeleteProject value, $Res Function(DeleteProject) _then) = _$DeleteProjectCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class _$DeleteProjectCopyWithImpl<$Res>
    implements $DeleteProjectCopyWith<$Res> {
  _$DeleteProjectCopyWithImpl(this._self, this._then);

  final DeleteProject _self;
  final $Res Function(DeleteProject) _then;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(DeleteProject(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChangeProgress implements ProjectDetailsEvent {
  const ChangeProgress();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeProgress);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailsEvent.changeProgress()';
}


}




/// @nodoc


class LoadRecords implements ProjectDetailsEvent {
  const LoadRecords({required this.projectId});
  

 final  int projectId;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRecordsCopyWith<LoadRecords> get copyWith => _$LoadRecordsCopyWithImpl<LoadRecords>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRecords&&(identical(other.projectId, projectId) || other.projectId == projectId));
}


@override
int get hashCode => Object.hash(runtimeType,projectId);

@override
String toString() {
  return 'ProjectDetailsEvent.loadRecords(projectId: $projectId)';
}


}

/// @nodoc
abstract mixin class $LoadRecordsCopyWith<$Res> implements $ProjectDetailsEventCopyWith<$Res> {
  factory $LoadRecordsCopyWith(LoadRecords value, $Res Function(LoadRecords) _then) = _$LoadRecordsCopyWithImpl;
@useResult
$Res call({
 int projectId
});




}
/// @nodoc
class _$LoadRecordsCopyWithImpl<$Res>
    implements $LoadRecordsCopyWith<$Res> {
  _$LoadRecordsCopyWithImpl(this._self, this._then);

  final LoadRecords _self;
  final $Res Function(LoadRecords) _then;

/// Create a copy of ProjectDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectId = null,}) {
  return _then(LoadRecords(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
