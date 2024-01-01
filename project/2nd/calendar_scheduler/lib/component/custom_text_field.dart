import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;

  const CustomTextField({
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
        if(isTime)
          renderTextField(),
        if(!isTime)
          Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextField(
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime, // 이 부분 true로 해줘야 TextField 끝까지 늘어남
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly,
      ] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
