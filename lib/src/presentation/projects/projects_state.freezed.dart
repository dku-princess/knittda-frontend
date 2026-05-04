// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectsState {

 List<Project> get projects; bool get isLoading; String? get errorMessage; ProjectOrder get projectOrder;
/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectsStateCopyWith<ProjectsState> get copyWith => _$ProjectsStateCopyWithImpl<ProjectsState>(this as ProjectsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsState&&const DeepCollectionEquality().equals(other.projects, projects)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.projectOrder, projectOrder) || other.projectOrder == projectOrder));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(projects),isLoading,errorMessage,projectOrder);

@override
String toString() {
  return 'ProjectsState(projects: $projects, isLoading: $isLoading, errorMessage: $errorMessage, projectOrder: $projectOrder)';
}


}

/// @nodoc
abstract mixin class $ProjectsStateCopyWith<$Res>  {
  factory $ProjectsStateCopyWith(ProjectsState value, $Res Function(ProjectsState) _then) = _$ProjectsStateCopyWithImpl;
@useResult
$Res call({
 List<Project> projects, bool isLoading, String? errorMessage, ProjectOrder projectOrder
});


$ProjectOrderCopyWith<$Res> get projectOrder;

}
/// @nodoc
class _$ProjectsStateCopyWithImpl<$Res>
    implements $ProjectsStateCopyWith<$Res> {
  _$ProjectsStateCopyWithImpl(this._self, this._then);

  final ProjectsState _self;
  final $Res Function(ProjectsState) _then;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projects = null,Object? isLoading = null,Object? errorMessage = freezed,Object? projectOrder = null,}) {
  return _then(_self.copyWith(
projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,projectOrder: null == projectOrder ? _self.projectOrder : projectOrder // ignore: cast_nullable_to_non_nullable
as ProjectOrder,
  ));
}
/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectOrderCopyWith<$Res> get projectOrder {
  
  return $ProjectOrderCopyWith<$Res>(_self.projectOrder, (value) {
    return _then(_self.copyWith(projectOrder: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectsState].
extension ProjectsStatePatterns on ProjectsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectsState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Project> projects,  bool isLoading,  String? errorMessage,  ProjectOrder projectOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectsState() when $default != null:
return $default(_that.projects,_that.isLoading,_that.errorMessage,_that.projectOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Project> projects,  bool isLoading,  String? errorMessage,  ProjectOrder projectOrder)  $default,) {final _that = this;
switch (_that) {
case _ProjectsState():
return $default(_that.projects,_that.isLoading,_that.errorMessage,_that.projectOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Project> projects,  bool isLoading,  String? errorMessage,  ProjectOrder projectOrder)?  $default,) {final _that = this;
switch (_that) {
case _ProjectsState() when $default != null:
return $default(_that.projects,_that.isLoading,_that.errorMessage,_that.projectOrder);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectsState implements ProjectsState {
   _ProjectsState(final  List<Project> projects, this.isLoading, this.errorMessage, this.projectOrder): _projects = projects;
  

 final  List<Project> _projects;
@override List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override final  bool isLoading;
@override final  String? errorMessage;
@override final  ProjectOrder projectOrder;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectsStateCopyWith<_ProjectsState> get copyWith => __$ProjectsStateCopyWithImpl<_ProjectsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectsState&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.projectOrder, projectOrder) || other.projectOrder == projectOrder));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_projects),isLoading,errorMessage,projectOrder);

@override
String toString() {
  return 'ProjectsState(projects: $projects, isLoading: $isLoading, errorMessage: $errorMessage, projectOrder: $projectOrder)';
}


}

/// @nodoc
abstract mixin class _$ProjectsStateCopyWith<$Res> implements $ProjectsStateCopyWith<$Res> {
  factory _$ProjectsStateCopyWith(_ProjectsState value, $Res Function(_ProjectsState) _then) = __$ProjectsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Project> projects, bool isLoading, String? errorMessage, ProjectOrder projectOrder
});


@override $ProjectOrderCopyWith<$Res> get projectOrder;

}
/// @nodoc
class __$ProjectsStateCopyWithImpl<$Res>
    implements _$ProjectsStateCopyWith<$Res> {
  __$ProjectsStateCopyWithImpl(this._self, this._then);

  final _ProjectsState _self;
  final $Res Function(_ProjectsState) _then;

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projects = null,Object? isLoading = null,Object? errorMessage = freezed,Object? projectOrder = null,}) {
  return _then(_ProjectsState(
null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,null == projectOrder ? _self.projectOrder : projectOrder // ignore: cast_nullable_to_non_nullable
as ProjectOrder,
  ));
}

/// Create a copy of ProjectsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectOrderCopyWith<$Res> get projectOrder {
  
  return $ProjectOrderCopyWith<$Res>(_self.projectOrder, (value) {
    return _then(_self.copyWith(projectOrder: value));
  });
}
}

// dart format on
