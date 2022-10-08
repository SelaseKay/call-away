import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_session/audio_session.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class AudioService extends StateNotifier<File?> {
  AudioService() : super(null);

  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;

  final audioPath = "voice_note.mp4";

  Future<void> initSoundRecorder() async {
    debugPrint("initializing Flutter sound");

    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();

    final micPermissionStatus = await Permission.microphone.request();

    if (micPermissionStatus != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission not granted");
    }
    await _audioRecorder!.openRecorder();
    await _audioPlayer!.openPlayer();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    debugPrint("Fluttersound initializing complete");
  }

  Future<void> _record() async {
    await _audioRecorder!.startRecorder(
      toFile: audioPath,
      codec: Codec.aacMP4,
      audioSource: AudioSource.microphone,
    );
  }

  Future<void> stopRecording() async {
    await _audioRecorder!.stopRecorder();
    state = File(audioPath);
  }

  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await stopRecording();
    }
  }

  Future<void> _playAudio() async {
    if (_audioPlayer!.isStopped) {
      _audioPlayer!.startPlayer(
        fromURI: audioPath,
        codec: Codec.aacMP4,
        whenFinished: () {},
      );
    } else if (_audioPlayer!.isPaused) {
      _audioPlayer!.resumePlayer();
    }
  }

  Future<void> _pausePlayer() async {
    _audioPlayer!.pausePlayer();
  }

  Future<void> stopPlayer() async {
    _audioPlayer!.stopPlayer();
    state = null;
  }

  Future<void> toggleAudioPlaying() async {
    if (!_audioPlayer!.isPlaying) {
      await _playAudio();
    } else {
      await _pausePlayer();
    }
  }

  Future<void> disposeSoundRecorder() async {
    await _audioRecorder!.closeRecorder();
    await _audioPlayer!.closePlayer();
    _audioRecorder = null;
    _audioPlayer = null;
    state = null;
  }
}
