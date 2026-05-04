// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_previews_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectPreviewsState {

 List<ProjectPreviews> get projectPreviews; bool get isLoading; String? get errorMessage;
/// Create a copy of ProjectPreviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectPreviewsStateCopyWith<ProjectPreviewsState> get copyWith => _$ProjectPreviewsStateCopyWithImpl<ProjectPreviewsState>(this as ProjectPreviewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectPreviewsState&&const DeepCollectionEquality().equals(other.projectPreviews, projectPreviews)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(projectPreviews),isLoading,errorMessage);

@override
String toString() {
  return 'ProjectPreviewsState(projectPreviews: $projectPreviews, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProjectPreviewsStateCopyWith<$Res>  {
  factory $ProjectPreviewsStateCopyWith(ProjectPreviewsState value, $Res Function(ProjectPreviewsState) _then) = _$ProjectPreviewsStateCopyWithImpl;
@useResult
$Res call({
 List<ProjectPreviews> projectPreviews, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$ProjectPreviewsStateCopyWithImpl<$Res>
    implements $ProjectPreviewsStateCopyWith<$Res> {
  _$ProjectPreviewsStateCopyWithImpl(this._self, this._then);

  final ProjectPreviewsState _self;
  final $Res Function(ProjectPreviewsState) _then;

/// Create a copy of ProjectPreviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectPreviews = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
projectPreviews: null == projectPreviews ? _self.projectPreviews : projectPreviews // ignore: cast_nullable_to_non_nullable
as List<ProjectPreviews>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectPreviewsState].
extension ProjectPreviewsStatePatterns on ProjectPreviewsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectPreviewsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectPreviewsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectPreviewsState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectPreviewsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectPreviewsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectPreviewsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProjectPreviews> projectPreviews,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectPreviewsState() when $default != null:
return $default(_that.projectPreviews,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProjectPreviews> projectPreviews,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProjectPreviewsState():
return $default(_that.projectPreviews,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProjectPreviews> projectPreviews,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProjectPreviewsState() when $default != null:
return $default(_that.projectPreviews,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectPreviewsState implements ProjectPreviewsState {
   _ProjectPreviewsState(final  List<ProjectPreviews> projectPreviews, this.isLoading, this.errorMessage): _projectPreviews = projectPreviews;
  

 final  List<ProjectPreviews> _projectPreviews;
@override List<ProjectPreviews> get projectPreviews {
  if (_projectPreviews is EqualUnmodifiableListView) return _projectPreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projectPreviews);
}

@override final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of ProjectPreviewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectPreviewsStateCopyWith<_ProjectPreviewsState> get copyWith => __$ProjectPreviewsStateCopyWithImpl<_ProjectPreviewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectPreviewsState&&const DeepCollectionEquality().equals(other._projectPreviews, _projectPreviews)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_projectPreviews),isLoading,errorMessage);

@override
String toString() {
  return 'ProjectPreviewsState(projectPreviews: $projectPreviews, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProjectPreviewsStateCopyWith<$Res> implements $ProjectPreviewsStateCopyWith<$Res> {
  factory _$ProjectPreviewsStateCopyWith(_ProjectPreviewsState value, $Res Function(_ProjectPreviewsState) _then) = __$ProjectPreviewsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProjectPreviews> projectPreviews, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$ProjectPreviewsStateCopyWithImpl<$Res>
    implements _$ProjectPreviewsStateCopyWith<$Res> {
  __$ProjectPreviewsStateCopyWithImpl(this._self, this._then);

  final _ProjectPreviewsState _self;
  final $Res Function(_ProjectPreviewsState) _then;

/// Create a copy of ProjectPreviewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectPreviews = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_ProjectPreviewsState(
null == projectPreviews ? _self._projectPreviews : projectPreviews // ignore: cast_nullable_to_non_nullable
as List<ProjectPreviews>,null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
