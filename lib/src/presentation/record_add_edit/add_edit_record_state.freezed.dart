// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_edit_record_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddEditRecordState {

 bool get isLoading; QuestionState get questionState;
/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddEditRecordStateCopyWith<AddEditRecordState> get copyWith => _$AddEditRecordStateCopyWithImpl<AddEditRecordState>(this as AddEditRecordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddEditRecordState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.questionState, questionState) || other.questionState == questionState));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,questionState);

@override
String toString() {
  return 'AddEditRecordState(isLoading: $isLoading, questionState: $questionState)';
}


}

/// @nodoc
abstract mixin class $AddEditRecordStateCopyWith<$Res>  {
  factory $AddEditRecordStateCopyWith(AddEditRecordState value, $Res Function(AddEditRecordState) _then) = _$AddEditRecordStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, QuestionState questionState
});


$QuestionStateCopyWith<$Res> get questionState;

}
/// @nodoc
class _$AddEditRecordStateCopyWithImpl<$Res>
    implements $AddEditRecordStateCopyWith<$Res> {
  _$AddEditRecordStateCopyWithImpl(this._self, this._then);

  final AddEditRecordState _self;
  final $Res Function(AddEditRecordState) _then;

/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? questionState = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questionState: null == questionState ? _self.questionState : questionState // ignore: cast_nullable_to_non_nullable
as QuestionState,
  ));
}
/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionStateCopyWith<$Res> get questionState {
  
  return $QuestionStateCopyWith<$Res>(_self.questionState, (value) {
    return _then(_self.copyWith(questionState: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddEditRecordState].
extension AddEditRecordStatePatterns on AddEditRecordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddEditRecordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddEditRecordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddEditRecordState value)  $default,){
final _that = this;
switch (_that) {
case _AddEditRecordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddEditRecordState value)?  $default,){
final _that = this;
switch (_that) {
case _AddEditRecordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  QuestionState questionState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddEditRecordState() when $default != null:
return $default(_that.isLoading,_that.questionState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  QuestionState questionState)  $default,) {final _that = this;
switch (_that) {
case _AddEditRecordState():
return $default(_that.isLoading,_that.questionState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  QuestionState questionState)?  $default,) {final _that = this;
switch (_that) {
case _AddEditRecordState() when $default != null:
return $default(_that.isLoading,_that.questionState);case _:
  return null;

}
}

}

/// @nodoc


class _AddEditRecordState implements AddEditRecordState {
   _AddEditRecordState({required this.isLoading, required this.questionState});
  

@override final  bool isLoading;
@override final  QuestionState questionState;

/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddEditRecordStateCopyWith<_AddEditRecordState> get copyWith => __$AddEditRecordStateCopyWithImpl<_AddEditRecordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddEditRecordState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.questionState, questionState) || other.questionState == questionState));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,questionState);

@override
String toString() {
  return 'AddEditRecordState(isLoading: $isLoading, questionState: $questionState)';
}


}

/// @nodoc
abstract mixin class _$AddEditRecordStateCopyWith<$Res> implements $AddEditRecordStateCopyWith<$Res> {
  factory _$AddEditRecordStateCopyWith(_AddEditRecordState value, $Res Function(_AddEditRecordState) _then) = __$AddEditRecordStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, QuestionState questionState
});


@override $QuestionStateCopyWith<$Res> get questionState;

}
/// @nodoc
class __$AddEditRecordStateCopyWithImpl<$Res>
    implements _$AddEditRecordStateCopyWith<$Res> {
  __$AddEditRecordStateCopyWithImpl(this._self, this._then);

  final _AddEditRecordState _self;
  final $Res Function(_AddEditRecordState) _then;

/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? questionState = null,}) {
  return _then(_AddEditRecordState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questionState: null == questionState ? _self.questionState : questionState // ignore: cast_nullable_to_non_nullable
as QuestionState,
  ));
}

/// Create a copy of AddEditRecordState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionStateCopyWith<$Res> get questionState {
  
  return $QuestionStateCopyWith<$Res>(_self.questionState, (value) {
    return _then(_self.copyWith(questionState: value));
  });
}
}

// dart format on
