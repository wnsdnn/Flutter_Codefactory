import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            // [HomeScreen(), RouteOneScreen(), RouteThreeScreen()]
            // 기존에 있는 RouteTwoScreen()을 지우고 RouteThreeScreen()을 집어넣은거랑 같음
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return RouteThreeScreen();
                },
              ),
            );
            // 이름으로 페이지 실행하기
            // Navigator.of(context).pushReplacementNamed('/three');
          },
          child: Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) {
                  return RouteThreeScreen();
                },
              ),
              // route: 네비게이션 스택에 있는 모든 라우터
              // false 리턴 -> 스택의 라우터 삭제
              // true 리턴 -> 스택의 라우터 보존
              // route.settings.name -> named 라우터를 사용해서 넘어왔다면 이값에 라우터 경로가 들어옴
              (route) => route.settings.name == '/',
            );

            // 이름으로 페이지 실행하기
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   '/three',
            //   (route) => route.settings.name == '/',
            // );
          },
          child: Text('Push And Remove Until'),
        ),
      ],
    );
  }
}
