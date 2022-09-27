// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportStatus _$$_ReportStatusFromJson(Map<String, dynamic> json) =>
    _$_ReportStatus(
      time: json['time'] as String? ?? "N/A",
      label: $enumDecodeNullable(_$ReportLabelTypeEnumMap, json['label']),
    );

Map<String, dynamic> _$$_ReportStatusToJson(_$_ReportStatus instance) =>
    <String, dynamic>{
      'time': instance.time,
      'label': _$ReportLabelTypeEnumMap[instance.label],
    };

const _$ReportLabelTypeEnumMap = {
  ReportLabelType.delivered: 'delivered',
  ReportLabelType.pending: 'pending',
  ReportLabelType.resolved: 'resolved',
};
