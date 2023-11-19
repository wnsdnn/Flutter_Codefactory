import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;

  const CustomVideoPlayer({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();

    // initState에서는 async가 안되서 따로 뺌
    initializeController();
  }

  initializeController() async {
    videoController = VideoPlayerController.file(
      // dart.io에 있는 File 객체 가져옴
        File(widget.video.path)
    );

    // 초기화
    await videoController!.initialize();

    // 다시 빌드할수 있도록 setState() 호출
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      // 버퍼링 위젯
      return CircularProgressIndicator();
    }

    return VideoPlayer(
        videoController!
    );
  }
}
