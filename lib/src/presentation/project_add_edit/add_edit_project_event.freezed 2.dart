// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_edit_project_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddEditProjectEvent {

 Project get project; XFile? get file;
/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddEditProjectEventCopyWith<AddEditProjectEvent> get copyWith => _$AddEditProjectEventCopyWithImpl<AddEditProjectEvent>(this as AddEditProjectEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddEditProjectEvent&&(identical(other.project, project) || other.project == project)&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,project,file);

@override
String toString() {
  return 'AddEditProjectEvent(project: $project, file: $file)';
}


}

/// @nodoc
abstract mixin class $AddEditProjectEventCopyWith<$Res>  {
  factory $AddEditProjectEventCopyWith(AddEditProjectEvent value, $Res Function(AddEditProjectEvent) _then) = _$AddEditProjectEventCopyWithImpl;
@useResult
$Res call({
 Project project, XFile? file
});


$ProjectCopyWith<$Res> get project;

}
/// @nodoc
class _$AddEditProjectEventCopyWithImpl<$Res>
    implements $AddEditProjectEventCopyWith<$Res> {
  _$AddEditProjectEventCopyWithImpl(this._self, this._then);

  final AddEditProjectEvent _self;
  final $Res Function(AddEditProjectEvent) _then;

/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? project = null,Object? file = freezed,}) {
  return _then(_self.copyWith(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}
/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddEditProjectEvent].
extension AddEditProjectEventPatterns on AddEditProjectEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SaveProject value)?  saveProject,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SaveProject() when saveProject != null:
return saveProject(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SaveProject value)  saveProject,}){
final _that = this;
switch (_that) {
case SaveProject():
return saveProject(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SaveProject value)?  saveProject,}){
final _that = this;
switch (_that) {
case SaveProject() when saveProject != null:
return saveProject(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Project project,  XFile? file)?  saveProject,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SaveProject() when saveProject != null:
return saveProject(_that.project,_that.file);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Project project,  XFile? file)  saveProject,}) {final _that = this;
switch (_that) {
case SaveProject():
return saveProject(_that.project,_that.file);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Project project,  XFile? file)?  saveProject,}) {final _that = this;
switch (_that) {
case SaveProject() when saveProject != null:
return saveProject(_that.project,_that.file);case _:
  return null;

}
}

}

/// @nodoc


class SaveProject implements AddEditProjectEvent {
  const SaveProject({required this.project, required this.file});
  

@override final  Project project;
@override final  XFile? file;

/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveProjectCopyWith<SaveProject> get copyWith => _$SaveProjectCopyWithImpl<SaveProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveProject&&(identical(other.project, project) || other.project == project)&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,project,file);

@override
String toString() {
  return 'AddEditProjectEvent.saveProject(project: $project, file: $file)';
}


}

/// @nodoc
abstract mixin class $SaveProjectCopyWith<$Res> implements $AddEditProjectEventCopyWith<$Res> {
  factory $SaveProjectCopyWith(SaveProject value, $Res Function(SaveProject) _then) = _$SaveProjectCopyWithImpl;
@override @useResult
$Res call({
 Project project, XFile? file
});


@override $ProjectCopyWith<$Res> get project;

}
/// @nodoc
class _$SaveProjectCopyWithImpl<$Res>
    implements $SaveProjectCopyWith<$Res> {
  _$SaveProjectCopyWithImpl(this._self, this._then);

  final SaveProject _self;
  final $Res Function(SaveProject) _then;

/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? project = null,Object? file = freezed,}) {
  return _then(SaveProject(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}

/// Create a copy of AddEditProjectEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

// dart format on
