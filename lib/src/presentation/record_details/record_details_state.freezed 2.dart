// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordDetailsState {

 Records? get record; bool get isLoading; bool get isOwner; bool get isChanged;
/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordDetailsStateCopyWith<RecordDetailsState> get copyWith => _$RecordDetailsStateCopyWithImpl<RecordDetailsState>(this as RecordDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordDetailsState&&(identical(other.record, record) || other.record == record)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.isChanged, isChanged) || other.isChanged == isChanged));
}


@override
int get hashCode => Object.hash(runtimeType,record,isLoading,isOwner,isChanged);

@override
String toString() {
  return 'RecordDetailsState(record: $record, isLoading: $isLoading, isOwner: $isOwner, isChanged: $isChanged)';
}


}

/// @nodoc
abstract mixin class $RecordDetailsStateCopyWith<$Res>  {
  factory $RecordDetailsStateCopyWith(RecordDetailsState value, $Res Function(RecordDetailsState) _then) = _$RecordDetailsStateCopyWithImpl;
@useResult
$Res call({
 Records? record, bool isLoading, bool isOwner, bool isChanged
});


$RecordsCopyWith<$Res>? get record;

}
/// @nodoc
class _$RecordDetailsStateCopyWithImpl<$Res>
    implements $RecordDetailsStateCopyWith<$Res> {
  _$RecordDetailsStateCopyWithImpl(this._self, this._then);

  final RecordDetailsState _self;
  final $Res Function(RecordDetailsState) _then;

/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? record = freezed,Object? isLoading = null,Object? isOwner = null,Object? isChanged = null,}) {
  return _then(_self.copyWith(
record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,isChanged: null == isChanged ? _self.isChanged : isChanged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordsCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $RecordsCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecordDetailsState].
extension RecordDetailsStatePatterns on RecordDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _RecordDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _RecordDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Records? record,  bool isLoading,  bool isOwner,  bool isChanged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordDetailsState() when $default != null:
return $default(_that.record,_that.isLoading,_that.isOwner,_that.isChanged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Records? record,  bool isLoading,  bool isOwner,  bool isChanged)  $default,) {final _that = this;
switch (_that) {
case _RecordDetailsState():
return $default(_that.record,_that.isLoading,_that.isOwner,_that.isChanged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Records? record,  bool isLoading,  bool isOwner,  bool isChanged)?  $default,) {final _that = this;
switch (_that) {
case _RecordDetailsState() when $default != null:
return $default(_that.record,_that.isLoading,_that.isOwner,_that.isChanged);case _:
  return null;

}
}

}

/// @nodoc


class _RecordDetailsState implements RecordDetailsState {
   _RecordDetailsState({required this.record, required this.isLoading, required this.isOwner, required this.isChanged});
  

@override final  Records? record;
@override final  bool isLoading;
@override final  bool isOwner;
@override final  bool isChanged;

/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordDetailsStateCopyWith<_RecordDetailsState> get copyWith => __$RecordDetailsStateCopyWithImpl<_RecordDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordDetailsState&&(identical(other.record, record) || other.record == record)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.isChanged, isChanged) || other.isChanged == isChanged));
}


@override
int get hashCode => Object.hash(runtimeType,record,isLoading,isOwner,isChanged);

@override
String toString() {
  return 'RecordDetailsState(record: $record, isLoading: $isLoading, isOwner: $isOwner, isChanged: $isChanged)';
}


}

/// @nodoc
abstract mixin class _$RecordDetailsStateCopyWith<$Res> implements $RecordDetailsStateCopyWith<$Res> {
  factory _$RecordDetailsStateCopyWith(_RecordDetailsState value, $Res Function(_RecordDetailsState) _then) = __$RecordDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 Records? record, bool isLoading, bool isOwner, bool isChanged
});


@override $RecordsCopyWith<$Res>? get record;

}
/// @nodoc
class __$RecordDetailsStateCopyWithImpl<$Res>
    implements _$RecordDetailsStateCopyWith<$Res> {
  __$RecordDetailsStateCopyWithImpl(this._self, this._then);

  final _RecordDetailsState _self;
  final $Res Function(_RecordDetailsState) _then;

/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? record = freezed,Object? isLoading = null,Object? isOwner = null,Object? isChanged = null,}) {
  return _then(_RecordDetailsState(
record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,isChanged: null == isChanged ? _self.isChanged : isChanged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RecordDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordsCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $RecordsCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
