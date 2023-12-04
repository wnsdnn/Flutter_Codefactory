import 'package:calendar_scheduler/component/custome_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // 시스템적으로 가져진 크기를 가져올수 있음(top, left, bottom. right)
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        // 텍스트 필드 focus 해주는 코드
        // FocusNode(): 아무 텍스트 필드도 연결되어있지 않기 때문에 여기서는 포커스를 잃게 됨
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: bottomInset,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(),
                    SizedBox(height: 16.0),
                    _Content(),
                    SizedBox(height: 16.0),
                    _ColorPicker(),
                    SizedBox(height: 8.0),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey는 생성을 했는데
    // Form 위젯과 결합을 안했을때
    if(formKey.currentState == null) {
      return;
    }

    // Form 위젯 밑에 있는 모든 TextField에서 validate가 실행됨
    // 모두 에러가 안나면 true, 1개라도 나면 false
    if(formKey.currentState!.validate()) {
      print('에러가 없습니다.');
    } else {
      print('에러가 있습니다.');
    }

  }

}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomeTextField(
            label: '시작시간',
            isTime: true,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomeTextField(
            label: '마감시간',
            isTime: true,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomeTextField(
        label: '내용',
        isTime: false,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 가로 gap
      spacing: 8.0,
      // 세로 gap
      runSpacing: 10.0,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                )),
            child: Text(
              '저장',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
