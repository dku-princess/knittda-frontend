// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qa_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QaSection {

 int get id; String get title; String? get description;@JsonKey(name: 'tracking_label') String? get trackingLabel;@JsonKey(name: 'qa_item_block') List<QaItemBlock> get qaItemBlock;
/// Create a copy of QaSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QaSectionCopyWith<QaSection> get copyWith => _$QaSectionCopyWithImpl<QaSection>(this as QaSection, _$identity);

  /// Serializes this QaSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QaSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&const DeepCollectionEquality().equals(other.qaItemBlock, qaItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,const DeepCollectionEquality().hash(qaItemBlock));

@override
String toString() {
  return 'QaSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, qaItemBlock: $qaItemBlock)';
}


}

/// @nodoc
abstract mixin class $QaSectionCopyWith<$Res>  {
  factory $QaSectionCopyWith(QaSection value, $Res Function(QaSection) _then) = _$QaSectionCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'qa_item_block') List<QaItemBlock> qaItemBlock
});




}
/// @nodoc
class _$QaSectionCopyWithImpl<$Res>
    implements $QaSectionCopyWith<$Res> {
  _$QaSectionCopyWithImpl(this._self, this._then);

  final QaSection _self;
  final $Res Function(QaSection) _then;

/// Create a copy of QaSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? qaItemBlock = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,qaItemBlock: null == qaItemBlock ? _self.qaItemBlock : qaItemBlock // ignore: cast_nullable_to_non_nullable
as List<QaItemBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [QaSection].
extension QaSectionPatterns on QaSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QaSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QaSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QaSection value)  $default,){
final _that = this;
switch (_that) {
case _QaSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QaSection value)?  $default,){
final _that = this;
switch (_that) {
case _QaSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'qa_item_block')  List<QaItemBlock> qaItemBlock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QaSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.qaItemBlock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'qa_item_block')  List<QaItemBlock> qaItemBlock)  $default,) {final _that = this;
switch (_that) {
case _QaSection():
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.qaItemBlock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description, @JsonKey(name: 'tracking_label')  String? trackingLabel, @JsonKey(name: 'qa_item_block')  List<QaItemBlock> qaItemBlock)?  $default,) {final _that = this;
switch (_that) {
case _QaSection() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.trackingLabel,_that.qaItemBlock);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QaSection implements QaSection {
  const _QaSection({this.id = 0, this.title = '', this.description, @JsonKey(name: 'tracking_label') this.trackingLabel, @JsonKey(name: 'qa_item_block') final  List<QaItemBlock> qaItemBlock = const []}): _qaItemBlock = qaItemBlock;
  factory _QaSection.fromJson(Map<String, dynamic> json) => _$QaSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override final  String? description;
@override@JsonKey(name: 'tracking_label') final  String? trackingLabel;
 final  List<QaItemBlock> _qaItemBlock;
@override@JsonKey(name: 'qa_item_block') List<QaItemBlock> get qaItemBlock {
  if (_qaItemBlock is EqualUnmodifiableListView) return _qaItemBlock;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qaItemBlock);
}


/// Create a copy of QaSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QaSectionCopyWith<_QaSection> get copyWith => __$QaSectionCopyWithImpl<_QaSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QaSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QaSection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.trackingLabel, trackingLabel) || other.trackingLabel == trackingLabel)&&const DeepCollectionEquality().equals(other._qaItemBlock, _qaItemBlock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,trackingLabel,const DeepCollectionEquality().hash(_qaItemBlock));

@override
String toString() {
  return 'QaSection(id: $id, title: $title, description: $description, trackingLabel: $trackingLabel, qaItemBlock: $qaItemBlock)';
}


}

/// @nodoc
abstract mixin class _$QaSectionCopyWith<$Res> implements $QaSectionCopyWith<$Res> {
  factory _$QaSectionCopyWith(_QaSection value, $Res Function(_QaSection) _then) = __$QaSectionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description,@JsonKey(name: 'tracking_label') String? trackingLabel,@JsonKey(name: 'qa_item_block') List<QaItemBlock> qaItemBlock
});




}
/// @nodoc
class __$QaSectionCopyWithImpl<$Res>
    implements _$QaSectionCopyWith<$Res> {
  __$QaSectionCopyWithImpl(this._self, this._then);

  final _QaSection _self;
  final $Res Function(_QaSection) _then;

/// Create a copy of QaSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? trackingLabel = freezed,Object? qaItemBlock = null,}) {
  return _then(_QaSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,trackingLabel: freezed == trackingLabel ? _self.trackingLabel : trackingLabel // ignore: cast_nullable_to_non_nullable
as String?,qaItemBlock: null == qaItemBlock ? _self._qaItemBlock : qaItemBlock // ignore: cast_nullable_to_non_nullable
as List<QaItemBlock>,
  ));
}


}


/// @nodoc
mixin _$QaItemBlock {

 int get id; String get question; String get answer; String? get image;@JsonKey(name: 'highlight_quote') String? get highlightQuote;@JsonKey(name: 'image_ratio') String get imageRatio; List<GalleryItem> get gallery;
/// Create a copy of QaItemBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QaItemBlockCopyWith<QaItemBlock> get copyWith => _$QaItemBlockCopyWithImpl<QaItemBlock>(this as QaItemBlock, _$identity);

  /// Serializes this QaItemBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QaItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.image, image) || other.image == image)&&(identical(other.highlightQuote, highlightQuote) || other.highlightQuote == highlightQuote)&&(identical(other.imageRatio, imageRatio) || other.imageRatio == imageRatio)&&const DeepCollectionEquality().equals(other.gallery, gallery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer,image,highlightQuote,imageRatio,const DeepCollectionEquality().hash(gallery));

@override
String toString() {
  return 'QaItemBlock(id: $id, question: $question, answer: $answer, image: $image, highlightQuote: $highlightQuote, imageRatio: $imageRatio, gallery: $gallery)';
}


}

/// @nodoc
abstract mixin class $QaItemBlockCopyWith<$Res>  {
  factory $QaItemBlockCopyWith(QaItemBlock value, $Res Function(QaItemBlock) _then) = _$QaItemBlockCopyWithImpl;
@useResult
$Res call({
 int id, String question, String answer, String? image,@JsonKey(name: 'highlight_quote') String? highlightQuote,@JsonKey(name: 'image_ratio') String imageRatio, List<GalleryItem> gallery
});




}
/// @nodoc
class _$QaItemBlockCopyWithImpl<$Res>
    implements $QaItemBlockCopyWith<$Res> {
  _$QaItemBlockCopyWithImpl(this._self, this._then);

  final QaItemBlock _self;
  final $Res Function(QaItemBlock) _then;

/// Create a copy of QaItemBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? image = freezed,Object? highlightQuote = freezed,Object? imageRatio = null,Object? gallery = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,highlightQuote: freezed == highlightQuote ? _self.highlightQuote : highlightQuote // ignore: cast_nullable_to_non_nullable
as String?,imageRatio: null == imageRatio ? _self.imageRatio : imageRatio // ignore: cast_nullable_to_non_nullable
as String,gallery: null == gallery ? _self.gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [QaItemBlock].
extension QaItemBlockPatterns on QaItemBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QaItemBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QaItemBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QaItemBlock value)  $default,){
final _that = this;
switch (_that) {
case _QaItemBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QaItemBlock value)?  $default,){
final _that = this;
switch (_that) {
case _QaItemBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String question,  String answer,  String? image, @JsonKey(name: 'highlight_quote')  String? highlightQuote, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QaItemBlock() when $default != null:
return $default(_that.id,_that.question,_that.answer,_that.image,_that.highlightQuote,_that.imageRatio,_that.gallery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String question,  String answer,  String? image, @JsonKey(name: 'highlight_quote')  String? highlightQuote, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery)  $default,) {final _that = this;
switch (_that) {
case _QaItemBlock():
return $default(_that.id,_that.question,_that.answer,_that.image,_that.highlightQuote,_that.imageRatio,_that.gallery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String question,  String answer,  String? image, @JsonKey(name: 'highlight_quote')  String? highlightQuote, @JsonKey(name: 'image_ratio')  String imageRatio,  List<GalleryItem> gallery)?  $default,) {final _that = this;
switch (_that) {
case _QaItemBlock() when $default != null:
return $default(_that.id,_that.question,_that.answer,_that.image,_that.highlightQuote,_that.imageRatio,_that.gallery);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QaItemBlock implements QaItemBlock {
  const _QaItemBlock({this.id = 0, this.question = '', this.answer = '', this.image, @JsonKey(name: 'highlight_quote') this.highlightQuote, @JsonKey(name: 'image_ratio') this.imageRatio = 'landscape_4_3', final  List<GalleryItem> gallery = const []}): _gallery = gallery;
  factory _QaItemBlock.fromJson(Map<String, dynamic> json) => _$QaItemBlockFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String question;
@override@JsonKey() final  String answer;
@override final  String? image;
@override@JsonKey(name: 'highlight_quote') final  String? highlightQuote;
@override@JsonKey(name: 'image_ratio') final  String imageRatio;
 final  List<GalleryItem> _gallery;
@override@JsonKey() List<GalleryItem> get gallery {
  if (_gallery is EqualUnmodifiableListView) return _gallery;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gallery);
}


/// Create a copy of QaItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QaItemBlockCopyWith<_QaItemBlock> get copyWith => __$QaItemBlockCopyWithImpl<_QaItemBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QaItemBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QaItemBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.image, image) || other.image == image)&&(identical(other.highlightQuote, highlightQuote) || other.highlightQuote == highlightQuote)&&(identical(other.imageRatio, imageRatio) || other.imageRatio == imageRatio)&&const DeepCollectionEquality().equals(other._gallery, _gallery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer,image,highlightQuote,imageRatio,const DeepCollectionEquality().hash(_gallery));

@override
String toString() {
  return 'QaItemBlock(id: $id, question: $question, answer: $answer, image: $image, highlightQuote: $highlightQuote, imageRatio: $imageRatio, gallery: $gallery)';
}


}

/// @nodoc
abstract mixin class _$QaItemBlockCopyWith<$Res> implements $QaItemBlockCopyWith<$Res> {
  factory _$QaItemBlockCopyWith(_QaItemBlock value, $Res Function(_QaItemBlock) _then) = __$QaItemBlockCopyWithImpl;
@override @useResult
$Res call({
 int id, String question, String answer, String? image,@JsonKey(name: 'highlight_quote') String? highlightQuote,@JsonKey(name: 'image_ratio') String imageRatio, List<GalleryItem> gallery
});




}
/// @nodoc
class __$QaItemBlockCopyWithImpl<$Res>
    implements _$QaItemBlockCopyWith<$Res> {
  __$QaItemBlockCopyWithImpl(this._self, this._then);

  final _QaItemBlock _self;
  final $Res Function(_QaItemBlock) _then;

/// Create a copy of QaItemBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? image = freezed,Object? highlightQuote = freezed,Object? imageRatio = null,Object? gallery = null,}) {
  return _then(_QaItemBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,highlightQuote: freezed == highlightQuote ? _self.highlightQuote : highlightQuote // ignore: cast_nullable_to_non_nullable
as String?,imageRatio: null == imageRatio ? _self.imageRatio : imageRatio // ignore: cast_nullable_to_non_nullable
as String,gallery: null == gallery ? _self._gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<GalleryItem>,
  ));
}


}


/// @nodoc
mixin _$GalleryItem {

 int get id;@JsonKey(name: 'directus_files_id') String get directusFilesId;
/// Create a copy of GalleryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryItemCopyWith<GalleryItem> get copyWith => _$GalleryItemCopyWithImpl<GalleryItem>(this as GalleryItem, _$identity);

  /// Serializes this GalleryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.directusFilesId, directusFilesId) || other.directusFilesId == directusFilesId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,directusFilesId);

@override
String toString() {
  return 'GalleryItem(id: $id, directusFilesId: $directusFilesId)';
}


}

/// @nodoc
abstract mixin class $GalleryItemCopyWith<$Res>  {
  factory $GalleryItemCopyWith(GalleryItem value, $Res Function(GalleryItem) _then) = _$GalleryItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'directus_files_id') String directusFilesId
});




}
/// @nodoc
class _$GalleryItemCopyWithImpl<$Res>
    implements $GalleryItemCopyWith<$Res> {
  _$GalleryItemCopyWithImpl(this._self, this._then);

  final GalleryItem _self;
  final $Res Function(GalleryItem) _then;

/// Create a copy of GalleryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? directusFilesId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,directusFilesId: null == directusFilesId ? _self.directusFilesId : directusFilesId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryItem].
extension GalleryItemPatterns on GalleryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryItem value)  $default,){
final _that = this;
switch (_that) {
case _GalleryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryItem value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'directus_files_id')  String directusFilesId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryItem() when $default != null:
return $default(_that.id,_that.directusFilesId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'directus_files_id')  String directusFilesId)  $default,) {final _that = this;
switch (_that) {
case _GalleryItem():
return $default(_that.id,_that.directusFilesId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'directus_files_id')  String directusFilesId)?  $default,) {final _that = this;
switch (_that) {
case _GalleryItem() when $default != null:
return $default(_that.id,_that.directusFilesId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GalleryItem implements GalleryItem {
  const _GalleryItem({this.id = 0, @JsonKey(name: 'directus_files_id') this.directusFilesId = ''});
  factory _GalleryItem.fromJson(Map<String, dynamic> json) => _$GalleryItemFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'directus_files_id') final  String directusFilesId;

/// Create a copy of GalleryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryItemCopyWith<_GalleryItem> get copyWith => __$GalleryItemCopyWithImpl<_GalleryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GalleryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.directusFilesId, directusFilesId) || other.directusFilesId == directusFilesId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,directusFilesId);

@override
String toString() {
  return 'GalleryItem(id: $id, directusFilesId: $directusFilesId)';
}


}

/// @nodoc
abstract mixin class _$GalleryItemCopyWith<$Res> implements $GalleryItemCopyWith<$Res> {
  factory _$GalleryItemCopyWith(_GalleryItem value, $Res Function(_GalleryItem) _then) = __$GalleryItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'directus_files_id') String directusFilesId
});




}
/// @nodoc
class __$GalleryItemCopyWithImpl<$Res>
    implements _$GalleryItemCopyWith<$Res> {
  __$GalleryItemCopyWithImpl(this._self, this._then);

  final _GalleryItem _self;
  final $Res Function(_GalleryItem) _then;

/// Create a copy of GalleryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? directusFilesId = null,}) {
  return _then(_GalleryItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,directusFilesId: null == directusFilesId ? _self.directusFilesId : directusFilesId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
