import 'dart:io';

import 'package:call_away/services/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioProvider = StateNotifierProvider<AudioService, File?>((ref) {
  final audioService =  AudioService();
  ref.onDispose(() {
    audioService.disposeSoundRecorder();
  });
  return audioService;
});
