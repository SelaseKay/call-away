// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportStatus _$$_ReportStatusFromJson(Map<String, dynamic> json) =>
    _$_ReportStatus(
      time: json['time'] as String? ?? "",
      status: $enumDecodeNullable(_$ReportLabelTypeEnumMap, json['status']),
    );

Map<String, dynamic> _$$_ReportStatusToJson(_$_ReportStatus instance) =>
    <String, dynamic>{
      'time': instance.time,
      'status': _$ReportLabelTypeEnumMap[instance.status],
    };

const _$ReportLabelTypeEnumMap = {
  ReportLabelType.delivered: 'delivered',
  ReportLabelType.received: 'received',
  ReportLabelType.pending: 'pending',
  ReportLabelType.resolved: 'resolved',
};
