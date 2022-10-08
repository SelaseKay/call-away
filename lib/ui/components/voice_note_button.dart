import 'dart:async';

import 'package:call_away/provider/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VoiceNoteButton extends ConsumerStatefulWidget {
  const VoiceNoteButton({Key? key}) : super(key: key);

  @override
  ConsumerState<VoiceNoteButton> createState() => _VoiceNoteButtonState();
}

class _VoiceNoteButtonState extends ConsumerState<VoiceNoteButton>
    with WidgetsBindingObserver {
  var duration = const Duration();
  late Duration finalDuration;
  Timer? timer;

  var _audioStatus = AudioStatus.initial;
  var finalMinutes = "0";
  var finalSeconds = "0";

  String _time = "00:00";

  var countToFinalDuration = const Duration();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
       if(timer != null){
          ref.read(audioProvider.notifier).stopRecording();
          setState(() {
            _audioStatus = AudioStatus.finishedRecording;
          });
          stopTimer();
        }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeFlutterSound();
  }

  Future<void> _initializeFlutterSound() async {
    await ref.read(audioProvider.notifier).initSoundRecorder();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setTimer(),
    );
  }

  void stopTimer() {
    timer!.cancel();
    if (_audioStatus == AudioStatus.finishedRecording) {
      finalDuration = duration;
      finalMinutes = twoDigits(duration.inMinutes.remainder(60));
      finalSeconds = twoDigits(duration.inSeconds.remainder(60));
      duration = const Duration();
    }
  }

  void setTimer() {
    if (_audioStatus == AudioStatus.recording) {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
        final minutes = twoDigits(duration.inMinutes.remainder(60));
        final sec = twoDigits(duration.inSeconds.remainder(60));
        _time = "$minutes:$sec";
      });
    } else if (_audioStatus == AudioStatus.playing) {
      setState(() {
        final seconds = countToFinalDuration.inSeconds + 1;
        countToFinalDuration = Duration(seconds: seconds);
        final minutes = twoDigits(countToFinalDuration.inMinutes.remainder(60));
        final sec = twoDigits(countToFinalDuration.inSeconds.remainder(60));
        _time = "$minutes:$sec";
        if (seconds == finalDuration.inSeconds) {
          timer!.cancel();
          _audioStatus = AudioStatus.pause;
          countToFinalDuration = const Duration();
        }
      });
    }
  }

  void onCloseIconPressed() {
    ref.read(audioProvider.notifier).stopPlayer();
    setState(() {
      _audioStatus = AudioStatus.initial;
    });
  }

  Widget _getWidget() {
    if (_audioStatus == AudioStatus.recording) {
      return _RecordingInProgress(
        onPressed: onPressed,
        time: _time,
      );
    } else if (_audioStatus == AudioStatus.finishedRecording) {
      return _PlayRecording(
        onCloseIconPressed: onCloseIconPressed,
        onPressed: onPressed,
        time: _time,
      );
    } else if (_audioStatus == AudioStatus.playing) {
      return _PauseAudio(
        onCloseIconPressed: onCloseIconPressed,
        onPressed: onPressed,
        time: _time,
      );
    } else if (_audioStatus == AudioStatus.pause) {
      return _PlayRecording(
        onCloseIconPressed: onCloseIconPressed,
        onPressed: onPressed,
        time: _time,
      );
    }
    return _AddVNButton(
      onPressed: onPressed,
    );
  }

  void onPressed() async {
    switch (_audioStatus) {
      case AudioStatus.recording:
        await ref.read(audioProvider.notifier).toggleRecording();
        setState(() {
          _audioStatus = AudioStatus.finishedRecording;
          stopTimer();
        });
        break;
      case AudioStatus.finishedRecording:
        await ref.read(audioProvider.notifier).toggleAudioPlaying();
        setState(() async {
          _audioStatus = AudioStatus.playing;
          startTimer();
        });
        break;
      case AudioStatus.playing:
        await ref.read(audioProvider.notifier).toggleAudioPlaying();
        setState(() {
          _audioStatus = AudioStatus.pause;
          stopTimer();
        });
        break;
      case AudioStatus.pause:
        await ref.read(audioProvider.notifier).toggleAudioPlaying();
        setState(() {
          _audioStatus = AudioStatus.playing;
          startTimer();
        });
        break;
      default:
        await ref.read(audioProvider.notifier).toggleRecording();
        setState(() {
          _audioStatus = AudioStatus.recording;
          startTimer();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getWidget();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    super.dispose();
  }

  Future<void> disposeFlutterSound() async {
    ref.read(audioProvider.notifier).dispose();
  }
}

class _AddVNButton extends StatelessWidget {
  const _AddVNButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  24,
                ),
              ),
            ),
            side: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.36),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/mic_icon.svg',
                color: const Color(0xFF11A17F),
              ),
              const SizedBox(width: 16.0),
              Text(
                "Record Voice",
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF11A17F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecordingInProgress extends StatelessWidget {
  const _RecordingInProgress({
    Key? key,
    required this.onPressed,
    required this.time,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  24,
                ),
              ),
            ),
            side: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.36),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/stop_icon.svg',
              ),
              const SizedBox(width: 16.0),
              Text(
                time,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFBF2626),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayRecording extends StatelessWidget {
  const _PlayRecording(
      {Key? key,
      required this.onCloseIconPressed,
      required this.onPressed,
      required this.time})
      : super(key: key);
  final VoidCallback onPressed;
  final String time;

  final VoidCallback onCloseIconPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  24,
                ),
              ),
            ),
            side: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.36),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/play_icon.svg',
                color: const Color(0xFF11A17F),
              ),
              const SizedBox(width: 16.0),
              Text(
                time,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF11A17F),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        InkWell(
          onTap: onCloseIconPressed,
          child: SvgPicture.asset("assets/images/close_icon.svg"),
        ),
      ],
    );
  }
}

class _PauseAudio extends StatelessWidget {
  const _PauseAudio(
      {Key? key,
      required this.onCloseIconPressed,
      required this.onPressed,
      required this.time})
      : super(key: key);

  final VoidCallback onPressed;

  final String time;

  final VoidCallback onCloseIconPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  24,
                ),
              ),
            ),
            side: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.36),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/pause_icon.svg',
                color: const Color(0xFF11A17F),
              ),
              const SizedBox(width: 16.0),
              Text(
                time,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF11A17F),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        InkWell(
          onTap: onCloseIconPressed,
          child: SvgPicture.asset("assets/images/close_icon.svg"),
        ),
      ],
    );
  }
}

enum AudioStatus {
  initial,
  recording,
  finishedRecording,
  playing,
  pause,
}
