import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class MediaPlayer extends StatefulWidget {
  MediaPlayer({this.controller, this.video, this.image, this.mediaType});

  final VideoPlayerController controller;
  final File video;
  final File image;
  final String mediaType;

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.mediaType == 'image'
          ? widget.image != null
              ? SizedBox(
                  width: 350,
                  child: Image.file(widget.image),
                )
              : Text("Image is null")
          : widget.video != null
              ? widget.controller.value.initialized != null
                  ? Stack(
                      children: [
                        SizedBox(
                          width: 350,
                          child: AspectRatio(
                            aspectRatio: widget.controller.value.aspectRatio,
                            child: VideoPlayer(widget.controller),
                          ),
                        ),
                        Positioned(
                          left: 150,
                          top: 280,
                          child: Opacity(
                            opacity: 0.9,
                            child: FloatingActionButton(
                              backgroundColor: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  if (widget.controller.value.initialized ==
                                      false) {
                                    print("controller is not initialized");
                                    widget.controller.initialize();
                                  } else if (widget
                                          .controller.value.isPlaying ==
                                      false) {
                                    print("Controller is not palying");
                                    widget.controller.play();
                                  } else {
                                    print("Controller is playing");
                                    widget.controller.pause();
                                  }
                                });
                              },
                              child: Icon(
                                widget.controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text("Controller not initialized")
              : Text("Video is null"),
    ]);
  }
}
