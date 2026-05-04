// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_tap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaryTapState {

 List<Records> get records; bool get isLoading; String? get errorMessage;
/// Create a copy of DiaryTapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryTapStateCopyWith<DiaryTapState> get copyWith => _$DiaryTapStateCopyWithImpl<DiaryTapState>(this as DiaryTapState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryTapState&&const DeepCollectionEquality().equals(other.records, records)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(records),isLoading,errorMessage);

@override
String toString() {
  return 'DiaryTapState(records: $records, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DiaryTapStateCopyWith<$Res>  {
  factory $DiaryTapStateCopyWith(DiaryTapState value, $Res Function(DiaryTapState) _then) = _$DiaryTapStateCopyWithImpl;
@useResult
$Res call({
 List<Records> records, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$DiaryTapStateCopyWithImpl<$Res>
    implements $DiaryTapStateCopyWith<$Res> {
  _$DiaryTapStateCopyWithImpl(this._self, this._then);

  final DiaryTapState _self;
  final $Res Function(DiaryTapState) _then;

/// Create a copy of DiaryTapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? records = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<Records>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryTapState].
extension DiaryTapStatePatterns on DiaryTapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryTapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryTapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryTapState value)  $default,){
final _that = this;
switch (_that) {
case _DiaryTapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryTapState value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryTapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Records> records,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryTapState() when $default != null:
return $default(_that.records,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Records> records,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DiaryTapState():
return $default(_that.records,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Records> records,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DiaryTapState() when $default != null:
return $default(_that.records,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DiaryTapState implements DiaryTapState {
   _DiaryTapState({required final  List<Records> records, required this.isLoading, this.errorMessage}): _records = records;
  

 final  List<Records> _records;
@override List<Records> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

@override final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of DiaryTapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryTapStateCopyWith<_DiaryTapState> get copyWith => __$DiaryTapStateCopyWithImpl<_DiaryTapState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryTapState&&const DeepCollectionEquality().equals(other._records, _records)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records),isLoading,errorMessage);

@override
String toString() {
  return 'DiaryTapState(records: $records, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DiaryTapStateCopyWith<$Res> implements $DiaryTapStateCopyWith<$Res> {
  factory _$DiaryTapStateCopyWith(_DiaryTapState value, $Res Function(_DiaryTapState) _then) = __$DiaryTapStateCopyWithImpl;
@override @useResult
$Res call({
 List<Records> records, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$DiaryTapStateCopyWithImpl<$Res>
    implements _$DiaryTapStateCopyWith<$Res> {
  __$DiaryTapStateCopyWithImpl(this._self, this._then);

  final _DiaryTapState _self;
  final $Res Function(_DiaryTapState) _then;

/// Create a copy of DiaryTapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? records = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_DiaryTapState(
records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<Records>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
