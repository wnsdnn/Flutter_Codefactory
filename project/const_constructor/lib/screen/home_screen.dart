import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const - 빌드 타임에 모든 값을 알고 있을때만 실행가능
            // 앱이 실행하는 동안 단 1번만 그려놓음. -> 다시 그리지 않고 맨처음에 만들어 놓은 위젯을 계속 재사용
            // const 키워드를 쓰면 다시 build()를 안해줌
            // 앱이 더 효율적으로 돌아감. (메모리 낭비 X)
            const TextWidget(label: 'test1'),
            TextWidget(label: 'test2'),
            // ElevatedButton은 안됨. (onPressed 때문)
            ElevatedButton(
              child: Text('빌드!'),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String label;

  const TextWidget({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label 빌드 실행!');

    return Container(
      child: Text(
        label,
      ),
    );
  }
}
