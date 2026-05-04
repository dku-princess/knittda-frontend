// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteSection {

 int get id;@JsonKey(name: 'copyright_item_block') String? get copyrightItemBlock;@JsonKey(name: 'note_item_block') String? get noteItemBlock;@JsonKey(name: 'tracking_label') String? get trackingLabel;
/// Create a copy of NoteSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteSectionCopyWith<NoteSection> get copyWith => _$NoteSectionCopyWithImpl<NoteSection>(this as NoteSection, _$identity);

  /// Serializes this NoteSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteSection&&(identical(other.id, id) || other.id == id)&&(identical(other.copyrightItemBlock, copyrightItemBlock) || other.copyrightItemBlock == copyrightItemBlock)&&(identical(other.noteItemBlock, noteItemBlock) || other.noteItemBlock == noteItemBlock)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,copyrightItemBlock,noteItemBlock,trackingLabel);

@override
String toString() {
  return 'NoteSection(id: $id, copyrightItemBlock: $copyrightItemBlock, noteItemBlock: $noteItemBlock, trackingLabel: $trackingLabel)';
}


}

/// @nodoc
abstract mixin class $NoteSectionCopyWith<$Res>  {
  factory $NoteSectionCopyWith(NoteSection value, $Res Function(NoteSection) _then) = _$NoteSectionCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'copyright_item_block') String? copyrightItemBlock,@JsonKey(name: 'note_item_block') String? noteItemBlock,@JsonKey(name: 'tracking_label') String? trackingLabel
});




}
/// @nodoc
class _$NoteSectionCopyWithImpl<$Res>
    implements $NoteSectionCopyWith<$Res> {
  _$NoteSectionCopyWithImpl(this._self, this._then);

  final NoteSection _self;
  final $Res Function(NoteSection) _then;

/// Create a copy of NoteSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? copyrightItemBlock = freezed,Object? noteItemBlock = freezed,Object? trackingLabel = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,copyrightItemBlock: freezed == copyrightItemBlock ? _self.copyrightItemBlock : copyrightItemBlock // ignore: cast_nullable_to_non_nullable
as String?,noteItemBlock: freezed == noteItemBlock ? _self.noteItemBlock : noteItemBlock // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteSection].
extension NoteSectionPatterns on NoteSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteSection value)  $default,){
final _that = this;
switch (_that) {
case _NoteSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteSection value)?  $default,){
final _that = this;
switch (_that) {
case _NoteSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'copyright_item_block')  String? copyrightItemBlock, @JsonKey(name: 'note_item_block')  String? noteItemBlock, @JsonKey(name: 'tracking_label')  String? trackingLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteSection() when $default != null:
return $default(_that.id,_that.copyrightItemBlock,_that.noteItemBlock,_that.trackingLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'copyright_item_block')  String? copyrightItemBlock, @JsonKey(name: 'note_item_block')  String? noteItemBlock, @JsonKey(name: 'tracking_label')  String? trackingLabel)  $default,) {final _that = this;
switch (_that) {
case _NoteSection():
return $default(_that.id,_that.copyrightItemBlock,_that.noteItemBlock,_that.trackingLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'copyright_item_block')  String? copyrightItemBlock, @JsonKey(name: 'note_item_block')  String? noteItemBlock, @JsonKey(name: 'tracking_label')  String? trackingLabel)?  $default,) {final _that = this;
switch (_that) {
case _NoteSection() when $default != null:
return $default(_that.id,_that.copyrightItemBlock,_that.noteItemBlock,_that.trackingLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteSection implements NoteSection {
  const _NoteSection({this.id = 0, @JsonKey(name: 'copyright_item_block') this.copyrightItemBlock, @JsonKey(name: 'note_item_block') this.noteItemBlock, @JsonKey(name: 'tracking_label') this.trackingLabel});
  factory _NoteSection.fromJson(Map<String, dynamic> json) => _$NoteSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'copyright_item_block') final  String? copyrightItemBlock;
@override@JsonKey(name: 'note_item_block') final  String? noteItemBlock;
@override@JsonKey(name: 'tracking_label') final  String? trackingLabel;

/// Create a copy of NoteSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteSectionCopyWith<_NoteSection> get copyWith => __$NoteSectionCopyWithImpl<_NoteSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteSection&&(identical(other.id, id) || other.id == id)&&(identical(other.copyrightItemBlock, copyrightItemBlock) || other.copyrightItemBlock == copyrightItemBlock)&&(identical(other.noteItemBlock, noteItemBlock) || other.noteItemBlock == noteItemBlock)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,copyrightItemBlock,noteItemBlock,trackingLabel);

@override
String toString() {
  return 'NoteSection(id: $id, copyrightItemBlock: $copyrightItemBlock, noteItemBlock: $noteItemBlock, trackingLabel: $trackingLabel)';
}


}

/// @nodoc
abstract mixin class _$NoteSectionCopyWith<$Res> implements $NoteSectionCopyWith<$Res> {
  factory _$NoteSectionCopyWith(_NoteSection value, $Res Function(_NoteSection) _then) = __$NoteSectionCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'copyright_item_block') String? copyrightItemBlock,@JsonKey(name: 'note_item_block') String? noteItemBlock,@JsonKey(name: 'tracking_label') String? trackingLabel
});




}
/// @nodoc
class __$NoteSectionCopyWithImpl<$Res>
    implements _$NoteSectionCopyWith<$Res> {
  __$NoteSectionCopyWithImpl(this._self, this._then);

  final _NoteSection _self;
  final $Res Function(_NoteSection) _then;

/// Create a copy of NoteSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? copyrightItemBlock = freezed,Object? noteItemBlock = freezed,Object? trackingLabel = freezed,}) {
  return _then(_NoteSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,copyrightItemBlock: freezed == copyrightItemBlock ? _self.copyrightItemBlock : copyrightItemBlock // ignore: cast_nullable_to_non_nullable
as String?,noteItemBlock: freezed == noteItemBlock ? _self.noteItemBlock : noteItemBlock // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
