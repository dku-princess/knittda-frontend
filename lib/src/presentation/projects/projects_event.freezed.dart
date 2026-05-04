// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectsEvent()';
}


}

/// @nodoc
class $ProjectsEventCopyWith<$Res>  {
$ProjectsEventCopyWith(ProjectsEvent _, $Res Function(ProjectsEvent) __);
}


/// Adds pattern-matching-related methods to [ProjectsEvent].
extension ProjectsEventPatterns on ProjectsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProjects value)?  loadProjects,TResult Function( ChangeOrder value)?  changeOrder,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProjects() when loadProjects != null:
return loadProjects(_that);case ChangeOrder() when changeOrder != null:
return changeOrder(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProjects value)  loadProjects,required TResult Function( ChangeOrder value)  changeOrder,}){
final _that = this;
switch (_that) {
case LoadProjects():
return loadProjects(_that);case ChangeOrder():
return changeOrder(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProjects value)?  loadProjects,TResult? Function( ChangeOrder value)?  changeOrder,}){
final _that = this;
switch (_that) {
case LoadProjects() when loadProjects != null:
return loadProjects(_that);case ChangeOrder() when changeOrder != null:
return changeOrder(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadProjects,TResult Function( ProjectOrder projectOrder)?  changeOrder,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProjects() when loadProjects != null:
return loadProjects();case ChangeOrder() when changeOrder != null:
return changeOrder(_that.projectOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadProjects,required TResult Function( ProjectOrder projectOrder)  changeOrder,}) {final _that = this;
switch (_that) {
case LoadProjects():
return loadProjects();case ChangeOrder():
return changeOrder(_that.projectOrder);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadProjects,TResult? Function( ProjectOrder projectOrder)?  changeOrder,}) {final _that = this;
switch (_that) {
case LoadProjects() when loadProjects != null:
return loadProjects();case ChangeOrder() when changeOrder != null:
return changeOrder(_that.projectOrder);case _:
  return null;

}
}

}

/// @nodoc


class LoadProjects implements ProjectsEvent {
  const LoadProjects();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProjects);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectsEvent.loadProjects()';
}


}




/// @nodoc


class ChangeOrder implements ProjectsEvent {
  const ChangeOrder(this.projectOrder);
  

 final  ProjectOrder projectOrder;

/// Create a copy of ProjectsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeOrderCopyWith<ChangeOrder> get copyWith => _$ChangeOrderCopyWithImpl<ChangeOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeOrder&&(identical(other.projectOrder, projectOrder) || other.projectOrder == projectOrder));
}


@override
int get hashCode => Object.hash(runtimeType,projectOrder);

@override
String toString() {
  return 'ProjectsEvent.changeOrder(projectOrder: $projectOrder)';
}


}

/// @nodoc
abstract mixin class $ChangeOrderCopyWith<$Res> implements $ProjectsEventCopyWith<$Res> {
  factory $ChangeOrderCopyWith(ChangeOrder value, $Res Function(ChangeOrder) _then) = _$ChangeOrderCopyWithImpl;
@useResult
$Res call({
 ProjectOrder projectOrder
});


$ProjectOrderCopyWith<$Res> get projectOrder;

}
/// @nodoc
class _$ChangeOrderCopyWithImpl<$Res>
    implements $ChangeOrderCopyWith<$Res> {
  _$ChangeOrderCopyWithImpl(this._self, this._then);

  final ChangeOrder _self;
  final $Res Function(ChangeOrder) _then;

/// Create a copy of ProjectsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? projectOrder = null,}) {
  return _then(ChangeOrder(
null == projectOrder ? _self.projectOrder : projectOrder // ignore: cast_nullable_to_non_nullable
as ProjectOrder,
  ));
}

/// Create a copy of ProjectsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectOrderCopyWith<$Res> get projectOrder {
  
  return $ProjectOrderCopyWith<$Res>(_self.projectOrder, (value) {
    return _then(_self.copyWith(projectOrder: value));
  });
}
}

// dart format on
