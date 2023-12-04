import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomeTextField({
    super.key,
    required this.label,
    required this.isTime,
    required this.onSaved,
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
    // Form
    return TextFormField(
      // save() 함수가 불러졌을때 실행
      onSaved: onSaved,
      // null이 return 되면 에러가 없다.
      // 에러가 있으면 에러를 String 값으로 리턴해준다.
      validator: (String? val) {
        if(val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }

        if(isTime) {
          int time = int.parse(val);

          if(time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }

          if(time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {
          if(val.length > 500) {
            return '500자 이하의 글자를 입력해주세요';
          }
        }

        return null;
      },
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      // maxLength: 600,
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
