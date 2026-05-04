// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleListState {

 List<Article> get articles; bool get isLoading; String? get errorMessage;
/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleListStateCopyWith<ArticleListState> get copyWith => _$ArticleListStateCopyWithImpl<ArticleListState>(this as ArticleListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleListState&&const DeepCollectionEquality().equals(other.articles, articles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(articles),isLoading,errorMessage);

@override
String toString() {
  return 'ArticleListState(articles: $articles, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ArticleListStateCopyWith<$Res>  {
  factory $ArticleListStateCopyWith(ArticleListState value, $Res Function(ArticleListState) _then) = _$ArticleListStateCopyWithImpl;
@useResult
$Res call({
 List<Article> articles, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$ArticleListStateCopyWithImpl<$Res>
    implements $ArticleListStateCopyWith<$Res> {
  _$ArticleListStateCopyWithImpl(this._self, this._then);

  final ArticleListState _self;
  final $Res Function(ArticleListState) _then;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? articles = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleListState].
extension ArticleListStatePatterns on ArticleListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleListState value)  $default,){
final _that = this;
switch (_that) {
case _ArticleListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleListState value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Article> articles,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleListState() when $default != null:
return $default(_that.articles,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Article> articles,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ArticleListState():
return $default(_that.articles,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Article> articles,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ArticleListState() when $default != null:
return $default(_that.articles,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleListState implements ArticleListState {
   _ArticleListState({required final  List<Article> articles, required this.isLoading, this.errorMessage}): _articles = articles;
  

 final  List<Article> _articles;
@override List<Article> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleListStateCopyWith<_ArticleListState> get copyWith => __$ArticleListStateCopyWithImpl<_ArticleListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleListState&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),isLoading,errorMessage);

@override
String toString() {
  return 'ArticleListState(articles: $articles, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ArticleListStateCopyWith<$Res> implements $ArticleListStateCopyWith<$Res> {
  factory _$ArticleListStateCopyWith(_ArticleListState value, $Res Function(_ArticleListState) _then) = __$ArticleListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Article> articles, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$ArticleListStateCopyWithImpl<$Res>
    implements _$ArticleListStateCopyWith<$Res> {
  __$ArticleListStateCopyWithImpl(this._self, this._then);

  final _ArticleListState _self;
  final $Res Function(_ArticleListState) _then;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_ArticleListState(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
