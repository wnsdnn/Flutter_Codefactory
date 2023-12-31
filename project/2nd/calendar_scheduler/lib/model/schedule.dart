import 'package:drift/drift.dart';

class Schedules extends Table {
  // PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  // 내용
  TextColumn get cotnent => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // 생성날짜
  // 얜 값 넣어줄수 있음
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}