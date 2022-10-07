import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioService extends StateNotifier<String> {
  late final FlutterSoundRecorder _audioRecorder;

  final audioPath = "voice_note.acc";

  AudioService() : super("") {
    _audioRecorder = FlutterSoundRecorder();
    _initSoundRecorder();
  }

  Future<void> _initSoundRecorder() async {
    final micPermissionStatus = await Permission.microphone.status;

    if (micPermissionStatus != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission not granted");
    }
    await _audioRecorder.openRecorder();
  }

  Future<void> _record() async {
    await _audioRecorder.startRecorder(toFile: audioPath);
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.startRecorder(toFile: audioPath);
  }

  Future<void> toggleRecording() async {
    if (_audioRecorder.isStopped) {
      await _record();
    } else {
      await _stopRecording();
    }
  }

  Future<void> disposeSoundRecorder() async {
    await _audioRecorder.closeRecorder();
  }
}
