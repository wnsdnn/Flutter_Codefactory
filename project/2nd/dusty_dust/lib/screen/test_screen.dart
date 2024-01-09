import 'package:dusty_dust/main.dart';
import 'package:dusty_dust/screen/test2.screen.dart';
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(testBox).listenable(),
            builder: (context, box, child) {

              return Column(
                children: box.values.map((e) => Text(e.toString())).toList(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys: ${box.keys.toList()}');
              print('valuse: ${box.values.toList()}');
            },
            child: Text('박스 프린트하기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // 데이터를 생성하거나 업데이트할때
              // box.add('테스트3');
              box.put(1000, '새로운 데이터!!!');
            },
            child: Text('데이터 넣기!'),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);

              // print(box.get(101));
              print(box.getAt(3));
            },
            child: Text('특정값 가져오기!'),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Test2Screen(),));
            },
            child: Text('다음화면!'),
          ),
        ],
      ),
    );
  }
}
