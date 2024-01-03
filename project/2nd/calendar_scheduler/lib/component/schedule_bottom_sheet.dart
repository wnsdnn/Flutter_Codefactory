import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectdDate;

  const ScheduleBottomSheet({
    super.key,
    required this.selectdDate,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectdColorId;

  @override
  Widget build(BuildContext context) {
    // 시스템과 화면 사이에 아랫쪽(bottom) 간격 가져오기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        // 포커스 옮기기
        // FocusNode()로 설정해놔서 포커스 없어짐
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
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Form(
                key: formKey,
                // 자동 검증
                // autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val) {
                        startTime = int.parse(val!);
                      },
                      onEndSaved: (String? val) {
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16.0),
                    _Content(
                      onSaved: (String? val) {
                        content = val;
                      },
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<CategoryColor>>(
                      future: GetIt.I<LocalDatabase>().getCategoryColors(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            selectdColorId == null &&
                            snapshot.data!.isNotEmpty) {
                          selectdColorId = snapshot.data![0].id;
                        }

                        return _ColorPicker(
                          colors:
                              snapshot.hasData ? snapshot.data!.toList() : [],
                          selectedColorId: selectdColorId,
                          colorIdSetter: (id) {
                            setState(() {
                              selectdColorId = id;
                            });
                          },
                        );
                      },
                    ),
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

  void onSavePressed() async {
    // formKey는 생성을 했는데
    // Form 위젯과 결합을 안했을때
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      
      final key = await GetIt.I<LocalDatabase>().insertSchedule(
        SchedulesCompanion(
          date: Value(widget.selectdDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          cotnent: Value(content!),
          colorId: Value(selectdColorId!),
        ),
      );

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              label: '시작 시간',
              isTime: true,
              onSaved: onStartSaved,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: CustomTextField(
              label: '마감 시간',
              isTime: true,
              onSaved: onEndSaved,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({
    super.key,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    super.key,
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap - 자동 줄바꿈해줌
    return Wrap(
      // 가로 간견
      spacing: 8.0,
      // 세로 간격
      runSpacing: 10.0,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(
          'FF${color.hexCode}',
          radix: 16,
        )),
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                width: 4.0,
                color: Colors.black,
              )
            : null,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    super.key,
    required this.onPressed,
  });

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
              ),
            ),
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
