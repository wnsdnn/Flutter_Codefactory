import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 / false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.initialValue,
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
        Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    // Form
    return TextFormField(
      // 상위에서 save() 함수가 호출되었을때 실행
      onSaved: onSaved,
      // null이 return 되면 에러가 없다.
      // 에러가 있으면 에러를 String 값으로 리턴해준다.
      validator: (value) {
        if(value == null || value.isEmpty) {
          return '값을 입력해주세요';
        }

        if(isTime) {
          int time = int.parse(value);

          if(time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          }

          if(time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }
        } else {
          if(value.length > 500) {
            return '500자 이하의 글자를 입력해주세요.';
          }
        }

        return null;
      },
      initialValue: initialValue,
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      // maxLength: 500,
      expands: !isTime, // 이 부분 true로 해줘야 TextField 끝까지 늘어남
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly,
      ] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
        suffixText: isTime ? '시' : null,
      ),
    );
  }
}
