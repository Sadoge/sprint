// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryState {

 Map<DateTime, int> get heatmapData; int get streak; int get todayCount; int get totalSprints; int get activeDays;
/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryStateCopyWith<HistoryState> get copyWith => _$HistoryStateCopyWithImpl<HistoryState>(this as HistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState&&const DeepCollectionEquality().equals(other.heatmapData, heatmapData)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.totalSprints, totalSprints) || other.totalSprints == totalSprints)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(heatmapData),streak,todayCount,totalSprints,activeDays);

@override
String toString() {
  return 'HistoryState(heatmapData: $heatmapData, streak: $streak, todayCount: $todayCount, totalSprints: $totalSprints, activeDays: $activeDays)';
}


}

/// @nodoc
abstract mixin class $HistoryStateCopyWith<$Res>  {
  factory $HistoryStateCopyWith(HistoryState value, $Res Function(HistoryState) _then) = _$HistoryStateCopyWithImpl;
@useResult
$Res call({
 Map<DateTime, int> heatmapData, int streak, int todayCount, int totalSprints, int activeDays
});




}
/// @nodoc
class _$HistoryStateCopyWithImpl<$Res>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._self, this._then);

  final HistoryState _self;
  final $Res Function(HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heatmapData = null,Object? streak = null,Object? todayCount = null,Object? totalSprints = null,Object? activeDays = null,}) {
  return _then(_self.copyWith(
heatmapData: null == heatmapData ? _self.heatmapData : heatmapData // ignore: cast_nullable_to_non_nullable
as Map<DateTime, int>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,totalSprints: null == totalSprints ? _self.totalSprints : totalSprints // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryState value)  $default,){
final _that = this;
switch (_that) {
case _HistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<DateTime, int> heatmapData,  int streak,  int todayCount,  int totalSprints,  int activeDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.heatmapData,_that.streak,_that.todayCount,_that.totalSprints,_that.activeDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<DateTime, int> heatmapData,  int streak,  int todayCount,  int totalSprints,  int activeDays)  $default,) {final _that = this;
switch (_that) {
case _HistoryState():
return $default(_that.heatmapData,_that.streak,_that.todayCount,_that.totalSprints,_that.activeDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<DateTime, int> heatmapData,  int streak,  int todayCount,  int totalSprints,  int activeDays)?  $default,) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.heatmapData,_that.streak,_that.todayCount,_that.totalSprints,_that.activeDays);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryState implements HistoryState {
  const _HistoryState({required final  Map<DateTime, int> heatmapData, required this.streak, required this.todayCount, required this.totalSprints, required this.activeDays}): _heatmapData = heatmapData;
  

 final  Map<DateTime, int> _heatmapData;
@override Map<DateTime, int> get heatmapData {
  if (_heatmapData is EqualUnmodifiableMapView) return _heatmapData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_heatmapData);
}

@override final  int streak;
@override final  int todayCount;
@override final  int totalSprints;
@override final  int activeDays;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryStateCopyWith<_HistoryState> get copyWith => __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryState&&const DeepCollectionEquality().equals(other._heatmapData, _heatmapData)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.totalSprints, totalSprints) || other.totalSprints == totalSprints)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_heatmapData),streak,todayCount,totalSprints,activeDays);

@override
String toString() {
  return 'HistoryState(heatmapData: $heatmapData, streak: $streak, todayCount: $todayCount, totalSprints: $totalSprints, activeDays: $activeDays)';
}


}

/// @nodoc
abstract mixin class _$HistoryStateCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(_HistoryState value, $Res Function(_HistoryState) _then) = __$HistoryStateCopyWithImpl;
@override @useResult
$Res call({
 Map<DateTime, int> heatmapData, int streak, int todayCount, int totalSprints, int activeDays
});




}
/// @nodoc
class __$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(this._self, this._then);

  final _HistoryState _self;
  final $Res Function(_HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heatmapData = null,Object? streak = null,Object? todayCount = null,Object? totalSprints = null,Object? activeDays = null,}) {
  return _then(_HistoryState(
heatmapData: null == heatmapData ? _self._heatmapData : heatmapData // ignore: cast_nullable_to_non_nullable
as Map<DateTime, int>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,totalSprints: null == totalSprints ? _self.totalSprints : totalSprints // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
