// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_details_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectDetailsUiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDetailsUiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailsUiEvent()';
}


}

/// @nodoc
class $ProjectDetailsUiEventCopyWith<$Res>  {
$ProjectDetailsUiEventCopyWith(ProjectDetailsUiEvent _, $Res Function(ProjectDetailsUiEvent) __);
}


/// Adds pattern-matching-related methods to [ProjectDetailsUiEvent].
extension ProjectDetailsUiEventPatterns on ProjectDetailsUiEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DeletedProject value)?  deletedProject,TResult Function( ShowSnackBar value)?  showSnackBar,TResult Function( NotFound value)?  notFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DeletedProject() when deletedProject != null:
return deletedProject(_that);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case NotFound() when notFound != null:
return notFound(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DeletedProject value)  deletedProject,required TResult Function( ShowSnackBar value)  showSnackBar,required TResult Function( NotFound value)  notFound,}){
final _that = this;
switch (_that) {
case DeletedProject():
return deletedProject(_that);case ShowSnackBar():
return showSnackBar(_that);case NotFound():
return notFound(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DeletedProject value)?  deletedProject,TResult? Function( ShowSnackBar value)?  showSnackBar,TResult? Function( NotFound value)?  notFound,}){
final _that = this;
switch (_that) {
case DeletedProject() when deletedProject != null:
return deletedProject(_that);case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that);case NotFound() when notFound != null:
return notFound(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  deletedProject,TResult Function( String message)?  showSnackBar,TResult Function()?  notFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DeletedProject() when deletedProject != null:
return deletedProject();case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case NotFound() when notFound != null:
return notFound();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  deletedProject,required TResult Function( String message)  showSnackBar,required TResult Function()  notFound,}) {final _that = this;
switch (_that) {
case DeletedProject():
return deletedProject();case ShowSnackBar():
return showSnackBar(_that.message);case NotFound():
return notFound();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  deletedProject,TResult? Function( String message)?  showSnackBar,TResult? Function()?  notFound,}) {final _that = this;
switch (_that) {
case DeletedProject() when deletedProject != null:
return deletedProject();case ShowSnackBar() when showSnackBar != null:
return showSnackBar(_that.message);case NotFound() when notFound != null:
return notFound();case _:
  return null;

}
}

}

/// @nodoc


class DeletedProject implements ProjectDetailsUiEvent {
  const DeletedProject();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeletedProject);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailsUiEvent.deletedProject()';
}


}




/// @nodoc


class ShowSnackBar implements ProjectDetailsUiEvent {
  const ShowSnackBar(this.message);
  

 final  String message;

/// Create a copy of ProjectDetailsUiEvent
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
  return 'ProjectDetailsUiEvent.showSnackBar(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShowSnackBarCopyWith<$Res> implements $ProjectDetailsUiEventCopyWith<$Res> {
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

/// Create a copy of ProjectDetailsUiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShowSnackBar(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotFound implements ProjectDetailsUiEvent {
  const NotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailsUiEvent.notFound()';
}


}




// dart format on
