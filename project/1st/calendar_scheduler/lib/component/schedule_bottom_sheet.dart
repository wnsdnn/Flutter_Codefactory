import 'package:calendar_scheduler/component/custome_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/category_color.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? scheduleId;

  const ScheduleBottomSheet({
    super.key,
    required this.selectedDate,
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
    // 시스템적으로 가져진 크기를 가져올수 있음(top, left, bottom. right)
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        // 텍스트 필드 focus 해주는 코드
        // FocusNode(): 아무 텍스트 필드도 연결되어있지 않기 때문에 여기서는 포커스를 잃게 됨
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

            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Future가 실행되고
            // 값이 있는데 단 한번도 startTime이 세팅되지 않았을때
            if (snapshot.hasData && startTime == null) {
              startTime = snapshot.data!.startTime;
              endTime = snapshot.data!.endTime;
              content = snapshot.data!.content;
              selectdColorId = snapshot.data!.colorId;
            }

            print(snapshot.data);

            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + bottomInset,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomInset,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                    child: Form(
                      key: formKey,
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
                            endiIntialValue: endTime?.toString() ?? '',
                          ),
                          SizedBox(height: 16.0),
                          _Content(
                            onSaved: (String? val) {
                              content = val!;
                            },
                            intialValue: content ?? '',
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
                                  colorIdSetter: (int id) {
                                    setState(() {
                                      selectdColorId = id;
                                    });
                                  },
                                );
                              }),
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

    // Form 위젯 밑에 있는 모든 TextField에서 validate가 실행됨
    // 모두 에러가 안나면 true, 1개라도 나면 false
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final scheduleId = widget.scheduleId;

      if (scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(SchedulesCompanion(
          content: Value(content!),
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          colorId: Value(selectdColorId!),
        ));
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleByid(
          scheduleId,
          SchedulesCompanion(
            content: Value(content!),
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
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
  final String endiIntialValue;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.startInitialValue,
    required this.endiIntialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomeTextField(
            label: '시작시간',
            isTime: true,
            onSaved: onStartSaved,
            initialValue: startInitialValue,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomeTextField(
            label: '마감시간',
            isTime: true,
            onSaved: onEndSaved,
            initialValue: endiIntialValue,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final String intialValue;

  const _Content({
    super.key,
    required this.onSaved,
    required this.intialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomeTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
        initialValue: intialValue,
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
    return Wrap(
      // 가로 gap
      spacing: 8.0,
      // 세로 gap
      runSpacing: 10.0,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(e, selectedColorId == e.id),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          int.parse('FF${color.hexCode}', radix: 16),
        ),
        border: isSelected ? Border.all(color: Colors.black, width: 4.0) : null,
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
