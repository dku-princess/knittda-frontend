// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_search_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedSearchEvent()';
}


}

/// @nodoc
class $FeedSearchEventCopyWith<$Res>  {
$FeedSearchEventCopyWith(FeedSearchEvent _, $Res Function(FeedSearchEvent) __);
}


/// Adds pattern-matching-related methods to [FeedSearchEvent].
extension FeedSearchEventPatterns on FeedSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchFeed value)?  searchFeed,TResult Function( LoadNext value)?  loadNext,TResult Function( Clear value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchFeed() when searchFeed != null:
return searchFeed(_that);case LoadNext() when loadNext != null:
return loadNext(_that);case Clear() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchFeed value)  searchFeed,required TResult Function( LoadNext value)  loadNext,required TResult Function( Clear value)  clear,}){
final _that = this;
switch (_that) {
case SearchFeed():
return searchFeed(_that);case LoadNext():
return loadNext(_that);case Clear():
return clear(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchFeed value)?  searchFeed,TResult? Function( LoadNext value)?  loadNext,TResult? Function( Clear value)?  clear,}){
final _that = this;
switch (_that) {
case SearchFeed() when searchFeed != null:
return searchFeed(_that);case LoadNext() when loadNext != null:
return loadNext(_that);case Clear() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String keyword,  int page,  int size,  List<String>? sort)?  searchFeed,TResult Function( int size,  List<String>? sort)?  loadNext,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchFeed() when searchFeed != null:
return searchFeed(_that.keyword,_that.page,_that.size,_that.sort);case LoadNext() when loadNext != null:
return loadNext(_that.size,_that.sort);case Clear() when clear != null:
return clear();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String keyword,  int page,  int size,  List<String>? sort)  searchFeed,required TResult Function( int size,  List<String>? sort)  loadNext,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case SearchFeed():
return searchFeed(_that.keyword,_that.page,_that.size,_that.sort);case LoadNext():
return loadNext(_that.size,_that.sort);case Clear():
return clear();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String keyword,  int page,  int size,  List<String>? sort)?  searchFeed,TResult? Function( int size,  List<String>? sort)?  loadNext,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case SearchFeed() when searchFeed != null:
return searchFeed(_that.keyword,_that.page,_that.size,_that.sort);case LoadNext() when loadNext != null:
return loadNext(_that.size,_that.sort);case Clear() when clear != null:
return clear();case _:
  return null;

}
}

}

/// @nodoc


class SearchFeed implements FeedSearchEvent {
  const SearchFeed(this.keyword, this.page, this.size, final  List<String>? sort): _sort = sort;
  

 final  String keyword;
 final  int page;
 final  int size;
 final  List<String>? _sort;
 List<String>? get sort {
  final value = _sort;
  if (value == null) return null;
  if (_sort is EqualUnmodifiableListView) return _sort;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeedSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFeedCopyWith<SearchFeed> get copyWith => _$SearchFeedCopyWithImpl<SearchFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFeed&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._sort, _sort));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,page,size,const DeepCollectionEquality().hash(_sort));

@override
String toString() {
  return 'FeedSearchEvent.searchFeed(keyword: $keyword, page: $page, size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $SearchFeedCopyWith<$Res> implements $FeedSearchEventCopyWith<$Res> {
  factory $SearchFeedCopyWith(SearchFeed value, $Res Function(SearchFeed) _then) = _$SearchFeedCopyWithImpl;
@useResult
$Res call({
 String keyword, int page, int size, List<String>? sort
});




}
/// @nodoc
class _$SearchFeedCopyWithImpl<$Res>
    implements $SearchFeedCopyWith<$Res> {
  _$SearchFeedCopyWithImpl(this._self, this._then);

  final SearchFeed _self;
  final $Res Function(SearchFeed) _then;

/// Create a copy of FeedSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,Object? page = null,Object? size = null,Object? sort = freezed,}) {
  return _then(SearchFeed(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,freezed == sort ? _self._sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class LoadNext implements FeedSearchEvent {
  const LoadNext(this.size, final  List<String>? sort): _sort = sort;
  

 final  int size;
 final  List<String>? _sort;
 List<String>? get sort {
  final value = _sort;
  if (value == null) return null;
  if (_sort is EqualUnmodifiableListView) return _sort;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeedSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadNextCopyWith<LoadNext> get copyWith => _$LoadNextCopyWithImpl<LoadNext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadNext&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._sort, _sort));
}


@override
int get hashCode => Object.hash(runtimeType,size,const DeepCollectionEquality().hash(_sort));

@override
String toString() {
  return 'FeedSearchEvent.loadNext(size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $LoadNextCopyWith<$Res> implements $FeedSearchEventCopyWith<$Res> {
  factory $LoadNextCopyWith(LoadNext value, $Res Function(LoadNext) _then) = _$LoadNextCopyWithImpl;
@useResult
$Res call({
 int size, List<String>? sort
});




}
/// @nodoc
class _$LoadNextCopyWithImpl<$Res>
    implements $LoadNextCopyWith<$Res> {
  _$LoadNextCopyWithImpl(this._self, this._then);

  final LoadNext _self;
  final $Res Function(LoadNext) _then;

/// Create a copy of FeedSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? size = null,Object? sort = freezed,}) {
  return _then(LoadNext(
null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,freezed == sort ? _self._sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class Clear implements FeedSearchEvent {
  const Clear();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Clear);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedSearchEvent.clear()';
}


}




// dart format on
