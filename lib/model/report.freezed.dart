// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
mixin _$Report {
  String? get userId => throw _privateConstructorUsedError;
  String? get reportId => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ProblemType get problemType =>
      throw _privateConstructorUsedError; // @Default([null, null, null, null]) List<ReportStatus?> statuses,
  Map<String, String>? get statuses => throw _privateConstructorUsedError;
  ReportLabelType? get currentStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? reportId,
      String audioUrl,
      String imageUrl,
      String location,
      MediaType mediaType,
      String description,
      ProblemType problemType,
      Map<String, String>? statuses,
      ReportLabelType? currentStatus});
}

/// @nodoc
class _$ReportCopyWithImpl<$Res> implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  final Report _value;
  // ignore: unused_field
  final $Res Function(Report) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? reportId = freezed,
    Object? audioUrl = freezed,
    Object? imageUrl = freezed,
    Object? location = freezed,
    Object? mediaType = freezed,
    Object? description = freezed,
    Object? problemType = freezed,
    Object? statuses = freezed,
    Object? currentStatus = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      reportId: reportId == freezed
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: audioUrl == freezed
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: mediaType == freezed
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      problemType: problemType == freezed
          ? _value.problemType
          : problemType // ignore: cast_nullable_to_non_nullable
              as ProblemType,
      statuses: statuses == freezed
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      currentStatus: currentStatus == freezed
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as ReportLabelType?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$$_ReportCopyWith(_$_Report value, $Res Function(_$_Report) then) =
      __$$_ReportCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? reportId,
      String audioUrl,
      String imageUrl,
      String location,
      MediaType mediaType,
      String description,
      ProblemType problemType,
      Map<String, String>? statuses,
      ReportLabelType? currentStatus});
}

/// @nodoc
class __$$_ReportCopyWithImpl<$Res> extends _$ReportCopyWithImpl<$Res>
    implements _$$_ReportCopyWith<$Res> {
  __$$_ReportCopyWithImpl(_$_Report _value, $Res Function(_$_Report) _then)
      : super(_value, (v) => _then(v as _$_Report));

  @override
  _$_Report get _value => super._value as _$_Report;

  @override
  $Res call({
    Object? userId = freezed,
    Object? reportId = freezed,
    Object? audioUrl = freezed,
    Object? imageUrl = freezed,
    Object? location = freezed,
    Object? mediaType = freezed,
    Object? description = freezed,
    Object? problemType = freezed,
    Object? statuses = freezed,
    Object? currentStatus = freezed,
  }) {
    return _then(_$_Report(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      reportId: reportId == freezed
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: audioUrl == freezed
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: mediaType == freezed
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      problemType: problemType == freezed
          ? _value.problemType
          : problemType // ignore: cast_nullable_to_non_nullable
              as ProblemType,
      statuses: statuses == freezed
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      currentStatus: currentStatus == freezed
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as ReportLabelType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Report implements _Report {
  const _$_Report(
      {this.userId,
      this.reportId,
      this.audioUrl = "",
      this.imageUrl = "",
      required this.location,
      required this.mediaType,
      required this.description,
      required this.problemType,
      final Map<String, String>? statuses,
      this.currentStatus})
      : _statuses = statuses;

  factory _$_Report.fromJson(Map<String, dynamic> json) =>
      _$$_ReportFromJson(json);

  @override
  final String? userId;
  @override
  final String? reportId;
  @override
  @JsonKey()
  final String audioUrl;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  final String location;
  @override
  final MediaType mediaType;
  @override
  final String description;
  @override
  final ProblemType problemType;
// @Default([null, null, null, null]) List<ReportStatus?> statuses,
  final Map<String, String>? _statuses;
// @Default([null, null, null, null]) List<ReportStatus?> statuses,
  @override
  Map<String, String>? get statuses {
    final value = _statuses;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final ReportLabelType? currentStatus;

  @override
  String toString() {
    return 'Report(userId: $userId, reportId: $reportId, imageUrl: $imageUrl, location: $location, mediaType: $mediaType, description: $description, problemType: $problemType, statuses: $statuses, currentStatus: $currentStatus)';

  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Report &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.reportId, reportId) &&
            const DeepCollectionEquality().equals(other.audioUrl, audioUrl) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.mediaType, mediaType) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.problemType, problemType) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses) &&
            const DeepCollectionEquality()
                .equals(other.currentStatus, currentStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(reportId),
      const DeepCollectionEquality().hash(audioUrl),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(mediaType),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(problemType),
      const DeepCollectionEquality().hash(_statuses),
      const DeepCollectionEquality().hash(currentStatus));

  @JsonKey(ignore: true)
  @override
  _$$_ReportCopyWith<_$_Report> get copyWith =>
      __$$_ReportCopyWithImpl<_$_Report>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReportToJson(
      this,
    );
  }
}

abstract class _Report implements Report {
  const factory _Report(
      {final String? userId,
      final String? reportId,
      final String audioUrl,
      final String imageUrl,
      required final String location,
      required final MediaType mediaType,
      required final String description,
      required final ProblemType problemType,
      final Map<String, String>? statuses,
      final ReportLabelType? currentStatus}) = _$_Report;

  factory _Report.fromJson(Map<String, dynamic> json) = _$_Report.fromJson;

  @override
  String? get userId;
  @override
  String? get reportId;
  @override
  String get audioUrl;
  @override
  String get imageUrl;
  @override
  String get location;
  @override
  MediaType get mediaType;
  @override
  String get description;
  @override
  ProblemType get problemType;
  @override // @Default([null, null, null, null]) List<ReportStatus?> statuses,
  Map<String, String>? get statuses;
  @override
  ReportLabelType? get currentStatus;
  @override
  @JsonKey(ignore: true)
  _$$_ReportCopyWith<_$_Report> get copyWith =>
      throw _privateConstructorUsedError;
}
