// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'report_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReportStatus _$ReportStatusFromJson(Map<String, dynamic> json) {
  return _ReportStatus.fromJson(json);
}

/// @nodoc
mixin _$ReportStatus {
  String get time => throw _privateConstructorUsedError;
  ReportLabelType? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportStatusCopyWith<ReportStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportStatusCopyWith<$Res> {
  factory $ReportStatusCopyWith(
          ReportStatus value, $Res Function(ReportStatus) then) =
      _$ReportStatusCopyWithImpl<$Res>;
  $Res call({String time, ReportLabelType? status});
}

/// @nodoc
class _$ReportStatusCopyWithImpl<$Res> implements $ReportStatusCopyWith<$Res> {
  _$ReportStatusCopyWithImpl(this._value, this._then);

  final ReportStatus _value;
  // ignore: unused_field
  final $Res Function(ReportStatus) _then;

  @override
  $Res call({
    Object? time = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportLabelType?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReportStatusCopyWith<$Res>
    implements $ReportStatusCopyWith<$Res> {
  factory _$$_ReportStatusCopyWith(
          _$_ReportStatus value, $Res Function(_$_ReportStatus) then) =
      __$$_ReportStatusCopyWithImpl<$Res>;
  @override
  $Res call({String time, ReportLabelType? status});
}

/// @nodoc
class __$$_ReportStatusCopyWithImpl<$Res>
    extends _$ReportStatusCopyWithImpl<$Res>
    implements _$$_ReportStatusCopyWith<$Res> {
  __$$_ReportStatusCopyWithImpl(
      _$_ReportStatus _value, $Res Function(_$_ReportStatus) _then)
      : super(_value, (v) => _then(v as _$_ReportStatus));

  @override
  _$_ReportStatus get _value => super._value as _$_ReportStatus;

  @override
  $Res call({
    Object? time = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_ReportStatus(
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReportLabelType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReportStatus implements _ReportStatus {
  const _$_ReportStatus({this.time = "", this.status});

  factory _$_ReportStatus.fromJson(Map<String, dynamic> json) =>
      _$$_ReportStatusFromJson(json);

  @override
  @JsonKey()
  final String time;
  @override
  final ReportLabelType? status;

  @override
  String toString() {
    return 'ReportStatus(time: $time, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReportStatus &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_ReportStatusCopyWith<_$_ReportStatus> get copyWith =>
      __$$_ReportStatusCopyWithImpl<_$_ReportStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReportStatusToJson(
      this,
    );
  }
}

abstract class _ReportStatus implements ReportStatus {
  const factory _ReportStatus(
      {final String time, final ReportLabelType? status}) = _$_ReportStatus;

  factory _ReportStatus.fromJson(Map<String, dynamic> json) =
      _$_ReportStatus.fromJson;

  @override
  String get time;
  @override
  ReportLabelType? get status;
  @override
  @JsonKey(ignore: true)
  _$$_ReportStatusCopyWith<_$_ReportStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
