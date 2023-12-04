import 'dart:ffi';

import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
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
            _SchduleList(),
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
  const _SchduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Schedule>>(
          stream: GetIt.I<LocalDatabase>().watchSchedules(),
          builder: (context, snapshot) {
            print(snapshot.data);

            return ListView.separated(
              itemCount: 100,
              separatorBuilder: (context, index) {
                // 각각의 위젯들 사이에 들어갈 위젯 리턴
                return SizedBox(height: 8.0);
              },
              itemBuilder: (context, index) {
                return ScheduleCard(
                  startTime: 8,
                  endTime: 11,
                  content: '프로그래밍 공부하기',
                  color: Colors.red,
                );
              },
            );
          }
        ),
      ),
    );
  }
}
