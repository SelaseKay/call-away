import 'package:json_annotation/json_annotation.dart';

enum ReportLabelType {
  @JsonValue("delivered")
  delivered,
  @JsonValue("pending")
  pending,
  @JsonValue("resolved")
  resolved;

  // String toJson() => name;
  // static ReportTagStatus fromJson(String json) => values.byName(json);
}