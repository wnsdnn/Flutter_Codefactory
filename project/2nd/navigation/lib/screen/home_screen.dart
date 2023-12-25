import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WillPopScope - 시스템에서 뒤로가기 막기 (pop으로 뒤로가기는 못막음)
    return WillPopScope(
      onWillPop: () async {
        // true - pop 가능
        // false - pop 불가능

        // 작업실행
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              // 해당 페이지 뒤에 페이지 유뮤를 반환
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              // 만약 해당 페이지 뒤에 값이 없다면 pop() X
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<int>(
                MaterialPageRoute(
                  builder: (context) {
                    return RouteOneScreen(
                      number: 123,
                    );
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
