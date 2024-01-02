import 'package:drift/drift.dart';

class CategoryColors extends Table {
  // PRIMARY EKY
  IntColumn get id => integer().autoIncrement()();

  // 색상 코드
  TextColumn get hexCode => text()();
}