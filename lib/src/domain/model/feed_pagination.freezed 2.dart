// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedPagination {

 int get totalElements; int get totalPages; int get size; List<Feed> get content; int get number; bool get first; bool get last; bool get empty; String? get searchId; String? get searchVersion;
/// Create a copy of FeedPagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPaginationCopyWith<FeedPagination> get copyWith => _$FeedPaginationCopyWithImpl<FeedPagination>(this as FeedPagination, _$identity);

  /// Serializes this FeedPagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPagination&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.number, number) || other.number == number)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.empty, empty) || other.empty == empty)&&(identical(other.searchId, searchId) || other.searchId == searchId)&&(identical(other.searchVersion, searchVersion) || other.searchVersion == searchVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalElements,totalPages,size,const DeepCollectionEquality().hash(content),number,first,last,empty,searchId,searchVersion);

@override
String toString() {
  return 'FeedPagination(totalElements: $totalElements, totalPages: $totalPages, size: $size, content: $content, number: $number, first: $first, last: $last, empty: $empty, searchId: $searchId, searchVersion: $searchVersion)';
}


}

/// @nodoc
abstract mixin class $FeedPaginationCopyWith<$Res>  {
  factory $FeedPaginationCopyWith(FeedPagination value, $Res Function(FeedPagination) _then) = _$FeedPaginationCopyWithImpl;
@useResult
$Res call({
 int totalElements, int totalPages, int size, List<Feed> content, int number, bool first, bool last, bool empty, String? searchId, String? searchVersion
});




}
/// @nodoc
class _$FeedPaginationCopyWithImpl<$Res>
    implements $FeedPaginationCopyWith<$Res> {
  _$FeedPaginationCopyWithImpl(this._self, this._then);

  final FeedPagination _self;
  final $Res Function(FeedPagination) _then;

/// Create a copy of FeedPagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalElements = null,Object? totalPages = null,Object? size = null,Object? content = null,Object? number = null,Object? first = null,Object? last = null,Object? empty = null,Object? searchId = freezed,Object? searchVersion = freezed,}) {
  return _then(_self.copyWith(
totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<Feed>,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool,empty: null == empty ? _self.empty : empty // ignore: cast_nullable_to_non_nullable
as bool,searchId: freezed == searchId ? _self.searchId : searchId // ignore: cast_nullable_to_non_nullable
as String?,searchVersion: freezed == searchVersion ? _self.searchVersion : searchVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedPagination].
extension FeedPaginationPatterns on FeedPagination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedPagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedPagination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedPagination value)  $default,){
final _that = this;
switch (_that) {
case _FeedPagination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedPagination value)?  $default,){
final _that = this;
switch (_that) {
case _FeedPagination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalElements,  int totalPages,  int size,  List<Feed> content,  int number,  bool first,  bool last,  bool empty,  String? searchId,  String? searchVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedPagination() when $default != null:
return $default(_that.totalElements,_that.totalPages,_that.size,_that.content,_that.number,_that.first,_that.last,_that.empty,_that.searchId,_that.searchVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalElements,  int totalPages,  int size,  List<Feed> content,  int number,  bool first,  bool last,  bool empty,  String? searchId,  String? searchVersion)  $default,) {final _that = this;
switch (_that) {
case _FeedPagination():
return $default(_that.totalElements,_that.totalPages,_that.size,_that.content,_that.number,_that.first,_that.last,_that.empty,_that.searchId,_that.searchVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalElements,  int totalPages,  int size,  List<Feed> content,  int number,  bool first,  bool last,  bool empty,  String? searchId,  String? searchVersion)?  $default,) {final _that = this;
switch (_that) {
case _FeedPagination() when $default != null:
return $default(_that.totalElements,_that.totalPages,_that.size,_that.content,_that.number,_that.first,_that.last,_that.empty,_that.searchId,_that.searchVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedPagination implements FeedPagination {
   _FeedPagination({required this.totalElements, required this.totalPages, required this.size, required final  List<Feed> content, required this.number, this.first = false, this.last = false, this.empty = false, this.searchId, this.searchVersion}): _content = content;
  factory _FeedPagination.fromJson(Map<String, dynamic> json) => _$FeedPaginationFromJson(json);

@override final  int totalElements;
@override final  int totalPages;
@override final  int size;
 final  List<Feed> _content;
@override List<Feed> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@override final  int number;
@override@JsonKey() final  bool first;
@override@JsonKey() final  bool last;
@override@JsonKey() final  bool empty;
@override final  String? searchId;
@override final  String? searchVersion;

/// Create a copy of FeedPagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedPaginationCopyWith<_FeedPagination> get copyWith => __$FeedPaginationCopyWithImpl<_FeedPagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedPaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedPagination&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.number, number) || other.number == number)&&(identical(other.first, first) || other.first == first)&&(identical(other.last, last) || other.last == last)&&(identical(other.empty, empty) || other.empty == empty)&&(identical(other.searchId, searchId) || other.searchId == searchId)&&(identical(other.searchVersion, searchVersion) || other.searchVersion == searchVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalElements,totalPages,size,const DeepCollectionEquality().hash(_content),number,first,last,empty,searchId,searchVersion);

@override
String toString() {
  return 'FeedPagination(totalElements: $totalElements, totalPages: $totalPages, size: $size, content: $content, number: $number, first: $first, last: $last, empty: $empty, searchId: $searchId, searchVersion: $searchVersion)';
}


}

/// @nodoc
abstract mixin class _$FeedPaginationCopyWith<$Res> implements $FeedPaginationCopyWith<$Res> {
  factory _$FeedPaginationCopyWith(_FeedPagination value, $Res Function(_FeedPagination) _then) = __$FeedPaginationCopyWithImpl;
@override @useResult
$Res call({
 int totalElements, int totalPages, int size, List<Feed> content, int number, bool first, bool last, bool empty, String? searchId, String? searchVersion
});




}
/// @nodoc
class __$FeedPaginationCopyWithImpl<$Res>
    implements _$FeedPaginationCopyWith<$Res> {
  __$FeedPaginationCopyWithImpl(this._self, this._then);

  final _FeedPagination _self;
  final $Res Function(_FeedPagination) _then;

/// Create a copy of FeedPagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalElements = null,Object? totalPages = null,Object? size = null,Object? content = null,Object? number = null,Object? first = null,Object? last = null,Object? empty = null,Object? searchId = freezed,Object? searchVersion = freezed,}) {
  return _then(_FeedPagination(
totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<Feed>,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool,empty: null == empty ? _self.empty : empty // ignore: cast_nullable_to_non_nullable
as bool,searchId: freezed == searchId ? _self.searchId : searchId // ignore: cast_nullable_to_non_nullable
as String?,searchVersion: freezed == searchVersion ? _self.searchVersion : searchVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
