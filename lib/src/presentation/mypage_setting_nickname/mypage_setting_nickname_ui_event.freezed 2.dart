// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mypage_setting_nickname_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MypageSettingNicknameUiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MypageSettingNicknameUiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MypageSettingNicknameUiEvent()';
}


}

/// @nodoc
class $MypageSettingNicknameUiEventCopyWith<$Res>  {
$MypageSettingNicknameUiEventCopyWith(MypageSettingNicknameUiEvent _, $Res Function(MypageSettingNicknameUiEvent) __);
}


/// Adds pattern-matching-related methods to [MypageSettingNicknameUiEvent].
extension MypageSettingNicknameUiEventPatterns on MypageSettingNicknameUiEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShowSnackBar value)?  showSnackBar,TResult Function( SetNickname value)?  setNickname,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case SetNickname() when setNickname != null:
return setNickname(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShowSnackBar value)  showSnackBar,required TResult Function( SetNickname value)  setNickname,}){
final _that = this;
switch (_that) {
case ShowSnackBar():
return showSnackBar(_that);case SetNickname():
return setNickname(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShowSnackBar value)?  showSnackBar,TResult? Function( SetNickname value)?  setNickname,}){
final _that = this;
switch (_that) {
case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case SetNickname() when setNickname != null:
return setNickname(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  showSnackBar,TResult Function()?  setNickname,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case SetNickname() when setNickname != null:
return setNickname();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  showSnackBar,required TResult Function()  setNickname,}) {final _that = this;
switch (_that) {
case ShowSnackBar():
return showSnackBar(_that.message);case SetNickname():
return setNickname();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  showSnackBar,TResult? Function()?  setNickname,}) {final _that = this;
switch (_that) {
case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case SetNickname() when setNickname != null:
return setNickname();case _:
  return null;

}
}

}

/// @nodoc


class ShowSnackBar implements MypageSettingNicknameUiEvent {
  const ShowSnackBar(this.message);
  

 final  String message;

/// Create a copy of MypageSettingNicknameUiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowSnackBarCopyWith<ShowSnackBar> get copyWith => _$ShowSnackBarCopyWithImpl<ShowSnackBar>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowSnackBar&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MypageSettingNicknameUiEvent.showSnackBar(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowSnackBarCopyWith<$Res> implements $MypageSettingNicknameUiEventCopyWith<$Res> {
  factory $ShowSnackBarCopyWith(ShowSnackBar value, $Res Function(ShowSnackBar) _then) = _$ShowSnackBarCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ShowSnackBarCopyWithImpl<$Res>
    implements $ShowSnackBarCopyWith<$Res> {
  _$ShowSnackBarCopyWithImpl(this._self, this._then);

  final ShowSnackBar _self;
  final $Res Function(ShowSnackBar) _then;

/// Create a copy of MypageSettingNicknameUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShowSnackBar(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SetNickname implements MypageSettingNicknameUiEvent {
  const SetNickname();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetNickname);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MypageSettingNicknameUiEvent.setNickname()';
}


}




// dart format on
