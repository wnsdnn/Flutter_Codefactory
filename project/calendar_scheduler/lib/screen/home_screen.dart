import 'dart:ffi';

import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:flutter/material.dart';

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  itemCount: 100,
                  separatorBuilder: (context, index) {
                    // 각각의 위젯들 사이에 들어갈 위젯 리턴
                    return SizedBox(height: 8.0);
                  },
                  itemBuilder: (context, index) {
                    print(index);
                    return ScheduleCard(
                      startTime: 8,
                      endTime: 11,
                      content: '프로그래밍 공부하기',
                      color: Colors.red,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
