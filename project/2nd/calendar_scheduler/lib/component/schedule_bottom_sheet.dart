import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // 시스템과 화면 사이에 아랫쪽(bottom) 간격 가져오기
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
            TextField(),
          ],
        ),
      ),
    );
  }
}
