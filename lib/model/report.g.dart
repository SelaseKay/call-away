// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Report _$$_ReportFromJson(Map<String, dynamic> json) => _$_Report(
      reportId: json['reportId'] as String?,
      imageUrl: json['imageUrl'] as String? ?? "",
      location: json['location'] as String,
      description: json['description'] as String,
      problemType: $enumDecode(_$ProblemTypeEnumMap, json['problemType']),
      status: (json['status'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : ReportStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [null, null, null, null],
    );

Map<String, dynamic> _$$_ReportToJson(_$_Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'description': instance.description,
      'problemType': _$ProblemTypeEnumMap[instance.problemType]!,
      'status': instance.status.map((e) => e?.toJson()).toList(),
    };

const _$ProblemTypeEnumMap = {
  ProblemType.waterProblem: 'waterProblem',
  ProblemType.electricityProblem: 'electricityProblem',
  ProblemType.others: 'others',
};
