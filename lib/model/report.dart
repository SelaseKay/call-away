import 'package:call_away/model/report_status.dart';
import 'package:call_away/problem_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  const factory Report(
      {String? userId,
      String? reportId,
      @Default("") String imageUrl,
      required String location,
      required String description,
      required ProblemType problemType,
      @Default([null, null, null, null]) List<ReportStatus?> status}) = _Report;

  factory Report.fromJson(Map<String, Object?> json) => _$ReportFromJson(json);
}
