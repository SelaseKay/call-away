import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoService extends StateNotifier<List<File>?> {
  VideoService() : super(null);
  void updateVideoState({required File video, required File thumbNail}) {
    state = [video, thumbNail];
  }

  void clear() async {
    state = null;
  }
}
