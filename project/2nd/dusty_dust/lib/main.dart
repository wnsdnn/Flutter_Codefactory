import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/screen/home_screen.dart';
import 'package:dusty_dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';

void main() async {
  await Hive.initFlutter();

  // Hive에 등록할 클래스 등록하는 코드
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());
  Hive.registerAdapter<StatModel>(StatModelAdapter());

  await Hive.openBox(testBox);


  // ItemCode에 값별로 Hive에 박스 열기
  for(ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower'
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: TestScreen(),
    ),
  );
}
