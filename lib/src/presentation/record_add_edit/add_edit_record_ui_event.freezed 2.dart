// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_edit_record_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddEditRecordUiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddEditRecordUiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddEditRecordUiEvent()';
}


}

/// @nodoc
class $AddEditRecordUiEventCopyWith<$Res>  {
$AddEditRecordUiEventCopyWith(AddEditRecordUiEvent _, $Res Function(AddEditRecordUiEvent) __);
}


/// Adds pattern-matching-related methods to [AddEditRecordUiEvent].
extension AddEditRecordUiEventPatterns on AddEditRecordUiEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SavedRecord value)?  savedRecord,TResult Function( ShowSnackBar value)?  showSnackBar,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SavedRecord() when savedRecord != null:
return savedRecord(_that);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SavedRecord value)  savedRecord,required TResult Function( ShowSnackBar value)  showSnackBar,}){
final _that = this;
switch (_that) {
case SavedRecord():
return savedRecord(_that);case ShowSnackBar():
return showSnackBar(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SavedRecord value)?  savedRecord,TResult? Function( ShowSnackBar value)?  showSnackBar,}){
final _that = this;
switch (_that) {
case SavedRecord() when savedRecord != null:
return savedRecord(_that);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Records record)?  savedRecord,TResult Function( String message)?  showSnackBar,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SavedRecord() when savedRecord != null:
return savedRecord(_that.record);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Records record)  savedRecord,required TResult Function( String message)  showSnackBar,}) {final _that = this;
switch (_that) {
case SavedRecord():
return savedRecord(_that.record);case ShowSnackBar():
return showSnackBar(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Records record)?  savedRecord,TResult? Function( String message)?  showSnackBar,}) {final _that = this;
switch (_that) {
case SavedRecord() when savedRecord != null:
return savedRecord(_that.record);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SavedRecord implements AddEditRecordUiEvent {
  const SavedRecord(this.record);
  

 final  Records record;

/// Create a copy of AddEditRecordUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedRecordCopyWith<SavedRecord> get copyWith => _$SavedRecordCopyWithImpl<SavedRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedRecord&&(identical(other.record, record) || other.record == record));
}


@override
int get hashCode => Object.hash(runtimeType,record);

@override
String toString() {
  return 'AddEditRecordUiEvent.savedRecord(record: $record)';
}


}

/// @nodoc
abstract mixin class $SavedRecordCopyWith<$Res> implements $AddEditRecordUiEventCopyWith<$Res> {
  factory $SavedRecordCopyWith(SavedRecord value, $Res Function(SavedRecord) _then) = _$SavedRecordCopyWithImpl;
@useResult
$Res call({
 Records record
});


$RecordsCopyWith<$Res> get record;

}
/// @nodoc
class _$SavedRecordCopyWithImpl<$Res>
    implements $SavedRecordCopyWith<$Res> {
  _$SavedRecordCopyWithImpl(this._self, this._then);

  final SavedRecord _self;
  final $Res Function(SavedRecord) _then;

/// Create a copy of AddEditRecordUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? record = null,}) {
  return _then(SavedRecord(
null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records,
  ));
}

/// Create a copy of AddEditRecordUiEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordsCopyWith<$Res> get record {
  
  return $RecordsCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

/// @nodoc


class ShowSnackBar implements AddEditRecordUiEvent {
  const ShowSnackBar(this.message);
  

 final  String message;

/// Create a copy of AddEditRecordUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowSnackBarCopyWith<ShowSnackBar> get copyWith => _$ShowSnackBarCopyWithImpl<ShowSnackBar>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowSnackBar&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AddEditRecordUiEvent.showSnackBar(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowSnackBarCopyWith<$Res> implements $AddEditRecordUiEventCopyWith<$Res> {
  factory $ShowSnackBarCopyWith(ShowSnackBar value, $Res Function(ShowSnackBar) _then) = _$ShowSnackBarCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ShowSnackBarCopyWithImpl<$Res>
    implements $ShowSnackBarCopyWith<$Res> {
  _$ShowSnackBarCopyWithImpl(this._self, this._then);

  final ShowSnackBar _self;
  final $Res Function(ShowSnackBar) _then;

/// Create a copy of AddEditRecordUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShowSnackBar(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
