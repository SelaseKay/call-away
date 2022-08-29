import 'package:call_away/model/report_label_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'report_status.freezed.dart';

part 'report_status.g.dart';

@freezed
class ReportStatus with _$ReportStatus {
  const factory ReportStatus({
    @Default("") String time,
    ReportLabelType? status,
  }) = _ReportStatus;

  factory ReportStatus.fromJson(Map<String, Object?> json) =>
      _$ReportStatusFromJson(json);
}
