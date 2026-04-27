// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleDetailState {

 ArticleDetail? get article; bool get isLoading; String? get errorMessage; List<ArticlePreview> get articlePreviews;
/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDetailStateCopyWith<ArticleDetailState> get copyWith => _$ArticleDetailStateCopyWithImpl<ArticleDetailState>(this as ArticleDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDetailState&&(identical(other.article, article) || other.article == article)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.articlePreviews, articlePreviews));
}


@override
int get hashCode => Object.hash(runtimeType,article,isLoading,errorMessage,const DeepCollectionEquality().hash(articlePreviews));

@override
String toString() {
  return 'ArticleDetailState(article: $article, isLoading: $isLoading, errorMessage: $errorMessage, articlePreviews: $articlePreviews)';
}


}

/// @nodoc
abstract mixin class $ArticleDetailStateCopyWith<$Res>  {
  factory $ArticleDetailStateCopyWith(ArticleDetailState value, $Res Function(ArticleDetailState) _then) = _$ArticleDetailStateCopyWithImpl;
@useResult
$Res call({
 ArticleDetail? article, bool isLoading, String? errorMessage, List<ArticlePreview> articlePreviews
});


$ArticleDetailCopyWith<$Res>? get article;

}
/// @nodoc
class _$ArticleDetailStateCopyWithImpl<$Res>
    implements $ArticleDetailStateCopyWith<$Res> {
  _$ArticleDetailStateCopyWithImpl(this._self, this._then);

  final ArticleDetailState _self;
  final $Res Function(ArticleDetailState) _then;

/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? article = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? articlePreviews = null,}) {
  return _then(_self.copyWith(
article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleDetail?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,articlePreviews: null == articlePreviews ? _self.articlePreviews : articlePreviews // ignore: cast_nullable_to_non_nullable
as List<ArticlePreview>,
  ));
}
/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleDetailCopyWith<$Res>? get article {
    if (_self.article == null) {
    return null;
  }

  return $ArticleDetailCopyWith<$Res>(_self.article!, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArticleDetailState].
extension ArticleDetailStatePatterns on ArticleDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDetailState value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ArticleDetail? article,  bool isLoading,  String? errorMessage,  List<ArticlePreview> articlePreviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDetailState() when $default != null:
return $default(_that.article,_that.isLoading,_that.errorMessage,_that.articlePreviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ArticleDetail? article,  bool isLoading,  String? errorMessage,  List<ArticlePreview> articlePreviews)  $default,) {final _that = this;
switch (_that) {
case _ArticleDetailState():
return $default(_that.article,_that.isLoading,_that.errorMessage,_that.articlePreviews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ArticleDetail? article,  bool isLoading,  String? errorMessage,  List<ArticlePreview> articlePreviews)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDetailState() when $default != null:
return $default(_that.article,_that.isLoading,_that.errorMessage,_that.articlePreviews);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleDetailState implements ArticleDetailState {
   _ArticleDetailState({required this.article, required this.isLoading, this.errorMessage, required final  List<ArticlePreview> articlePreviews}): _articlePreviews = articlePreviews;
  

@override final  ArticleDetail? article;
@override final  bool isLoading;
@override final  String? errorMessage;
 final  List<ArticlePreview> _articlePreviews;
@override List<ArticlePreview> get articlePreviews {
  if (_articlePreviews is EqualUnmodifiableListView) return _articlePreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articlePreviews);
}


/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDetailStateCopyWith<_ArticleDetailState> get copyWith => __$ArticleDetailStateCopyWithImpl<_ArticleDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDetailState&&(identical(other.article, article) || other.article == article)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._articlePreviews, _articlePreviews));
}


@override
int get hashCode => Object.hash(runtimeType,article,isLoading,errorMessage,const DeepCollectionEquality().hash(_articlePreviews));

@override
String toString() {
  return 'ArticleDetailState(article: $article, isLoading: $isLoading, errorMessage: $errorMessage, articlePreviews: $articlePreviews)';
}


}

/// @nodoc
abstract mixin class _$ArticleDetailStateCopyWith<$Res> implements $ArticleDetailStateCopyWith<$Res> {
  factory _$ArticleDetailStateCopyWith(_ArticleDetailState value, $Res Function(_ArticleDetailState) _then) = __$ArticleDetailStateCopyWithImpl;
@override @useResult
$Res call({
 ArticleDetail? article, bool isLoading, String? errorMessage, List<ArticlePreview> articlePreviews
});


@override $ArticleDetailCopyWith<$Res>? get article;

}
/// @nodoc
class __$ArticleDetailStateCopyWithImpl<$Res>
    implements _$ArticleDetailStateCopyWith<$Res> {
  __$ArticleDetailStateCopyWithImpl(this._self, this._then);

  final _ArticleDetailState _self;
  final $Res Function(_ArticleDetailState) _then;

/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? article = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? articlePreviews = null,}) {
  return _then(_ArticleDetailState(
article: freezed == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as ArticleDetail?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,articlePreviews: null == articlePreviews ? _self._articlePreviews : articlePreviews // ignore: cast_nullable_to_non_nullable
as List<ArticlePreview>,
  ));
}

/// Create a copy of ArticleDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleDetailCopyWith<$Res>? get article {
    if (_self.article == null) {
    return null;
  }

  return $ArticleDetailCopyWith<$Res>(_self.article!, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}

// dart format on
