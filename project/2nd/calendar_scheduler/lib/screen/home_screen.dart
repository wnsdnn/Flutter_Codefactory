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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectdDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.0);
                  },
                  itemBuilder: (context, index) {
                    return ScheduleCard(
                      startTime: 8,
                      endTime: 9,
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

  onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
