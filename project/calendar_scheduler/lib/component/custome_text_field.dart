import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;

  const CustomeTextField({
    super.key,
    required this.label,
    required this.isTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextField(
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime, // 사이즈 최대로 늘리기
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
