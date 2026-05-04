// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Feed {

 String? get userName; String? get profileImageUrl; String get projectName; String? get designTitle; String? get designer; int get projectId; Records get record;
/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCopyWith<Feed> get copyWith => _$FeedCopyWithImpl<Feed>(this as Feed, _$identity);

  /// Serializes this Feed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Feed&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.designTitle, designTitle) || other.designTitle == designTitle)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,profileImageUrl,projectName,designTitle,designer,projectId,record);

@override
String toString() {
  return 'Feed(userName: $userName, profileImageUrl: $profileImageUrl, projectName: $projectName, designTitle: $designTitle, designer: $designer, projectId: $projectId, record: $record)';
}


}

/// @nodoc
abstract mixin class $FeedCopyWith<$Res>  {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) _then) = _$FeedCopyWithImpl;
@useResult
$Res call({
 String? userName, String? profileImageUrl, String projectName, String? designTitle, String? designer, int projectId, Records record
});


$RecordsCopyWith<$Res> get record;

}
/// @nodoc
class _$FeedCopyWithImpl<$Res>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._self, this._then);

  final Feed _self;
  final $Res Function(Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = freezed,Object? profileImageUrl = freezed,Object? projectName = null,Object? designTitle = freezed,Object? designer = freezed,Object? projectId = null,Object? record = null,}) {
  return _then(_self.copyWith(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,designTitle: freezed == designTitle ? _self.designTitle : designTitle // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records,
  ));
}
/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordsCopyWith<$Res> get record {
  
  return $RecordsCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [Feed].
extension FeedPatterns on Feed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Feed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Feed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Feed value)  $default,){
final _that = this;
switch (_that) {
case _Feed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Feed value)?  $default,){
final _that = this;
switch (_that) {
case _Feed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userName,  String? profileImageUrl,  String projectName,  String? designTitle,  String? designer,  int projectId,  Records record)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Feed() when $default != null:
return $default(_that.userName,_that.profileImageUrl,_that.projectName,_that.designTitle,_that.designer,_that.projectId,_that.record);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userName,  String? profileImageUrl,  String projectName,  String? designTitle,  String? designer,  int projectId,  Records record)  $default,) {final _that = this;
switch (_that) {
case _Feed():
return $default(_that.userName,_that.profileImageUrl,_that.projectName,_that.designTitle,_that.designer,_that.projectId,_that.record);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userName,  String? profileImageUrl,  String projectName,  String? designTitle,  String? designer,  int projectId,  Records record)?  $default,) {final _that = this;
switch (_that) {
case _Feed() when $default != null:
return $default(_that.userName,_that.profileImageUrl,_that.projectName,_that.designTitle,_that.designer,_that.projectId,_that.record);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Feed implements Feed {
   _Feed({this.userName, this.profileImageUrl, required this.projectName, this.designTitle, this.designer, required this.projectId, required this.record});
  factory _Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

@override final  String? userName;
@override final  String? profileImageUrl;
@override final  String projectName;
@override final  String? designTitle;
@override final  String? designer;
@override final  int projectId;
@override final  Records record;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCopyWith<_Feed> get copyWith => __$FeedCopyWithImpl<_Feed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Feed&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.designTitle, designTitle) || other.designTitle == designTitle)&&(identical(other.designer, designer) || other.designer == designer)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.record, record) || other.record == record));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,profileImageUrl,projectName,designTitle,designer,projectId,record);

@override
String toString() {
  return 'Feed(userName: $userName, profileImageUrl: $profileImageUrl, projectName: $projectName, designTitle: $designTitle, designer: $designer, projectId: $projectId, record: $record)';
}


}

/// @nodoc
abstract mixin class _$FeedCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$FeedCopyWith(_Feed value, $Res Function(_Feed) _then) = __$FeedCopyWithImpl;
@override @useResult
$Res call({
 String? userName, String? profileImageUrl, String projectName, String? designTitle, String? designer, int projectId, Records record
});


@override $RecordsCopyWith<$Res> get record;

}
/// @nodoc
class __$FeedCopyWithImpl<$Res>
    implements _$FeedCopyWith<$Res> {
  __$FeedCopyWithImpl(this._self, this._then);

  final _Feed _self;
  final $Res Function(_Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = freezed,Object? profileImageUrl = freezed,Object? projectName = null,Object? designTitle = freezed,Object? designer = freezed,Object? projectId = null,Object? record = null,}) {
  return _then(_Feed(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,designTitle: freezed == designTitle ? _self.designTitle : designTitle // ignore: cast_nullable_to_non_nullable
as String?,designer: freezed == designer ? _self.designer : designer // ignore: cast_nullable_to_non_nullable
as String?,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as Records,
  ));
}

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecordsCopyWith<$Res> get record {
  
  return $RecordsCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
