import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player2/conponent/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        newVideoPressed: newVideoPressed,
      ),
    );
  }

  Widget renderEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTapClickEvent: newVideoPressed,
          ),
          SizedBox(
            height: 20.0,
          ),
          _TextPart(),
        ],
      ),
    );
  }

  void newVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTapClickEvent;

  const _Logo({
    required this.onTapClickEvent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapClickEvent,
      child: Image.asset('asset/image/logo.png'),
    );
  }
}

class _TextPart extends StatelessWidget {
  const _TextPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        Text(
          'PLAYER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
