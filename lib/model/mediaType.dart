// ignore: file_names
// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum MediaType {
  @JsonValue("video")
  VIDEO,
  @JsonValue("image")
  IMAGE;

  const MediaType();
}
