// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Report _$$_ReportFromJson(Map<String, dynamic> json) => _$_Report(
      userId: json['userId'] as String?,
      reportId: json['reportId'] as String?,
      audioUrl: json['audioUrl'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      location: json['location'] as String,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      description: json['description'] as String,
      problemType: $enumDecode(_$ProblemTypeEnumMap, json['problemType']),
      statuses: (json['statuses'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      currentStatus:
          $enumDecodeNullable(_$ReportLabelTypeEnumMap, json['currentStatus']),
    );

Map<String, dynamic> _$$_ReportToJson(_$_Report instance) => <String, dynamic>{
      'userId': instance.userId,
      'reportId': instance.reportId,
      'audioUrl': instance.audioUrl,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'description': instance.description,
      'problemType': _$ProblemTypeEnumMap[instance.problemType]!,
      'statuses': instance.statuses,
      'currentStatus': _$ReportLabelTypeEnumMap[instance.currentStatus],
    };

const _$MediaTypeEnumMap = {
  MediaType.VIDEO: 'video',
  MediaType.IMAGE: 'image',
};

const _$ProblemTypeEnumMap = {
  ProblemType.waterProblem: 'waterProblem',
  ProblemType.electricityProblem: 'electricityProblem',
  ProblemType.others: 'others',
};

const _$ReportLabelTypeEnumMap = {
  ReportLabelType.delivered: 'delivered',
  ReportLabelType.pending: 'pending',
  ReportLabelType.resolved: 'resolved',
};
