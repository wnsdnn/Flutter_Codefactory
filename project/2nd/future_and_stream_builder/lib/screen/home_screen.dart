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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: renderStreamBuilder(),
        ),
      ),
    );
  }

  FutureBuilder renderFutureBuilder() {
    return FutureBuilder<int>(
      future: getNumber(),
      // future: null,
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        if (snapshot.hasData) {
          // 데이터가 있을떄 위젯 렌더링
        }

        if (snapshot.hasError) {
          // 에러가 났을때 위젯 렌더링
        }

        // 로딩중일때 위젯 렌더링

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'FutureBuilder',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            Text(
              'ConState: ${snapshot.connectionState}',
              style: textStyle,
            ),
            Row(
              children: [
                Text(
                  'Data: ${snapshot.data}',
                  style: textStyle,
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  CircularProgressIndicator(),
              ],
            ),
            Text(
              'Error: ${snapshot.error}',
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

  StreamBuilder renderStreamBuilder() {
    return StreamBuilder<int>(
      stream: streamNumbers(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'StreamBuilder',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            Text(
              'ConState: ${snapshot.connectionState}',
              style: textStyle,
            ),
            Row(
              children: [
                Text(
                  'Data: ${snapshot.data}',
                  style: textStyle,
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  CircularProgressIndicator(),
              ],
            ),
            Text(
              'Error: ${snapshot.error}',
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

    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {

      await Future.delayed(Duration(seconds: 1));

      if(i == 5) {
        throw Exception('i = 5');
      }

      yield i;
    }
  }
}
