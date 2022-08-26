// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReportStatus _$$_ReportStatusFromJson(Map<String, dynamic> json) =>
    _$_ReportStatus(
      time: json['time'] as String? ?? "",
      status: $enumDecodeNullable(_$ReportTagStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$_ReportStatusToJson(_$_ReportStatus instance) =>
    <String, dynamic>{
      'time': instance.time,
      'status': instance.status,
    };

const _$ReportTagStatusEnumMap = {
  ReportTagStatus.delivered: 'delivered',
  ReportTagStatus.received: 'received',
  ReportTagStatus.pending: 'pending',
  ReportTagStatus.resolved: 'resolved',
};
