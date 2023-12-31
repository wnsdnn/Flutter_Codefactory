import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;

  // 내 ID
  int? uid = 0;

  // 상대 ID
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder<bool>(
          future: init(),
          // future: null,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: renderSubView(),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 160.0,
                          width: 120.0,
                          child: renderMainView(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (engine != null) {
                        await engine!.leaveChannel();
                        engine = null;
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text('채널 나가기'),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요.'),
      );
    } else {
      // 채널에 참여하고 있을때
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine!,
          canvas: VideoCanvas(
            uid: 0,
          ),
        ),
      );
    }
  }

  renderSubView() {
    if (otherUid == null) {
      return Center(
        child: Text('채널의 유저가 없습니다.'),
      );
    } else {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine!,
          canvas: VideoCanvas(uid: otherUid),
          connection: RtcConnection(channelId: CHANNEL_NAME),
        ),
      );
    }
  }

  Future<bool> init() async {
    // 권한 받기
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    // ===========================================

    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: APP_ID,
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          // 내가 채널에 입장했을떄
          // connection -> 연결정보
          // elapsed -> 연결된 시간(연결된지 얼마나 됐는지)
          onJoinChannelSuccess: (connection, elapsed) {
            print('채널에 입장했습니다. uid: ${connection.localUid}');
            setState(() {
              uid = connection.localUid;
            });
          },

          // 내가 채널에서 나갔을때
          onLeaveChannel: (connection, stats) {
            print('채널 퇴장');
            setState(() {
              uid = null;
            });
          },

          // 상대방 유저가 들어왔을때
          onUserJoined: (connection, remoteUid, elapsed) {
            print('상대가 채널에 입장했습니다. otherUid: $remoteUid');
            setState(() {
              otherUid = remoteUid;
            });
          },

          // 상대방이 채널에서 나갔을때
          onUserOffline: (connection, remoteUid, reason) {
            print('상대가 채널에서 나갔습니다. otherUid: $remoteUid');
            setState(() {
              otherUid = null;
            });
          },
        ),
      );

      // 엔진 실행
      await engine!.enableVideo();
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await engine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: options,
      );
    }

    return true;
  }
}
