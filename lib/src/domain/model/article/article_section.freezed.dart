// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleSection {

 int get id;@JsonKey(name: 'articles_id') int get articlesId; String get collection; int get sort; Map<String, dynamic>? get item;
/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleSectionCopyWith<ArticleSection> get copyWith => _$ArticleSectionCopyWithImpl<ArticleSection>(this as ArticleSection, _$identity);

  /// Serializes this ArticleSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleSection&&(identical(other.id, id) || other.id == id)&&(identical(other.articlesId, articlesId) || other.articlesId == articlesId)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.item, item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,articlesId,collection,sort,const DeepCollectionEquality().hash(item));

@override
String toString() {
  return 'ArticleSection(id: $id, articlesId: $articlesId, collection: $collection, sort: $sort, item: $item)';
}


}

/// @nodoc
abstract mixin class $ArticleSectionCopyWith<$Res>  {
  factory $ArticleSectionCopyWith(ArticleSection value, $Res Function(ArticleSection) _then) = _$ArticleSectionCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'articles_id') int articlesId, String collection, int sort, Map<String, dynamic>? item
});




}
/// @nodoc
class _$ArticleSectionCopyWithImpl<$Res>
    implements $ArticleSectionCopyWith<$Res> {
  _$ArticleSectionCopyWithImpl(this._self, this._then);

  final ArticleSection _self;
  final $Res Function(ArticleSection) _then;

/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? articlesId = null,Object? collection = null,Object? sort = null,Object? item = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,articlesId: null == articlesId ? _self.articlesId : articlesId // ignore: cast_nullable_to_non_nullable
as int,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleSection].
extension ArticleSectionPatterns on ArticleSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleSection value)  $default,){
final _that = this;
switch (_that) {
case _ArticleSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleSection value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'articles_id')  int articlesId,  String collection,  int sort,  Map<String, dynamic>? item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
return $default(_that.id,_that.articlesId,_that.collection,_that.sort,_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'articles_id')  int articlesId,  String collection,  int sort,  Map<String, dynamic>? item)  $default,) {final _that = this;
switch (_that) {
case _ArticleSection():
return $default(_that.id,_that.articlesId,_that.collection,_that.sort,_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'articles_id')  int articlesId,  String collection,  int sort,  Map<String, dynamic>? item)?  $default,) {final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
return $default(_that.id,_that.articlesId,_that.collection,_that.sort,_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleSection implements ArticleSection {
  const _ArticleSection({this.id = 0, @JsonKey(name: 'articles_id') this.articlesId = 0, this.collection = '', this.sort = 0, final  Map<String, dynamic>? item}): _item = item;
  factory _ArticleSection.fromJson(Map<String, dynamic> json) => _$ArticleSectionFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'articles_id') final  int articlesId;
@override@JsonKey() final  String collection;
@override@JsonKey() final  int sort;
 final  Map<String, dynamic>? _item;
@override Map<String, dynamic>? get item {
  final value = _item;
  if (value == null) return null;
  if (_item is EqualUnmodifiableMapView) return _item;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleSectionCopyWith<_ArticleSection> get copyWith => __$ArticleSectionCopyWithImpl<_ArticleSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleSection&&(identical(other.id, id) || other.id == id)&&(identical(other.articlesId, articlesId) || other.articlesId == articlesId)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other._item, _item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,articlesId,collection,sort,const DeepCollectionEquality().hash(_item));

@override
String toString() {
  return 'ArticleSection(id: $id, articlesId: $articlesId, collection: $collection, sort: $sort, item: $item)';
}


}

/// @nodoc
abstract mixin class _$ArticleSectionCopyWith<$Res> implements $ArticleSectionCopyWith<$Res> {
  factory _$ArticleSectionCopyWith(_ArticleSection value, $Res Function(_ArticleSection) _then) = __$ArticleSectionCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'articles_id') int articlesId, String collection, int sort, Map<String, dynamic>? item
});




}
/// @nodoc
class __$ArticleSectionCopyWithImpl<$Res>
    implements _$ArticleSectionCopyWith<$Res> {
  __$ArticleSectionCopyWithImpl(this._self, this._then);

  final _ArticleSection _self;
  final $Res Function(_ArticleSection) _then;

/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? articlesId = null,Object? collection = null,Object? sort = null,Object? item = freezed,}) {
  return _then(_ArticleSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,articlesId: null == articlesId ? _self.articlesId : articlesId // ignore: cast_nullable_to_non_nullable
as int,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as int,item: freezed == item ? _self._item : item // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
