// private 값들을 불러올 수 없다.
import 'dart:io';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// private 값까지 불러올 수 있다.
// 같은 파일인데 코드가 많아서 나눠놓은 느낌으로 생각.
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> insertSchedule(SchedulesCompanion data) => into(schedules).insert(data);

  Future<int> insertCategoryColor(CategoryColorsCompanion data) => into(categoryColors).insert(data);

  Stream<List<Schedule>> watchSchedules() => select(schedules).watch();

  Future<List<CategoryColor>> getCategoryColors() => select(categoryColors).get();


  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
