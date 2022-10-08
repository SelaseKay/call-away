import 'dart:io';

import 'package:call_away/services/video_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoProvider =
    StateNotifierProvider.autoDispose<VideoService, List<File>?>((ref) {
  return VideoService();
});
