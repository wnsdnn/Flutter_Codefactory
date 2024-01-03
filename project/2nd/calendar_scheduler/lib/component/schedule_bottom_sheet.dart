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
  final int? scheduleId;

  const ScheduleBottomSheet({
    super.key,
    required this.selectdDate,
    this.scheduleId,
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
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId != null
              ? GetIt.I<LocalDatabase>().getScheduleById(widget.scheduleId!)
              : null,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('스케줄을 불러올 수 없습니다.'),
              );
            }

            // FutureBuilder가 처음시작됐고(캐싱 X)
            // 로딩중일때
            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Future가 실행이 되고
            // 값이 있는데 단 한번도 startTime이 세팅되지 않았을때 (위젯 첫 실행시)
            if (snapshot.hasData && startTime == null) {
              final data = snapshot.data!;
              startTime = data.startTime;
              endTime = data.endTime;
              content = data.cotnent;
              selectdColorId = data.colorId;
            }

            return SafeArea(
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
                            startInitialValue: startTime?.toString() ?? '',
                            endInitialValue: endTime?.toString() ?? '',
                          ),
                          SizedBox(height: 16.0),
                          _Content(
                            onSaved: (String? val) {
                              content = val;
                            },
                            contentInitialValue: content ?? '',
                          ),
                          SizedBox(height: 16.0),
                          FutureBuilder<List<CategoryColor>>(
                            future:
                                GetIt.I<LocalDatabase>().getCategoryColors(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  selectdColorId == null &&
                                  snapshot.data!.isNotEmpty) {
                                selectdColorId = snapshot.data![0].id;
                              }

                              return _ColorPicker(
                                colors: snapshot.hasData
                                    ? snapshot.data!.toList()
                                    : [],
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
            );
          }),
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

      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().insertSchedule(
          SchedulesCompanion(
            date: Value(widget.selectdDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            cotnent: Value(content!),
            colorId: Value(selectdColorId!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectdDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            cotnent: Value(content!),
            colorId: Value(selectdColorId!),
          ),
        );
      }

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.startInitialValue,
    required this.endInitialValue,
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
              initialValue: startInitialValue,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: CustomTextField(
              label: '마감 시간',
              isTime: true,
              onSaved: onEndSaved,
              initialValue: endInitialValue,
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final String contentInitialValue;

  const _Content({
    super.key,
    required this.onSaved,
    required this.contentInitialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
        initialValue: contentInitialValue,
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
