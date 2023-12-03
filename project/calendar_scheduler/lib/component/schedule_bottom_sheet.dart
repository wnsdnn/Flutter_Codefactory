import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // 시스템적으로 가져진 크기를 가져올수 있음(top, left, bottom. right)
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset,
        ),
        child: Column(
          children: [
            TextField()
          ],
        ),
      ),
    );
  }
}
