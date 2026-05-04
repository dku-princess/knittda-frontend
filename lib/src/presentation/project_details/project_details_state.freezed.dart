// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectDetailsState {

 Project? get project; bool get isLoading; bool get isOwner; User? get user; DiaryTapState get diaryTapState;
/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectDetailsStateCopyWith<ProjectDetailsState> get copyWith => _$ProjectDetailsStateCopyWithImpl<ProjectDetailsState>(this as ProjectDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDetailsState&&(identical(other.project, project) || other.project == project)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.user, user) || other.user == user)&&(identical(other.diaryTapState, diaryTapState) || other.diaryTapState == diaryTapState));
}


@override
int get hashCode => Object.hash(runtimeType,project,isLoading,isOwner,user,diaryTapState);

@override
String toString() {
  return 'ProjectDetailsState(project: $project, isLoading: $isLoading, isOwner: $isOwner, user: $user, diaryTapState: $diaryTapState)';
}


}

/// @nodoc
abstract mixin class $ProjectDetailsStateCopyWith<$Res>  {
  factory $ProjectDetailsStateCopyWith(ProjectDetailsState value, $Res Function(ProjectDetailsState) _then) = _$ProjectDetailsStateCopyWithImpl;
@useResult
$Res call({
 Project? project, bool isLoading, bool isOwner, User? user, DiaryTapState diaryTapState
});


$ProjectCopyWith<$Res>? get project;$UserCopyWith<$Res>? get user;$DiaryTapStateCopyWith<$Res> get diaryTapState;

}
/// @nodoc
class _$ProjectDetailsStateCopyWithImpl<$Res>
    implements $ProjectDetailsStateCopyWith<$Res> {
  _$ProjectDetailsStateCopyWithImpl(this._self, this._then);

  final ProjectDetailsState _self;
  final $Res Function(ProjectDetailsState) _then;

/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? project = freezed,Object? isLoading = null,Object? isOwner = null,Object? user = freezed,Object? diaryTapState = null,}) {
  return _then(_self.copyWith(
project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,diaryTapState: null == diaryTapState ? _self.diaryTapState : diaryTapState // ignore: cast_nullable_to_non_nullable
as DiaryTapState,
  ));
}
/// Create a copy of ProjectDetailsState
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
}/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiaryTapStateCopyWith<$Res> get diaryTapState {
  
  return $DiaryTapStateCopyWith<$Res>(_self.diaryTapState, (value) {
    return _then(_self.copyWith(diaryTapState: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectDetailsState].
extension ProjectDetailsStatePatterns on ProjectDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Project? project,  bool isLoading,  bool isOwner,  User? user,  DiaryTapState diaryTapState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectDetailsState() when $default != null:
return $default(_that.project,_that.isLoading,_that.isOwner,_that.user,_that.diaryTapState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Project? project,  bool isLoading,  bool isOwner,  User? user,  DiaryTapState diaryTapState)  $default,) {final _that = this;
switch (_that) {
case _ProjectDetailsState():
return $default(_that.project,_that.isLoading,_that.isOwner,_that.user,_that.diaryTapState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Project? project,  bool isLoading,  bool isOwner,  User? user,  DiaryTapState diaryTapState)?  $default,) {final _that = this;
switch (_that) {
case _ProjectDetailsState() when $default != null:
return $default(_that.project,_that.isLoading,_that.isOwner,_that.user,_that.diaryTapState);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectDetailsState implements ProjectDetailsState {
   _ProjectDetailsState({required this.project, required this.isLoading, required this.isOwner, required this.user, required this.diaryTapState});
  

@override final  Project? project;
@override final  bool isLoading;
@override final  bool isOwner;
@override final  User? user;
@override final  DiaryTapState diaryTapState;

/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectDetailsStateCopyWith<_ProjectDetailsState> get copyWith => __$ProjectDetailsStateCopyWithImpl<_ProjectDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectDetailsState&&(identical(other.project, project) || other.project == project)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.user, user) || other.user == user)&&(identical(other.diaryTapState, diaryTapState) || other.diaryTapState == diaryTapState));
}


@override
int get hashCode => Object.hash(runtimeType,project,isLoading,isOwner,user,diaryTapState);

@override
String toString() {
  return 'ProjectDetailsState(project: $project, isLoading: $isLoading, isOwner: $isOwner, user: $user, diaryTapState: $diaryTapState)';
}


}

/// @nodoc
abstract mixin class _$ProjectDetailsStateCopyWith<$Res> implements $ProjectDetailsStateCopyWith<$Res> {
  factory _$ProjectDetailsStateCopyWith(_ProjectDetailsState value, $Res Function(_ProjectDetailsState) _then) = __$ProjectDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 Project? project, bool isLoading, bool isOwner, User? user, DiaryTapState diaryTapState
});


@override $ProjectCopyWith<$Res>? get project;@override $UserCopyWith<$Res>? get user;@override $DiaryTapStateCopyWith<$Res> get diaryTapState;

}
/// @nodoc
class __$ProjectDetailsStateCopyWithImpl<$Res>
    implements _$ProjectDetailsStateCopyWith<$Res> {
  __$ProjectDetailsStateCopyWithImpl(this._self, this._then);

  final _ProjectDetailsState _self;
  final $Res Function(_ProjectDetailsState) _then;

/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? project = freezed,Object? isLoading = null,Object? isOwner = null,Object? user = freezed,Object? diaryTapState = null,}) {
  return _then(_ProjectDetailsState(
project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,diaryTapState: null == diaryTapState ? _self.diaryTapState : diaryTapState // ignore: cast_nullable_to_non_nullable
as DiaryTapState,
  ));
}

/// Create a copy of ProjectDetailsState
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
}/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ProjectDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiaryTapStateCopyWith<$Res> get diaryTapState {
  
  return $DiaryTapStateCopyWith<$Res>(_self.diaryTapState, (value) {
    return _then(_self.copyWith(diaryTapState: value));
  });
}
}

// dart format on
