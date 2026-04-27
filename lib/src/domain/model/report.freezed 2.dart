// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Report {

 double get knittingLevel; int get weeklyKnittingCount; int get weeklyKnittingPhotoCount; int get weeklyProgress; List<String>? get topTags; List<Hashtag>? get weeklyHashtags;
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCopyWith<Report> get copyWith => _$ReportCopyWithImpl<Report>(this as Report, _$identity);

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Report&&(identical(other.knittingLevel, knittingLevel) || other.knittingLevel == knittingLevel)&&(identical(other.weeklyKnittingCount, weeklyKnittingCount) || other.weeklyKnittingCount == weeklyKnittingCount)&&(identical(other.weeklyKnittingPhotoCount, weeklyKnittingPhotoCount) || other.weeklyKnittingPhotoCount == weeklyKnittingPhotoCount)&&(identical(other.weeklyProgress, weeklyProgress) || other.weeklyProgress == weeklyProgress)&&const DeepCollectionEquality().equals(other.topTags, topTags)&&const DeepCollectionEquality().equals(other.weeklyHashtags, weeklyHashtags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,knittingLevel,weeklyKnittingCount,weeklyKnittingPhotoCount,weeklyProgress,const DeepCollectionEquality().hash(topTags),const DeepCollectionEquality().hash(weeklyHashtags));

@override
String toString() {
  return 'Report(knittingLevel: $knittingLevel, weeklyKnittingCount: $weeklyKnittingCount, weeklyKnittingPhotoCount: $weeklyKnittingPhotoCount, weeklyProgress: $weeklyProgress, topTags: $topTags, weeklyHashtags: $weeklyHashtags)';
}


}

/// @nodoc
abstract mixin class $ReportCopyWith<$Res>  {
  factory $ReportCopyWith(Report value, $Res Function(Report) _then) = _$ReportCopyWithImpl;
@useResult
$Res call({
 double knittingLevel, int weeklyKnittingCount, int weeklyKnittingPhotoCount, int weeklyProgress, List<String>? topTags, List<Hashtag>? weeklyHashtags
});




}
/// @nodoc
class _$ReportCopyWithImpl<$Res>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._self, this._then);

  final Report _self;
  final $Res Function(Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? knittingLevel = null,Object? weeklyKnittingCount = null,Object? weeklyKnittingPhotoCount = null,Object? weeklyProgress = null,Object? topTags = freezed,Object? weeklyHashtags = freezed,}) {
  return _then(_self.copyWith(
knittingLevel: null == knittingLevel ? _self.knittingLevel : knittingLevel // ignore: cast_nullable_to_non_nullable
as double,weeklyKnittingCount: null == weeklyKnittingCount ? _self.weeklyKnittingCount : weeklyKnittingCount // ignore: cast_nullable_to_non_nullable
as int,weeklyKnittingPhotoCount: null == weeklyKnittingPhotoCount ? _self.weeklyKnittingPhotoCount : weeklyKnittingPhotoCount // ignore: cast_nullable_to_non_nullable
as int,weeklyProgress: null == weeklyProgress ? _self.weeklyProgress : weeklyProgress // ignore: cast_nullable_to_non_nullable
as int,topTags: freezed == topTags ? _self.topTags : topTags // ignore: cast_nullable_to_non_nullable
as List<String>?,weeklyHashtags: freezed == weeklyHashtags ? _self.weeklyHashtags : weeklyHashtags // ignore: cast_nullable_to_non_nullable
as List<Hashtag>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Report].
extension ReportPatterns on Report {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Report value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Report() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Report value)  $default,){
final _that = this;
switch (_that) {
case _Report():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Report value)?  $default,){
final _that = this;
switch (_that) {
case _Report() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double knittingLevel,  int weeklyKnittingCount,  int weeklyKnittingPhotoCount,  int weeklyProgress,  List<String>? topTags,  List<Hashtag>? weeklyHashtags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.knittingLevel,_that.weeklyKnittingCount,_that.weeklyKnittingPhotoCount,_that.weeklyProgress,_that.topTags,_that.weeklyHashtags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double knittingLevel,  int weeklyKnittingCount,  int weeklyKnittingPhotoCount,  int weeklyProgress,  List<String>? topTags,  List<Hashtag>? weeklyHashtags)  $default,) {final _that = this;
switch (_that) {
case _Report():
return $default(_that.knittingLevel,_that.weeklyKnittingCount,_that.weeklyKnittingPhotoCount,_that.weeklyProgress,_that.topTags,_that.weeklyHashtags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double knittingLevel,  int weeklyKnittingCount,  int weeklyKnittingPhotoCount,  int weeklyProgress,  List<String>? topTags,  List<Hashtag>? weeklyHashtags)?  $default,) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.knittingLevel,_that.weeklyKnittingCount,_that.weeklyKnittingPhotoCount,_that.weeklyProgress,_that.topTags,_that.weeklyHashtags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Report implements Report {
   _Report({required this.knittingLevel, required this.weeklyKnittingCount, required this.weeklyKnittingPhotoCount, required this.weeklyProgress, required final  List<String>? topTags, required final  List<Hashtag>? weeklyHashtags}): _topTags = topTags,_weeklyHashtags = weeklyHashtags;
  factory _Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

@override final  double knittingLevel;
@override final  int weeklyKnittingCount;
@override final  int weeklyKnittingPhotoCount;
@override final  int weeklyProgress;
 final  List<String>? _topTags;
@override List<String>? get topTags {
  final value = _topTags;
  if (value == null) return null;
  if (_topTags is EqualUnmodifiableListView) return _topTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Hashtag>? _weeklyHashtags;
@override List<Hashtag>? get weeklyHashtags {
  final value = _weeklyHashtags;
  if (value == null) return null;
  if (_weeklyHashtags is EqualUnmodifiableListView) return _weeklyHashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCopyWith<_Report> get copyWith => __$ReportCopyWithImpl<_Report>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Report&&(identical(other.knittingLevel, knittingLevel) || other.knittingLevel == knittingLevel)&&(identical(other.weeklyKnittingCount, weeklyKnittingCount) || other.weeklyKnittingCount == weeklyKnittingCount)&&(identical(other.weeklyKnittingPhotoCount, weeklyKnittingPhotoCount) || other.weeklyKnittingPhotoCount == weeklyKnittingPhotoCount)&&(identical(other.weeklyProgress, weeklyProgress) || other.weeklyProgress == weeklyProgress)&&const DeepCollectionEquality().equals(other._topTags, _topTags)&&const DeepCollectionEquality().equals(other._weeklyHashtags, _weeklyHashtags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,knittingLevel,weeklyKnittingCount,weeklyKnittingPhotoCount,weeklyProgress,const DeepCollectionEquality().hash(_topTags),const DeepCollectionEquality().hash(_weeklyHashtags));

@override
String toString() {
  return 'Report(knittingLevel: $knittingLevel, weeklyKnittingCount: $weeklyKnittingCount, weeklyKnittingPhotoCount: $weeklyKnittingPhotoCount, weeklyProgress: $weeklyProgress, topTags: $topTags, weeklyHashtags: $weeklyHashtags)';
}


}

/// @nodoc
abstract mixin class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) _then) = __$ReportCopyWithImpl;
@override @useResult
$Res call({
 double knittingLevel, int weeklyKnittingCount, int weeklyKnittingPhotoCount, int weeklyProgress, List<String>? topTags, List<Hashtag>? weeklyHashtags
});




}
/// @nodoc
class __$ReportCopyWithImpl<$Res>
    implements _$ReportCopyWith<$Res> {
  __$ReportCopyWithImpl(this._self, this._then);

  final _Report _self;
  final $Res Function(_Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? knittingLevel = null,Object? weeklyKnittingCount = null,Object? weeklyKnittingPhotoCount = null,Object? weeklyProgress = null,Object? topTags = freezed,Object? weeklyHashtags = freezed,}) {
  return _then(_Report(
knittingLevel: null == knittingLevel ? _self.knittingLevel : knittingLevel // ignore: cast_nullable_to_non_nullable
as double,weeklyKnittingCount: null == weeklyKnittingCount ? _self.weeklyKnittingCount : weeklyKnittingCount // ignore: cast_nullable_to_non_nullable
as int,weeklyKnittingPhotoCount: null == weeklyKnittingPhotoCount ? _self.weeklyKnittingPhotoCount : weeklyKnittingPhotoCount // ignore: cast_nullable_to_non_nullable
as int,weeklyProgress: null == weeklyProgress ? _self.weeklyProgress : weeklyProgress // ignore: cast_nullable_to_non_nullable
as int,topTags: freezed == topTags ? _self._topTags : topTags // ignore: cast_nullable_to_non_nullable
as List<String>?,weeklyHashtags: freezed == weeklyHashtags ? _self._weeklyHashtags : weeklyHashtags // ignore: cast_nullable_to_non_nullable
as List<Hashtag>?,
  ));
}


}

// dart format on
