// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_link_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PurchaseLinkSection {

 int get id; String get title; String? get description;@JsonKey(name: 'tracking_label') String? get trackingLabel;@JsonKey(name: 'button_text') String get buttonText;@JsonKey(name: 'button_url') String get buttonUrl;@JsonKey(name: 'preview_image') String? get previewImage;
/// Create a copy of PurchaseLinkSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseLinkSectionCopyWith<PurchaseLinkSection> get copyWith => _$PurchaseLinkSectionCopyWithImpl<PurchaseLinkSection>(this as PurchaseLinkSection, _$identity);

  /// Serializes this PurchaseLinkSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseLinkSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&(identical(other.buttonText, buttonText) || other.buttonText == buttonText)&&(identical(other.buttonUrl, buttonUrl) || other.buttonUrl == buttonUrl)&&(identical(other.previewImage, previewImage) || other.previewImage == previewImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,buttonText,buttonUrl,previewImage);

@override
String toString() {
  return 'PurchaseLinkSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, buttonText: $buttonText, buttonUrl: $buttonUrl, previewImage: $previewImage)';
}


}

/// @nodoc
abstract mixin class $PurchaseLinkSectionCopyWith<$Res>  {
  factory $PurchaseLinkSectionCopyWith(PurchaseLinkSection value, $Res Function(PurchaseLinkSection) _then) = _$PurchaseLinkSectionCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'button_text') String buttonText,@JsonKey(name: 'button_url') String buttonUrl,@JsonKey(name: 'preview_image') String? previewImage
});




}
/// @nodoc
class _$PurchaseLinkSectionCopyWithImpl<$Res>
    implements $PurchaseLinkSectionCopyWith<$Res> {
  _$PurchaseLinkSectionCopyWithImpl(this._self, this._then);

  final PurchaseLinkSection _self;
  final $Res Function(PurchaseLinkSection) _then;

/// Create a copy of PurchaseLinkSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? buttonText = null,Object? buttonUrl = null,Object? previewImage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,buttonText: null == buttonText ? _self.buttonText : buttonText // ignore: cast_nullable_to_non_nullable
as String,buttonUrl: null == buttonUrl ? _self.buttonUrl : buttonUrl // ignore: cast_nullable_to_non_nullable
as String,previewImage: freezed == previewImage ? _self.previewImage : previewImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseLinkSection].
extension PurchaseLinkSectionPatterns on PurchaseLinkSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseLinkSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseLinkSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseLinkSection value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseLinkSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseLinkSection value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseLinkSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'button_text')  String buttonText, @JsonKey(name: 'button_url')  String buttonUrl, @JsonKey(name: 'preview_image')  String? previewImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseLinkSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.buttonText,_that.buttonUrl,_that.previewImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'button_text')  String buttonText, @JsonKey(name: 'button_url')  String buttonUrl, @JsonKey(name: 'preview_image')  String? previewImage)  $default,) {final _that = this;
switch (_that) {
case _PurchaseLinkSection():
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.buttonText,_that.buttonUrl,_that.previewImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'button_text')  String buttonText, @JsonKey(name: 'button_url')  String buttonUrl, @JsonKey(name: 'preview_image')  String? previewImage)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseLinkSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.buttonText,_that.buttonUrl,_that.previewImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseLinkSection implements PurchaseLinkSection {
  const _PurchaseLinkSection({this.id = 0, this.title = '', this.description, @JsonKey(name: 'tracking_label') this.trackingLabel, @JsonKey(name: 'button_text') this.buttonText = '', @JsonKey(name: 'button_url') this.buttonUrl = '', @JsonKey(name: 'preview_image') this.previewImage});
  factory _PurchaseLinkSection.fromJson(Map<String, dynamic> json) => _$PurchaseLinkSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override final  String? description;
@override@JsonKey(name: 'tracking_label') final  String? trackingLabel;
@override@JsonKey(name: 'button_text') final  String buttonText;
@override@JsonKey(name: 'button_url') final  String buttonUrl;
@override@JsonKey(name: 'preview_image') final  String? previewImage;

/// Create a copy of PurchaseLinkSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseLinkSectionCopyWith<_PurchaseLinkSection> get copyWith => __$PurchaseLinkSectionCopyWithImpl<_PurchaseLinkSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseLinkSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseLinkSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&(identical(other.buttonText, buttonText) || other.buttonText == buttonText)&&(identical(other.buttonUrl, buttonUrl) || other.buttonUrl == buttonUrl)&&(identical(other.previewImage, previewImage) || other.previewImage == previewImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,buttonText,buttonUrl,previewImage);

@override
String toString() {
  return 'PurchaseLinkSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, buttonText: $buttonText, buttonUrl: $buttonUrl, previewImage: $previewImage)';
}


}

/// @nodoc
abstract mixin class _$PurchaseLinkSectionCopyWith<$Res> implements $PurchaseLinkSectionCopyWith<$Res> {
  factory _$PurchaseLinkSectionCopyWith(_PurchaseLinkSection value, $Res Function(_PurchaseLinkSection) _then) = __$PurchaseLinkSectionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'button_text') String buttonText,@JsonKey(name: 'button_url') String buttonUrl,@JsonKey(name: 'preview_image') String? previewImage
});




}
/// @nodoc
class __$PurchaseLinkSectionCopyWithImpl<$Res>
    implements _$PurchaseLinkSectionCopyWith<$Res> {
  __$PurchaseLinkSectionCopyWithImpl(this._self, this._then);

  final _PurchaseLinkSection _self;
  final $Res Function(_PurchaseLinkSection) _then;

/// Create a copy of PurchaseLinkSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? buttonText = null,Object? buttonUrl = null,Object? previewImage = freezed,}) {
  return _then(_PurchaseLinkSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,buttonText: null == buttonText ? _self.buttonText : buttonText // ignore: cast_nullable_to_non_nullable
as String,buttonUrl: null == buttonUrl ? _self.buttonUrl : buttonUrl // ignore: cast_nullable_to_non_nullable
as String,previewImage: freezed == previewImage ? _self.previewImage : previewImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
