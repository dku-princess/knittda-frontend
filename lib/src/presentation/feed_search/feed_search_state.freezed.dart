// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedSearchState {

 List<Feed> get feeds; bool get isLoading; String get keyword; int get page; bool get hasMore; bool get isLoadingMore; String? get searchId; String? get searchVersion;
/// Create a copy of FeedSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedSearchStateCopyWith<FeedSearchState> get copyWith => _$FeedSearchStateCopyWithImpl<FeedSearchState>(this as FeedSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedSearchState&&const DeepCollectionEquality().equals(other.feeds, feeds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchId, searchId) || other.searchId == searchId)&&(identical(other.searchVersion, searchVersion) || other.searchVersion == searchVersion));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(feeds),isLoading,keyword,page,hasMore,isLoadingMore,searchId,searchVersion);

@override
String toString() {
  return 'FeedSearchState(feeds: $feeds, isLoading: $isLoading, keyword: $keyword, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, searchId: $searchId, searchVersion: $searchVersion)';
}


}

/// @nodoc
abstract mixin class $FeedSearchStateCopyWith<$Res>  {
  factory $FeedSearchStateCopyWith(FeedSearchState value, $Res Function(FeedSearchState) _then) = _$FeedSearchStateCopyWithImpl;
@useResult
$Res call({
 List<Feed> feeds, bool isLoading, String keyword, int page, bool hasMore, bool isLoadingMore, String? searchId, String? searchVersion
});




}
/// @nodoc
class _$FeedSearchStateCopyWithImpl<$Res>
    implements $FeedSearchStateCopyWith<$Res> {
  _$FeedSearchStateCopyWithImpl(this._self, this._then);

  final FeedSearchState _self;
  final $Res Function(FeedSearchState) _then;

/// Create a copy of FeedSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feeds = null,Object? isLoading = null,Object? keyword = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? searchId = freezed,Object? searchVersion = freezed,}) {
  return _then(_self.copyWith(
feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<Feed>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchId: freezed == searchId ? _self.searchId : searchId // ignore: cast_nullable_to_non_nullable
as String?,searchVersion: freezed == searchVersion ? _self.searchVersion : searchVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedSearchState].
extension FeedSearchStatePatterns on FeedSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedSearchState value)  $default,){
final _that = this;
switch (_that) {
case _FeedSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Feed> feeds,  bool isLoading,  String keyword,  int page,  bool hasMore,  bool isLoadingMore,  String? searchId,  String? searchVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedSearchState() when $default != null:
return $default(_that.feeds,_that.isLoading,_that.keyword,_that.page,_that.hasMore,_that.isLoadingMore,_that.searchId,_that.searchVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Feed> feeds,  bool isLoading,  String keyword,  int page,  bool hasMore,  bool isLoadingMore,  String? searchId,  String? searchVersion)  $default,) {final _that = this;
switch (_that) {
case _FeedSearchState():
return $default(_that.feeds,_that.isLoading,_that.keyword,_that.page,_that.hasMore,_that.isLoadingMore,_that.searchId,_that.searchVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Feed> feeds,  bool isLoading,  String keyword,  int page,  bool hasMore,  bool isLoadingMore,  String? searchId,  String? searchVersion)?  $default,) {final _that = this;
switch (_that) {
case _FeedSearchState() when $default != null:
return $default(_that.feeds,_that.isLoading,_that.keyword,_that.page,_that.hasMore,_that.isLoadingMore,_that.searchId,_that.searchVersion);case _:
  return null;

}
}

}

/// @nodoc


class _FeedSearchState implements FeedSearchState {
   _FeedSearchState({required final  List<Feed> feeds, required this.isLoading, required this.keyword, required this.page, required this.hasMore, required this.isLoadingMore, this.searchId, this.searchVersion}): _feeds = feeds;
  

 final  List<Feed> _feeds;
@override List<Feed> get feeds {
  if (_feeds is EqualUnmodifiableListView) return _feeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feeds);
}

@override final  bool isLoading;
@override final  String keyword;
@override final  int page;
@override final  bool hasMore;
@override final  bool isLoadingMore;
@override final  String? searchId;
@override final  String? searchVersion;

/// Create a copy of FeedSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedSearchStateCopyWith<_FeedSearchState> get copyWith => __$FeedSearchStateCopyWithImpl<_FeedSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedSearchState&&const DeepCollectionEquality().equals(other._feeds, _feeds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.searchId, searchId) || other.searchId == searchId)&&(identical(other.searchVersion, searchVersion) || other.searchVersion == searchVersion));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_feeds),isLoading,keyword,page,hasMore,isLoadingMore,searchId,searchVersion);

@override
String toString() {
  return 'FeedSearchState(feeds: $feeds, isLoading: $isLoading, keyword: $keyword, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, searchId: $searchId, searchVersion: $searchVersion)';
}


}

/// @nodoc
abstract mixin class _$FeedSearchStateCopyWith<$Res> implements $FeedSearchStateCopyWith<$Res> {
  factory _$FeedSearchStateCopyWith(_FeedSearchState value, $Res Function(_FeedSearchState) _then) = __$FeedSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<Feed> feeds, bool isLoading, String keyword, int page, bool hasMore, bool isLoadingMore, String? searchId, String? searchVersion
});




}
/// @nodoc
class __$FeedSearchStateCopyWithImpl<$Res>
    implements _$FeedSearchStateCopyWith<$Res> {
  __$FeedSearchStateCopyWithImpl(this._self, this._then);

  final _FeedSearchState _self;
  final $Res Function(_FeedSearchState) _then;

/// Create a copy of FeedSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feeds = null,Object? isLoading = null,Object? keyword = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? searchId = freezed,Object? searchVersion = freezed,}) {
  return _then(_FeedSearchState(
feeds: null == feeds ? _self._feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<Feed>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,searchId: freezed == searchId ? _self.searchId : searchId // ignore: cast_nullable_to_non_nullable
as String?,searchVersion: freezed == searchVersion ? _self.searchVersion : searchVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
