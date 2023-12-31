import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 100 ~ 900까지 진하기 설정 가능
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _TopPart(
                  selectedDate: selectedDate,
                  onPressed: onHeartPressed,
                ),
                _BottomPart(),
              ],
            )),
      ),
    );
  }

  onHeartPressed() {
    DateTime now = DateTime.now();

    // dialog
    showCupertinoDialog(
      context: context,
      // barrierDismissible 기본값 : false
      // 배경을 누르면 자동으로 닫게하기
      barrierDismissible: true,
      builder: (context) {
        // 특정 위젯이 어디에 정리해야할지 모르면 전체화면을 차지
        // Align 위젯을 사용해서 위젯을 어디에 정리할지 알려주기
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime(now.year, now.month, now.day),
              // 날짜나 시간이 바뀌었을때
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 테마 가져오기 (위젯에서 가장 가까운 테마 가져올수 있음)
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    DateTime now = DateTime.now();

    // Expanded로 감싸서 크기가 넘어가는 오류 방지
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난날',
                style: textTheme.bodyText1,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: textTheme.bodyText2,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).difference(selectedDate).inDays + 1}',
            style: textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    // Expanded로 감싸서 크기가 넘어가는 오류 방지
    return Expanded(
      child: Image.asset('asset/img/middle_image.png'),
    );
  }
}
