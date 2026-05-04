// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordDetailsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordDetailsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecordDetailsEvent()';
}


}

/// @nodoc
class $RecordDetailsEventCopyWith<$Res>  {
$RecordDetailsEventCopyWith(RecordDetailsEvent _, $Res Function(RecordDetailsEvent) __);
}


/// Adds pattern-matching-related methods to [RecordDetailsEvent].
extension RecordDetailsEventPatterns on RecordDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRecord value)?  loadRecord,TResult Function( DeleteRecord value)?  deleteRecord,TResult Function( MarkChanged value)?  markChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRecord() when loadRecord != null:
return loadRecord(_that);case DeleteRecord() when deleteRecord != null:
return deleteRecord(_that);case MarkChanged() when markChanged != null:
return markChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRecord value)  loadRecord,required TResult Function( DeleteRecord value)  deleteRecord,required TResult Function( MarkChanged value)  markChanged,}){
final _that = this;
switch (_that) {
case LoadRecord():
return loadRecord(_that);case DeleteRecord():
return deleteRecord(_that);case MarkChanged():
return markChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRecord value)?  loadRecord,TResult? Function( DeleteRecord value)?  deleteRecord,TResult? Function( MarkChanged value)?  markChanged,}){
final _that = this;
switch (_that) {
case LoadRecord() when loadRecord != null:
return loadRecord(_that);case DeleteRecord() when deleteRecord != null:
return deleteRecord(_that);case MarkChanged() when markChanged != null:
return markChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int recordId,  Records record)?  loadRecord,TResult Function( int recordId)?  deleteRecord,TResult Function()?  markChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRecord() when loadRecord != null:
return loadRecord(_that.recordId,_that.record);case DeleteRecord() when deleteRecord != null:
return deleteRecord(_that.recordId);case MarkChanged() when markChanged != null:
return markChanged();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int recordId,  Records record)  loadRecord,required TResult Function( int recordId)  deleteRecord,required TResult Function()  markChanged,}) {final _that = this;
switch (_that) {
case LoadRecord():
return loadRecord(_that.recordId,_that.record);case DeleteRecord():
return deleteRecord(_that.recordId);case MarkChanged():
return markChanged();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int recordId,  Records record)?  loadRecord,TResult? Function( int recordId)?  deleteRecord,TResult? Function()?  markChanged,}) {final _that = this;
switch (_that) {
case LoadRecord() when loadRecord != null:
return loadRecord(_that.recordId,_that.record);case DeleteRecord() when deleteRecord != null:
return deleteRecord(_that.recordId);case MarkChanged() when markChanged != null:
return markChanged();case _:
  return null;

}
}

}

/// @nodoc


class LoadRecord implements RecordDetailsEvent {
  const LoadRecord({required this.recordId, required this.record});
  

 final  int recordId;
 final  Records record;

/// Create a copy of RecordDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRecordCopyWith<LoadRecord> get copyWith => _$LoadRecordCopyWithImpl<LoadRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRecord&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.record, record) || other.record == record));
}


@override
int get hashCode => Object.hash(runtimeType,recordId,record);

@override
String toString() {
  return 'RecordDetailsEvent.loadRecord(recordId: $recordId, record: $record)';
}


}

/// @nodoc
abstract mixin class $LoadRecordCopyWith<$Res> implements $RecordDetailsEventCopyWith<$Res> {
  factory $LoadRecordCopyWith(LoadRecord value, $Res Function(LoadRecord) _then) = _$LoadRecordCopyWithImpl;
@useResult
$Res call({
 int recordId, Records record
});


$RecordsCopyWith<$Res> get record;

}
/// @nodoc
class _$LoadRecordCopyWithImpl<$Res>
    implements $LoadRecordCopyWith<$Res> {
  _$LoadRecordCopyWithImpl(this._self, this._then);

  final LoadRecord _self;
  final $Res Function(LoadRecord) _then;

/// Create a copy of RecordDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recordId = null,Object? record = null,}) {
  return _then(LoadRecord(
recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as int,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records,
  ));
}

/// Create a copy of RecordDetailsEvent
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


class DeleteRecord implements RecordDetailsEvent {
  const DeleteRecord({required this.recordId});
  

 final  int recordId;

/// Create a copy of RecordDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteRecordCopyWith<DeleteRecord> get copyWith => _$DeleteRecordCopyWithImpl<DeleteRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteRecord&&(identical(other.recordId, recordId) || other.recordId == recordId));
}


@override
int get hashCode => Object.hash(runtimeType,recordId);

@override
String toString() {
  return 'RecordDetailsEvent.deleteRecord(recordId: $recordId)';
}


}

/// @nodoc
abstract mixin class $DeleteRecordCopyWith<$Res> implements $RecordDetailsEventCopyWith<$Res> {
  factory $DeleteRecordCopyWith(DeleteRecord value, $Res Function(DeleteRecord) _then) = _$DeleteRecordCopyWithImpl;
@useResult
$Res call({
 int recordId
});




}
/// @nodoc
class _$DeleteRecordCopyWithImpl<$Res>
    implements $DeleteRecordCopyWith<$Res> {
  _$DeleteRecordCopyWithImpl(this._self, this._then);

  final DeleteRecord _self;
  final $Res Function(DeleteRecord) _then;

/// Create a copy of RecordDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recordId = null,}) {
  return _then(DeleteRecord(
recordId: null == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MarkChanged implements RecordDetailsEvent {
  const MarkChanged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkChanged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecordDetailsEvent.markChanged()';
}


}




// dart format on
