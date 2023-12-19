import 'package:dusty_dust/main.dart';
import 'package:dusty_dust/screen/test2_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestScreen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<Box>(
            // 값이 변경 될때마다 listenable
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, widget) {
              return Column(
                children: box.values.map((e) => Text(e.toString())).toList(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys: ${box.keys.toList()}');
              print('values: ${box.values.toList()}');
            },
            child: Text('박스 프린트하기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 데이터를 생성하거나
              // 업데이트할때
              box.put(1000, '새로운 데이터!!!');
            },
            child: Text('데이터 넣기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 값 기준으로 가져옴
              print(box.get(100));
              // index 기준으로 가져옴
              print(box.getAt(3));
            },
            child: Text('특정 값 가져오기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              box.delete(1000);
            },
            child: Text('삭제하기!'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Test2Screen(),
                ),
              );
            },
            child: Text('다음화면!'),
          ),
        ],
      ),
    );
  }
}
