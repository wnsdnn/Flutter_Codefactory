import 'dart:ffi';

import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: renderFloatingActionButton(),
        body: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySeleted,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(height: 8.0),
            _SchduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // 기본으로 최대 사이즈가 화면에 절반만큼만 차지
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // 최대 늘리기
          builder: (context) {
            return ScheduleBottomSheet(
              selectedDate: selectedDay,
            );
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  onDaySeleted(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _SchduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _SchduleList({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Schedule>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('스케줄이 없습니다.'),
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  // 각각의 위젯들 사이에 들어갈 위젯 리턴
                  return SizedBox(height: 8.0);
                },
                itemBuilder: (context, index) {
                  final schedule = snapshot.data![index];

                  return ScheduleCard(
                    startTime: schedule.startTime,
                    endTime: schedule.endTime,
                    content: schedule.content,
                    color: Colors.red,
                  );
                },
              );
            }),
      ),
    );
  }
}
