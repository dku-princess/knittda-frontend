// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionState {

 String get question; bool get isLoading; String? get errorMessage;
/// Create a copy of QuestionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionStateCopyWith<QuestionState> get copyWith => _$QuestionStateCopyWithImpl<QuestionState>(this as QuestionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionState&&(identical(other.question, question) || other.question == question)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,question,isLoading,errorMessage);

@override
String toString() {
  return 'QuestionState(question: $question, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $QuestionStateCopyWith<$Res>  {
  factory $QuestionStateCopyWith(QuestionState value, $Res Function(QuestionState) _then) = _$QuestionStateCopyWithImpl;
@useResult
$Res call({
 String question, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$QuestionStateCopyWithImpl<$Res>
    implements $QuestionStateCopyWith<$Res> {
  _$QuestionStateCopyWithImpl(this._self, this._then);

  final QuestionState _self;
  final $Res Function(QuestionState) _then;

/// Create a copy of QuestionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionState].
extension QuestionStatePatterns on QuestionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionState() when $default != null:
return $default(_that.question,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _QuestionState():
return $default(_that.question,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _QuestionState() when $default != null:
return $default(_that.question,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionState implements QuestionState {
   _QuestionState({required this.question, required this.isLoading, this.errorMessage});
  

@override final  String question;
@override final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of QuestionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionStateCopyWith<_QuestionState> get copyWith => __$QuestionStateCopyWithImpl<_QuestionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionState&&(identical(other.question, question) || other.question == question)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,question,isLoading,errorMessage);

@override
String toString() {
  return 'QuestionState(question: $question, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$QuestionStateCopyWith<$Res> implements $QuestionStateCopyWith<$Res> {
  factory _$QuestionStateCopyWith(_QuestionState value, $Res Function(_QuestionState) _then) = __$QuestionStateCopyWithImpl;
@override @useResult
$Res call({
 String question, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$QuestionStateCopyWithImpl<$Res>
    implements _$QuestionStateCopyWith<$Res> {
  __$QuestionStateCopyWithImpl(this._self, this._then);

  final _QuestionState _self;
  final $Res Function(_QuestionState) _then;

/// Create a copy of QuestionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_QuestionState(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
