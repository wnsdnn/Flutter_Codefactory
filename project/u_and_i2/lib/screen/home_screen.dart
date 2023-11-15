import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.pink[100],
          child: Column(
            children: [
              _TopContainer(
                selectedDate: selectedDate,
                onPressed: OnHeartPerssed,
              ),
              _BottomContainer(),
            ],
          ),
        ),
      ),
    );
  }

  OnHeartPerssed() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300.0,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              initialDateTime: selectedDate,
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

class _TopContainer extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopContainer({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
                style: textTheme.bodyText1
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: textTheme.bodyText2
              )
            ],
          ),
          IconButton(
            iconSize: 50.0,
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays + 1}',
            style: textTheme.headline2
          )
        ],
      ),
    );
  }
}

class _BottomContainer extends StatefulWidget {
  const _BottomContainer({Key? key}) : super(key: key);

  @override
  State<_BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<_BottomContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
