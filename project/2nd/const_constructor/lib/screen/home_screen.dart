import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 빌드 타입에 값들을 다 알수 있으면 const 삽입 가능
            // const 선언시 재빌드시 해당 위젯 재활용해줌 (리소스 관리)
            const TestWidget(label: 'test1'),
            TestWidget(label: 'test2'),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('빌드!'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    print('$label 빌드 실행!');
    return Container(
      child: Text('$label'),
    );
  }
}
