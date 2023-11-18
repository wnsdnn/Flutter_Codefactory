import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        // color와 BoxDecoration은 같은 자식요소로 쓸수 없다. (BoxDecoration 안에서는 Color 쓸수는 있음)
        decoration: getBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            SizedBox(height: 30.0,),
            _AppName(),
          ],
        ),
      ),
    );
  }


  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      // LinearGradient: 선형 그라데이언트
      // RadialGradient: 원형 그라데이언트
      gradient: LinearGradient(
        // 색상이 어디서부터 시작할지 (색상의 시작점)
        begin: Alignment.topCenter,
        // 색상이 어디를 마지막으로 끝낼건지 (색상의 끝점)
        end: Alignment.bottomCenter,
        //
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}


class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/image/logo.png',
    );
  }
}


class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // copyWith: 기존 값들은 유지하고 추가 값들만 덮어 씌운다
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

