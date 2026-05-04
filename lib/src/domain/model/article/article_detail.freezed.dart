// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleDetail {

 int get id; String get title; String get subtitle; String get category; String get editor; String get interviewee;@JsonKey(name: 'thumbnail_image_large') String get thumbnailImageLarge;@JsonKey(name: 'thumbnail_image_small') String get thumbnailImageSmall;@JsonKey(name: 'cover_image') String? get coverImage;@JsonKey(name: 'published_at') String get publishedAt;@JsonKey(name: 'is_featured') bool get isFeatured; String get slug; String get status; List<ArticleSection> get sections;
/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDetailCopyWith<ArticleDetail> get copyWith => _$ArticleDetailCopyWithImpl<ArticleDetail>(this as ArticleDetail, _$identity);

  /// Serializes this ArticleDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.category, category) || other.category == category)&&(identical(other.editor, editor) || other.editor == editor)&&(identical(other.interviewee, interviewee) || other.interviewee == interviewee)&&(identical(other.thumbnailImageLarge, thumbnailImageLarge) || other.thumbnailImageLarge == thumbnailImageLarge)&&(identical(other.thumbnailImageSmall, thumbnailImageSmall) || other.thumbnailImageSmall == thumbnailImageSmall)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,category,editor,interviewee,thumbnailImageLarge,thumbnailImageSmall,coverImage,publishedAt,isFeatured,slug,status,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'ArticleDetail(id: $id, title: $title, subtitle: $subtitle, category: $category, editor: $editor, interviewee: $interviewee, thumbnailImageLarge: $thumbnailImageLarge, thumbnailImageSmall: $thumbnailImageSmall, coverImage: $coverImage, publishedAt: $publishedAt, isFeatured: $isFeatured, slug: $slug, status: $status, sections: $sections)';
}


}

/// @nodoc
abstract mixin class $ArticleDetailCopyWith<$Res>  {
  factory $ArticleDetailCopyWith(ArticleDetail value, $Res Function(ArticleDetail) _then) = _$ArticleDetailCopyWithImpl;
@useResult
$Res call({
 int id, String title, String subtitle, String category, String editor, String interviewee,@JsonKey(name: 'thumbnail_image_large') String thumbnailImageLarge,@JsonKey(name: 'thumbnail_image_small') String thumbnailImageSmall,@JsonKey(name: 'cover_image') String? coverImage,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(name: 'is_featured') bool isFeatured, String slug, String status, List<ArticleSection> sections
});




}
/// @nodoc
class _$ArticleDetailCopyWithImpl<$Res>
    implements $ArticleDetailCopyWith<$Res> {
  _$ArticleDetailCopyWithImpl(this._self, this._then);

  final ArticleDetail _self;
  final $Res Function(ArticleDetail) _then;

/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? category = null,Object? editor = null,Object? interviewee = null,Object? thumbnailImageLarge = null,Object? thumbnailImageSmall = null,Object? coverImage = freezed,Object? publishedAt = null,Object? isFeatured = null,Object? slug = null,Object? status = null,Object? sections = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,editor: null == editor ? _self.editor : editor // ignore: cast_nullable_to_non_nullable
as String,interviewee: null == interviewee ? _self.interviewee : interviewee // ignore: cast_nullable_to_non_nullable
as String,thumbnailImageLarge: null == thumbnailImageLarge ? _self.thumbnailImageLarge : thumbnailImageLarge // ignore: cast_nullable_to_non_nullable
as String,thumbnailImageSmall: null == thumbnailImageSmall ? _self.thumbnailImageSmall : thumbnailImageSmall // ignore: cast_nullable_to_non_nullable
as String,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ArticleSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleDetail].
extension ArticleDetailPatterns on ArticleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDetail value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String subtitle,  String category,  String editor,  String interviewee, @JsonKey(name: 'thumbnail_image_large')  String thumbnailImageLarge, @JsonKey(name: 'thumbnail_image_small')  String thumbnailImageSmall, @JsonKey(name: 'cover_image')  String? coverImage, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(name: 'is_featured')  bool isFeatured,  String slug,  String status,  List<ArticleSection> sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.editor,_that.interviewee,_that.thumbnailImageLarge,_that.thumbnailImageSmall,_that.coverImage,_that.publishedAt,_that.isFeatured,_that.slug,_that.status,_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String subtitle,  String category,  String editor,  String interviewee, @JsonKey(name: 'thumbnail_image_large')  String thumbnailImageLarge, @JsonKey(name: 'thumbnail_image_small')  String thumbnailImageSmall, @JsonKey(name: 'cover_image')  String? coverImage, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(name: 'is_featured')  bool isFeatured,  String slug,  String status,  List<ArticleSection> sections)  $default,) {final _that = this;
switch (_that) {
case _ArticleDetail():
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.editor,_that.interviewee,_that.thumbnailImageLarge,_that.thumbnailImageSmall,_that.coverImage,_that.publishedAt,_that.isFeatured,_that.slug,_that.status,_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String subtitle,  String category,  String editor,  String interviewee, @JsonKey(name: 'thumbnail_image_large')  String thumbnailImageLarge, @JsonKey(name: 'thumbnail_image_small')  String thumbnailImageSmall, @JsonKey(name: 'cover_image')  String? coverImage, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(name: 'is_featured')  bool isFeatured,  String slug,  String status,  List<ArticleSection> sections)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDetail() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.editor,_that.interviewee,_that.thumbnailImageLarge,_that.thumbnailImageSmall,_that.coverImage,_that.publishedAt,_that.isFeatured,_that.slug,_that.status,_that.sections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleDetail implements ArticleDetail {
  const _ArticleDetail({this.id = 0, this.title = '', this.subtitle = '', this.category = '', this.editor = '', this.interviewee = '', @JsonKey(name: 'thumbnail_image_large') this.thumbnailImageLarge = '', @JsonKey(name: 'thumbnail_image_small') this.thumbnailImageSmall = '', @JsonKey(name: 'cover_image') this.coverImage, @JsonKey(name: 'published_at') this.publishedAt = '', @JsonKey(name: 'is_featured') this.isFeatured = false, this.slug = '', this.status = '', final  List<ArticleSection> sections = const []}): _sections = sections;
  factory _ArticleDetail.fromJson(Map<String, dynamic> json) => _$ArticleDetailFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String subtitle;
@override@JsonKey() final  String category;
@override@JsonKey() final  String editor;
@override@JsonKey() final  String interviewee;
@override@JsonKey(name: 'thumbnail_image_large') final  String thumbnailImageLarge;
@override@JsonKey(name: 'thumbnail_image_small') final  String thumbnailImageSmall;
@override@JsonKey(name: 'cover_image') final  String? coverImage;
@override@JsonKey(name: 'published_at') final  String publishedAt;
@override@JsonKey(name: 'is_featured') final  bool isFeatured;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String status;
 final  List<ArticleSection> _sections;
@override@JsonKey() List<ArticleSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDetailCopyWith<_ArticleDetail> get copyWith => __$ArticleDetailCopyWithImpl<_ArticleDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.category, category) || other.category == category)&&(identical(other.editor, editor) || other.editor == editor)&&(identical(other.interviewee, interviewee) || other.interviewee == interviewee)&&(identical(other.thumbnailImageLarge, thumbnailImageLarge) || other.thumbnailImageLarge == thumbnailImageLarge)&&(identical(other.thumbnailImageSmall, thumbnailImageSmall) || other.thumbnailImageSmall == thumbnailImageSmall)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,category,editor,interviewee,thumbnailImageLarge,thumbnailImageSmall,coverImage,publishedAt,isFeatured,slug,status,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'ArticleDetail(id: $id, title: $title, subtitle: $subtitle, category: $category, editor: $editor, interviewee: $interviewee, thumbnailImageLarge: $thumbnailImageLarge, thumbnailImageSmall: $thumbnailImageSmall, coverImage: $coverImage, publishedAt: $publishedAt, isFeatured: $isFeatured, slug: $slug, status: $status, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$ArticleDetailCopyWith<$Res> implements $ArticleDetailCopyWith<$Res> {
  factory _$ArticleDetailCopyWith(_ArticleDetail value, $Res Function(_ArticleDetail) _then) = __$ArticleDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String subtitle, String category, String editor, String interviewee,@JsonKey(name: 'thumbnail_image_large') String thumbnailImageLarge,@JsonKey(name: 'thumbnail_image_small') String thumbnailImageSmall,@JsonKey(name: 'cover_image') String? coverImage,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(name: 'is_featured') bool isFeatured, String slug, String status, List<ArticleSection> sections
});




}
/// @nodoc
class __$ArticleDetailCopyWithImpl<$Res>
    implements _$ArticleDetailCopyWith<$Res> {
  __$ArticleDetailCopyWithImpl(this._self, this._then);

  final _ArticleDetail _self;
  final $Res Function(_ArticleDetail) _then;

/// Create a copy of ArticleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? category = null,Object? editor = null,Object? interviewee = null,Object? thumbnailImageLarge = null,Object? thumbnailImageSmall = null,Object? coverImage = freezed,Object? publishedAt = null,Object? isFeatured = null,Object? slug = null,Object? status = null,Object? sections = null,}) {
  return _then(_ArticleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,editor: null == editor ? _self.editor : editor // ignore: cast_nullable_to_non_nullable
as String,interviewee: null == interviewee ? _self.interviewee : interviewee // ignore: cast_nullable_to_non_nullable
as String,thumbnailImageLarge: null == thumbnailImageLarge ? _self.thumbnailImageLarge : thumbnailImageLarge // ignore: cast_nullable_to_non_nullable
as String,thumbnailImageSmall: null == thumbnailImageSmall ? _self.thumbnailImageSmall : thumbnailImageSmall // ignore: cast_nullable_to_non_nullable
as String,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ArticleSection>,
  ));
}


}

// dart format on
