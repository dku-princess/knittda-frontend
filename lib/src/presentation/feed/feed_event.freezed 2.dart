// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {

 int get size; List<String>? get sort;
/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEventCopyWith<FeedEvent> get copyWith => _$FeedEventCopyWithImpl<FeedEvent>(this as FeedEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other.sort, sort));
}


@override
int get hashCode => Object.hash(runtimeType,size,const DeepCollectionEquality().hash(sort));

@override
String toString() {
  return 'FeedEvent(size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $FeedEventCopyWith<$Res>  {
  factory $FeedEventCopyWith(FeedEvent value, $Res Function(FeedEvent) _then) = _$FeedEventCopyWithImpl;
@useResult
$Res call({
 int size, List<String>? sort
});




}
/// @nodoc
class _$FeedEventCopyWithImpl<$Res>
    implements $FeedEventCopyWith<$Res> {
  _$FeedEventCopyWithImpl(this._self, this._then);

  final FeedEvent _self;
  final $Res Function(FeedEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? size = null,Object? sort = freezed,}) {
  return _then(_self.copyWith(
size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,sort: freezed == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadFeed value)?  loadFeed,TResult Function( Refresh value)?  refresh,TResult Function( LoadNext value)?  loadNext,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadFeed() when loadFeed != null:
return loadFeed(_that);case Refresh() when refresh != null:
return refresh(_that);case LoadNext() when loadNext != null:
return loadNext(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadFeed value)  loadFeed,required TResult Function( Refresh value)  refresh,required TResult Function( LoadNext value)  loadNext,}){
final _that = this;
switch (_that) {
case LoadFeed():
return loadFeed(_that);case Refresh():
return refresh(_that);case LoadNext():
return loadNext(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadFeed value)?  loadFeed,TResult? Function( Refresh value)?  refresh,TResult? Function( LoadNext value)?  loadNext,}){
final _that = this;
switch (_that) {
case LoadFeed() when loadFeed != null:
return loadFeed(_that);case Refresh() when refresh != null:
return refresh(_that);case LoadNext() when loadNext != null:
return loadNext(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  int size,  List<String>? sort)?  loadFeed,TResult Function( int size,  List<String>? sort)?  refresh,TResult Function( int size,  List<String>? sort)?  loadNext,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadFeed() when loadFeed != null:
return loadFeed(_that.page,_that.size,_that.sort);case Refresh() when refresh != null:
return refresh(_that.size,_that.sort);case LoadNext() when loadNext != null:
return loadNext(_that.size,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  int size,  List<String>? sort)  loadFeed,required TResult Function( int size,  List<String>? sort)  refresh,required TResult Function( int size,  List<String>? sort)  loadNext,}) {final _that = this;
switch (_that) {
case LoadFeed():
return loadFeed(_that.page,_that.size,_that.sort);case Refresh():
return refresh(_that.size,_that.sort);case LoadNext():
return loadNext(_that.size,_that.sort);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  int size,  List<String>? sort)?  loadFeed,TResult? Function( int size,  List<String>? sort)?  refresh,TResult? Function( int size,  List<String>? sort)?  loadNext,}) {final _that = this;
switch (_that) {
case LoadFeed() when loadFeed != null:
return loadFeed(_that.page,_that.size,_that.sort);case Refresh() when refresh != null:
return refresh(_that.size,_that.sort);case LoadNext() when loadNext != null:
return loadNext(_that.size,_that.sort);case _:
  return null;

}
}

}

/// @nodoc


class LoadFeed implements FeedEvent {
  const LoadFeed(this.page, this.size, final  List<String>? sort): _sort = sort;
  

 final  int page;
@override final  int size;
 final  List<String>? _sort;
@override List<String>? get sort {
  final value = _sort;
  if (value == null) return null;
  if (_sort is EqualUnmodifiableListView) return _sort;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadFeedCopyWith<LoadFeed> get copyWith => _$LoadFeedCopyWithImpl<LoadFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFeed&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._sort, _sort));
}


@override
int get hashCode => Object.hash(runtimeType,page,size,const DeepCollectionEquality().hash(_sort));

@override
String toString() {
  return 'FeedEvent.loadFeed(page: $page, size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $LoadFeedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $LoadFeedCopyWith(LoadFeed value, $Res Function(LoadFeed) _then) = _$LoadFeedCopyWithImpl;
@override @useResult
$Res call({
 int page, int size, List<String>? sort
});




}
/// @nodoc
class _$LoadFeedCopyWithImpl<$Res>
    implements $LoadFeedCopyWith<$Res> {
  _$LoadFeedCopyWithImpl(this._self, this._then);

  final LoadFeed _self;
  final $Res Function(LoadFeed) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? size = null,Object? sort = freezed,}) {
  return _then(LoadFeed(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,freezed == sort ? _self._sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class Refresh implements FeedEvent {
  const Refresh(this.size, final  List<String>? sort): _sort = sort;
  

@override final  int size;
 final  List<String>? _sort;
@override List<String>? get sort {
  final value = _sort;
  if (value == null) return null;
  if (_sort is EqualUnmodifiableListView) return _sort;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshCopyWith<Refresh> get copyWith => _$RefreshCopyWithImpl<Refresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refresh&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._sort, _sort));
}


@override
int get hashCode => Object.hash(runtimeType,size,const DeepCollectionEquality().hash(_sort));

@override
String toString() {
  return 'FeedEvent.refresh(size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $RefreshCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $RefreshCopyWith(Refresh value, $Res Function(Refresh) _then) = _$RefreshCopyWithImpl;
@override @useResult
$Res call({
 int size, List<String>? sort
});




}
/// @nodoc
class _$RefreshCopyWithImpl<$Res>
    implements $RefreshCopyWith<$Res> {
  _$RefreshCopyWithImpl(this._self, this._then);

  final Refresh _self;
  final $Res Function(Refresh) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? size = null,Object? sort = freezed,}) {
  return _then(Refresh(
null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,freezed == sort ? _self._sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class LoadNext implements FeedEvent {
  const LoadNext(this.size, final  List<String>? sort): _sort = sort;
  

@override final  int size;
 final  List<String>? _sort;
@override List<String>? get sort {
  final value = _sort;
  if (value == null) return null;
  if (_sort is EqualUnmodifiableListView) return _sort;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
  return 'FeedEvent.loadNext(size: $size, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $LoadNextCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $LoadNextCopyWith(LoadNext value, $Res Function(LoadNext) _then) = _$LoadNextCopyWithImpl;
@override @useResult
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

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? size = null,Object? sort = freezed,}) {
  return _then(LoadNext(
null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,freezed == sort ? _self._sort : sort // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
