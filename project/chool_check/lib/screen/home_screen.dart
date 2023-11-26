import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // latitude - 위도, longitude - 경도
  static final LatLng companyLatLng = LatLng(
    37.5233273,
    126.921252,
  );

  // zoom까지 지정해줘야 함
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  // 원
  static final double okDistance = 100;
  static final Circle withinDistanceCircle = Circle(
    circleId: CircleId('withinDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );
  static final Circle notWithinDistanceCircle = Circle(
    circleId: CircleId('notWithinDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  // 마커
  static final marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      // future(snapshot.value) 값의 타입이 들어감
      body: FutureBuilder<String>(
        future: checkPermission(),
        // checkPermission의 return값을 snapshot 값으로 받을수 있다
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print(snapshot.connectionState);
          // snapshot.connectionState의 값
          // watiting - 대기중 (함수가 아직 실행중일때 반환)
          // done - 끝 (함수가 다 빌드 됬을때)
          // 이 값을 가지고 지도의 상태를 알수 있음

          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 상태일때
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          // 위치 권한이 허가되었을때
          // print(snapshot.data);
          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    final start = snapshot.data!;
                    final end = companyLatLng;

                    final distance = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );

                    if(distance < okDistance) {
                      isWithinRange = true;
                    }
                  }

                  print(snapshot.data);
                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        circle: isWithinRange ? withinDistanceCircle : notWithinDistanceCircle,
                        marker: marker,
                      ),
                      _ChoolCheckButton(),
                    ],
                  );
                });
          }

          // 위치 권한이 허가가 안되었을떄
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  Future<String> checkPermission() async {
    // 기기에 위치 정보가 꺼져있는지 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    // 현재 앱이 가지고 있는 위치 서비스에 대한 권한 가져오기

    // denied - 앱 실행했을때 상태(기본)
    // deniedForever - 권한 요청 거절 (다시는 이 앱에서 권한 요청을 못함)
    // whilInUse - 권한 허용 (앱 실행중일때만)
    // always - 권한 허용
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다.';
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text(
        '오늘도 출근',
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text('출근'),
    );
  }
}
