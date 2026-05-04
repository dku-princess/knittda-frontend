// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MypageEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MypageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MypageEvent()';
}


}

/// @nodoc
class $MypageEventCopyWith<$Res>  {
$MypageEventCopyWith(MypageEvent _, $Res Function(MypageEvent) __);
}


/// Adds pattern-matching-related methods to [MypageEvent].
extension MypageEventPatterns on MypageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Logout value)?  logout,TResult Function( Signout value)?  signout,TResult Function( SettingProfileImage value)?  settingProfileImage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Logout() when logout != null:
return logout(_that);case Signout() when signout != null:
return signout(_that);case SettingProfileImage() when settingProfileImage != null:
return settingProfileImage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Logout value)  logout,required TResult Function( Signout value)  signout,required TResult Function( SettingProfileImage value)  settingProfileImage,}){
final _that = this;
switch (_that) {
case Logout():
return logout(_that);case Signout():
return signout(_that);case SettingProfileImage():
return settingProfileImage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Logout value)?  logout,TResult? Function( Signout value)?  signout,TResult? Function( SettingProfileImage value)?  settingProfileImage,}){
final _that = this;
switch (_that) {
case Logout() when logout != null:
return logout(_that);case Signout() when signout != null:
return signout(_that);case SettingProfileImage() when settingProfileImage != null:
return settingProfileImage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  logout,TResult Function()?  signout,TResult Function( XFile file)?  settingProfileImage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Logout() when logout != null:
return logout();case Signout() when signout != null:
return signout();case SettingProfileImage() when settingProfileImage != null:
return settingProfileImage(_that.file);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  logout,required TResult Function()  signout,required TResult Function( XFile file)  settingProfileImage,}) {final _that = this;
switch (_that) {
case Logout():
return logout();case Signout():
return signout();case SettingProfileImage():
return settingProfileImage(_that.file);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  logout,TResult? Function()?  signout,TResult? Function( XFile file)?  settingProfileImage,}) {final _that = this;
switch (_that) {
case Logout() when logout != null:
return logout();case Signout() when signout != null:
return signout();case SettingProfileImage() when settingProfileImage != null:
return settingProfileImage(_that.file);case _:
  return null;

}
}

}

/// @nodoc


class Logout implements MypageEvent {
  const Logout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Logout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MypageEvent.logout()';
}


}




/// @nodoc


class Signout implements MypageEvent {
  const Signout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Signout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MypageEvent.signout()';
}


}




/// @nodoc


class SettingProfileImage implements MypageEvent {
  const SettingProfileImage(this.file);
  

 final  XFile file;

/// Create a copy of MypageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingProfileImageCopyWith<SettingProfileImage> get copyWith => _$SettingProfileImageCopyWithImpl<SettingProfileImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingProfileImage&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'MypageEvent.settingProfileImage(file: $file)';
}


}

/// @nodoc
abstract mixin class $SettingProfileImageCopyWith<$Res> implements $MypageEventCopyWith<$Res> {
  factory $SettingProfileImageCopyWith(SettingProfileImage value, $Res Function(SettingProfileImage) _then) = _$SettingProfileImageCopyWithImpl;
@useResult
$Res call({
 XFile file
});




}
/// @nodoc
class _$SettingProfileImageCopyWithImpl<$Res>
    implements $SettingProfileImageCopyWith<$Res> {
  _$SettingProfileImageCopyWithImpl(this._self, this._then);

  final SettingProfileImage _self;
  final $Res Function(SettingProfileImage) _then;

/// Create a copy of MypageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(SettingProfileImage(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as XFile,
  ));
}


}

// dart format on
