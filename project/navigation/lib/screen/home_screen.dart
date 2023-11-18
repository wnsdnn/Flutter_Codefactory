import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true - 시스템 뒤로가기 활성화
        // false - 시스템 뒤로가기 비활성화
        // pop()을 함수는 못막음

        // 작업실행
        final canPop = Navigator.of(context).canPop();
        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              // [HomeScree()] => []
              // 하나 밖에 없던 화면이 없어져서 검은 화면이 뜸
              Navigator.of(context).pop();
            },
            child: Text('Pop'),
          ),
          ElevatedButton(onPressed: () {
            // pop 가능: true
            // pop 불가: false
            print(Navigator.of(context).canPop());
          }, child: Text('Can Pop'),),
          ElevatedButton(
            onPressed: () {
              // 네이게이션 스택에 값이 1개 밖에 없으면 pop 안해줌
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RouteOneScreen(number: 123);
                  },
                ),
              );

              print(result);
            },
            child: Text('Push'),
          ),
        ],
      ),
    );
  }
}
