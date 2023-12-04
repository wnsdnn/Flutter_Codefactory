import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

const DEFAULT_COLOR = [
  // 빨강
  'FF44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남
  '3F51B5',
  // 보라
  '9C27B0'
];

void main() async {
  // 플러터 프레임워크가 준비되기 전까지 runApp 실행 안되게하기
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if(colors.isEmpty) {
    for(String hexCode in DEFAULT_COLOR) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        )
      );
    }
  }

  // print('------ GET COLORS --------');
  // print(await database.getCategoryColors());

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
