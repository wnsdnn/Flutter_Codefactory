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

    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(videoController!),
          _Controls(
            onReversePressed: onReversePressed,
            onPlayPressed: onPlayPressed,
            onForwardPressed: onForwardPressed,
            isPlaying: videoController!.value.isPlaying,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              iconSize: 30.0,
              color: Colors.white,
              icon: Icon(
                Icons.photo_camera_back,
              ),
            ),
          )
        ],
      ),
    );
  }


  void onReversePressed() {
    // 현재 영상 길이
    final currentPosition = videoController!.value.position;

    // Duration()에 아무것도 안넣어주면 0초
    Duration position = Duration();

    // currentPosition이 3초보다 클때만 -3초
    if(currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    // 이미 실행중이면 중지
    // 실행중이 아니면 정지
    setState(() {
      if(videoController!.value.isPlaying) {
        // 재생 상태
        videoController!.pause();
      } else {
        // 일시정지 상태
        videoController!.play();
      }
    });
  }

  void onForwardPressed() {
    // 총 영상길이
    final maxPosition = videoController!.value.duration;
    // 현재 영상길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition;

    // 전체길이 - 3초보다 현재 길이가 더 작으면 +3
    if((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}
