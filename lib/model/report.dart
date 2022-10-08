import 'package:call_away/model/mediaType.dart';
import 'package:call_away/model/report_label_type.dart';
import 'package:call_away/problem_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  const factory Report({
    String? userId,
    String? reportId,
    @Default("") String imageUrl,
    required String location,
    required MediaType mediaType,
    required String description,
    required ProblemType problemType,
    // @Default([null, null, null, null]) List<ReportStatus?> statuses,
    Map<String, String>? statuses,
    ReportLabelType? currentStatus,
  }) = _Report;


  factory Report.fromJson(Map<String, Object?> json) => _$ReportFromJson(json);
}
