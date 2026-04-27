// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatternSection {

 int get id; String get title; String? get description;@JsonKey(name: 'tracking_label') String? get trackingLabel;@JsonKey(name: 'pattern_item_block') List<PatternItemBlock> get patternItemBlock;
/// Create a copy of PatternSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternSectionCopyWith<PatternSection> get copyWith => _$PatternSectionCopyWithImpl<PatternSection>(this as PatternSection, _$identity);

  /// Serializes this PatternSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&const DeepCollectionEquality().equals(other.patternItemBlock, patternItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,const DeepCollectionEquality().hash(patternItemBlock));

@override
String toString() {
  return 'PatternSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, patternItemBlock: $patternItemBlock)';
}


}

/// @nodoc
abstract mixin class $PatternSectionCopyWith<$Res>  {
  factory $PatternSectionCopyWith(PatternSection value, $Res Function(PatternSection) _then) = _$PatternSectionCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'pattern_item_block') List<PatternItemBlock> patternItemBlock
});




}
/// @nodoc
class _$PatternSectionCopyWithImpl<$Res>
    implements $PatternSectionCopyWith<$Res> {
  _$PatternSectionCopyWithImpl(this._self, this._then);

  final PatternSection _self;
  final $Res Function(PatternSection) _then;

/// Create a copy of PatternSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? patternItemBlock = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,patternItemBlock: null == patternItemBlock ? _self.patternItemBlock : patternItemBlock // ignore: cast_nullable_to_non_nullable
as List<PatternItemBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [PatternSection].
extension PatternSectionPatterns on PatternSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternSection value)  $default,){
final _that = this;
switch (_that) {
case _PatternSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternSection value)?  $default,){
final _that = this;
switch (_that) {
case _PatternSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'pattern_item_block')  List<PatternItemBlock> patternItemBlock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.patternItemBlock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'pattern_item_block')  List<PatternItemBlock> patternItemBlock)  $default,) {final _that = this;
switch (_that) {
case _PatternSection():
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.patternItemBlock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'pattern_item_block')  List<PatternItemBlock> patternItemBlock)?  $default,) {final _that = this;
switch (_that) {
case _PatternSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.patternItemBlock);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatternSection implements PatternSection {
  const _PatternSection({this.id = 0, this.title = '', this.description, @JsonKey(name: 'tracking_label') this.trackingLabel, @JsonKey(name: 'pattern_item_block') final  List<PatternItemBlock> patternItemBlock = const []}): _patternItemBlock = patternItemBlock;
  factory _PatternSection.fromJson(Map<String, dynamic> json) => _$PatternSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override final  String? description;
@override@JsonKey(name: 'tracking_label') final  String? trackingLabel;
 final  List<PatternItemBlock> _patternItemBlock;
@override@JsonKey(name: 'pattern_item_block') List<PatternItemBlock> get patternItemBlock {
  if (_patternItemBlock is EqualUnmodifiableListView) return _patternItemBlock;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patternItemBlock);
}


/// Create a copy of PatternSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternSectionCopyWith<_PatternSection> get copyWith => __$PatternSectionCopyWithImpl<_PatternSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatternSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&const DeepCollectionEquality().equals(other._patternItemBlock, _patternItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,const DeepCollectionEquality().hash(_patternItemBlock));

@override
String toString() {
  return 'PatternSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, patternItemBlock: $patternItemBlock)';
}


}

/// @nodoc
abstract mixin class _$PatternSectionCopyWith<$Res> implements $PatternSectionCopyWith<$Res> {
  factory _$PatternSectionCopyWith(_PatternSection value, $Res Function(_PatternSection) _then) = __$PatternSectionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'pattern_item_block') List<PatternItemBlock> patternItemBlock
});




}
/// @nodoc
class __$PatternSectionCopyWithImpl<$Res>
    implements _$PatternSectionCopyWith<$Res> {
  __$PatternSectionCopyWithImpl(this._self, this._then);

  final _PatternSection _self;
  final $Res Function(_PatternSection) _then;

/// Create a copy of PatternSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? patternItemBlock = null,}) {
  return _then(_PatternSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,patternItemBlock: null == patternItemBlock ? _self._patternItemBlock : patternItemBlock // ignore: cast_nullable_to_non_nullable
as List<PatternItemBlock>,
  ));
}


}


/// @nodoc
mixin _$PatternItemBlock {

 int get id; String get title; String get description; String? get image;@JsonKey(name: 'image_ratio') String get imageRatio; List<GalleryItem> get gallery;@JsonKey(name: 'gallery_second') List<GalleryItem> get gallerySecond;
/// Create a copy of PatternItemBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternItemBlockCopyWith<PatternItemBlock> get copyWith => _$PatternItemBlockCopyWithImpl<PatternItemBlock>(this as PatternItemBlock, _$identity);

  /// Serializes this PatternItemBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&(identical(other.imageRatio, imageRatio) || other.imageRatio == imageRatio)&&const DeepCollectionEquality().equals(other.gallery, gallery)&&const DeepCollectionEquality().equals(other.gallerySecond, gallerySecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image,imageRatio,const DeepCollectionEquality().hash(gallery),const DeepCollectionEquality().hash(gallerySecond));

@override
String toString() {
  return 'PatternItemBlock(id: $id, title: $title, description: $description, image: $image, imageRatio: $imageRatio, gallery: $gallery, gallerySecond: $gallerySecond)';
}


}

/// @nodoc
abstract mixin class $PatternItemBlockCopyWith<$Res>  {
  factory $PatternItemBlockCopyWith(PatternItemBlock value, $Res Function(PatternItemBlock) _then) = _$PatternItemBlockCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String? image,@JsonKey(name: 'image_ratio') String imageRatio, List<GalleryItem> gallery,@JsonKey(name: 'gallery_second') List<GalleryItem> gallerySecond
});




}
/// @nodoc
class _$PatternItemBlockCopyWithImpl<$Res>
    implements $PatternItemBlockCopyWith<$Res> {
  _$PatternItemBlockCopyWithImpl(this._self, this._then);

  final PatternItemBlock _self;
  final $Res Function(PatternItemBlock) _then;

/// Create a copy of PatternItemBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = freezed,Object? imageRatio = null,Object? gallery = null,Object? gallerySecond = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,imageRatio: null == imageRatio ? _self.imageRatio : imageRatio // ignore: cast_nullable_to_non_nullable
as String,gallery: null == gallery ? _self.gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,gallerySecond: null == gallerySecond ? _self.gallerySecond : gallerySecond // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PatternItemBlock].
extension PatternItemBlockPatterns on PatternItemBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatternItemBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatternItemBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatternItemBlock value)  $default,){
final _that = this;
switch (_that) {
case _PatternItemBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatternItemBlock value)?  $default,){
final _that = this;
switch (_that) {
case _PatternItemBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String? image, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery, @JsonKey(name: 'gallery_second')  List<GalleryItem> gallerySecond)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatternItemBlock() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image,_that.imageRatio,_that.gallery,_that.gallerySecond);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String? image, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery, @JsonKey(name: 'gallery_second')  List<GalleryItem> gallerySecond)  $default,) {final _that = this;
switch (_that) {
case _PatternItemBlock():
return $default(_that.id,_that.title,_that.description,_that.image,_that.imageRatio,_that.gallery,_that.gallerySecond);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String? image, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery, @JsonKey(name: 'gallery_second')  List<GalleryItem> gallerySecond)?  $default,) {final _that = this;
switch (_that) {
case _PatternItemBlock() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image,_that.imageRatio,_that.gallery,_that.gallerySecond);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatternItemBlock implements PatternItemBlock {
  const _PatternItemBlock({this.id = 0, this.title = '', this.description = '', this.image, @JsonKey(name: 'image_ratio') this.imageRatio = 'landscape_4_3', final  List<GalleryItem> gallery = const [], @JsonKey(name: 'gallery_second') final  List<GalleryItem> gallerySecond = const []}): _gallery = gallery,_gallerySecond = gallerySecond;
  factory _PatternItemBlock.fromJson(Map<String, dynamic> json) => _$PatternItemBlockFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override final  String? image;
@override@JsonKey(name: 'image_ratio') final  String imageRatio;
 final  List<GalleryItem> _gallery;
@override@JsonKey() List<GalleryItem> get gallery {
  if (_gallery is EqualUnmodifiableListView) return _gallery;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gallery);
}

 final  List<GalleryItem> _gallerySecond;
@override@JsonKey(name: 'gallery_second') List<GalleryItem> get gallerySecond {
  if (_gallerySecond is EqualUnmodifiableListView) return _gallerySecond;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gallerySecond);
}


/// Create a copy of PatternItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatternItemBlockCopyWith<_PatternItemBlock> get copyWith => __$PatternItemBlockCopyWithImpl<_PatternItemBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatternItemBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatternItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&(identical(other.imageRatio, imageRatio) || other.imageRatio == imageRatio)&&const DeepCollectionEquality().equals(other._gallery, _gallery)&&const DeepCollectionEquality().equals(other._gallerySecond, _gallerySecond));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image,imageRatio,const DeepCollectionEquality().hash(_gallery),const DeepCollectionEquality().hash(_gallerySecond));

@override
String toString() {
  return 'PatternItemBlock(id: $id, title: $title, description: $description, image: $image, imageRatio: $imageRatio, gallery: $gallery, gallerySecond: $gallerySecond)';
}


}

/// @nodoc
abstract mixin class _$PatternItemBlockCopyWith<$Res> implements $PatternItemBlockCopyWith<$Res> {
  factory _$PatternItemBlockCopyWith(_PatternItemBlock value, $Res Function(_PatternItemBlock) _then) = __$PatternItemBlockCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String? image,@JsonKey(name: 'image_ratio') String imageRatio, List<GalleryItem> gallery,@JsonKey(name: 'gallery_second') List<GalleryItem> gallerySecond
});




}
/// @nodoc
class __$PatternItemBlockCopyWithImpl<$Res>
    implements _$PatternItemBlockCopyWith<$Res> {
  __$PatternItemBlockCopyWithImpl(this._self, this._then);

  final _PatternItemBlock _self;
  final $Res Function(_PatternItemBlock) _then;

/// Create a copy of PatternItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = freezed,Object? imageRatio = null,Object? gallery = null,Object? gallerySecond = null,}) {
  return _then(_PatternItemBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,imageRatio: null == imageRatio ? _self.imageRatio : imageRatio // ignore: cast_nullable_to_non_nullable
as String,gallery: null == gallery ? _self._gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,gallerySecond: null == gallerySecond ? _self._gallerySecond : gallerySecond // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,
  ));
}


}

// dart format on
