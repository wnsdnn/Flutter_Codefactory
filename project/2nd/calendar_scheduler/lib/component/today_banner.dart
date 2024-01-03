import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectdDate;

  const TodayBanner({
    super.key,
    required this.selectdDate,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectdDate.year}년 ${selectdDate.month}월 ${selectdDate.day}일',
              style: textStyle,
            ),
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectdDate),
              builder: (context, snapshot) {
                int count = 0;

                if(snapshot.hasData) {
                  count = snapshot.data!.length;
                }

                return Text(
                  '$count개',
                  style: textStyle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
