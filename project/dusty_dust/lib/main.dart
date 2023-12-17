import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/screen/home_screen.dart';
import 'package:dusty_dust/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


const testBox = 'test';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(testBox);

  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  for(ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }


  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: HomeScreen(),
      // home: TestScreen(),
    ),
  );
}
