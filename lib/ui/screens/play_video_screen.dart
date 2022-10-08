import 'dart:io';

import 'package:call_away/provider/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PlayVideoScreen extends ConsumerStatefulWidget {
  const PlayVideoScreen({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  ConsumerState<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends ConsumerState<PlayVideoScreen> {
  late VideoPlayerController _controller;
  late bool isPlaying;
  String? thumbNail;

  Future<void> _getThumbNail() async {
    thumbNail = await VideoThumbnail.thumbnailFile(video: widget.path);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    _getThumbNail();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.isPlaying) {
            setState(() {
              isPlaying = true;
            });
          } else {
            setState(() {
              isPlaying = false;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _controller.dispose().then((value) => Navigator.pop(context));
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        actions: [
          _controller.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Center(
                    child: Text(
                      '${_controller.value.duration.inSeconds} seconds',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                  radius: 30,
                  child: thumbNail == null
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          onPressed: () async {
                            await _controller.dispose();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            ref.read(videoProvider.notifier).updateVideoState(
                                video: File(widget.path),
                                thumbNail: File(thumbNail!));
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ))),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
