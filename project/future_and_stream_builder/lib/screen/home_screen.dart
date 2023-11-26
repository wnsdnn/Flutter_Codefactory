import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getStreamBuilder(),
      ),
    );
  }

  StreamBuilder getStreamBuilder() {
    return StreamBuilder<int>(
      stream: streamNumbers(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        // 리턴정보 표기
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'StreamBuilder',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            Text('ConState: ${snapshot.connectionState}'),
            Text(
              'Data : ${snapshot.data}',
              style: textStyle,
            ),
            Text(
              'Error : ${snapshot.error}',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('setState'),
            ),
          ],
        );
      },
    );
  }

  FutureBuilder getFutureBuilder() {
    return FutureBuilder(
      future: getNumber(),
      builder: (context, snapshot) {
        // 캐싱되는게 FutureBuilder에 강점!

        if(snapshot.hasData) {
          // 데이터가 있을때 위젯 렌더링
        }

        if(snapshot.hasError) {
          // 에러가 났을때 위젯 렌더링
        }

        // 로딩중일때 위젯 렌더링

        // 리턴정보 표기
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'FutureBuilder',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            Text('ConState: ${snapshot.connectionState}'),
            Text(
              'Data : ${snapshot.data}',
              style: textStyle,
            ),
            Text(
              'Error : ${snapshot.error}',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('setState'),
            ),
          ],
        );
      },
    );
  }


  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    // 에러 반환
    // 에러가 나는 동안에도 캐싱이된다
    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }


  Stream<int> streamNumbers() async* {
    for(int i = 0; i < 10; i++) {
      if (i == 5) {
        throw Exception('i = 5');
      }

      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
