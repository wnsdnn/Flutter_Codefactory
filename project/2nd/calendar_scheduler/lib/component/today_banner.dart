import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectdDay;
  final int scheduleCount;

  const TodayBanner({
    super.key,
    required this.selectdDay,
    required this.scheduleCount,
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
              '${selectdDay.year}년 ${selectdDay.month}월 ${selectdDay.day}일',
              style: textStyle,
            ),
            Text(
              '$scheduleCount개',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
