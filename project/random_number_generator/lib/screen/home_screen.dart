import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [2274, 5926, 1560];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: OnSettingsPop,
              ),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: OnRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }

  void OnRandomNumberGenerate() {
    // 생성하기 버튼 클릭!
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      newNumbers.add(rand.nextInt(maxNumber));
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void OnSettingsPop() async {
    // 화면 이동 (라우터 스택에 넣음)
    // list - add [HomeScreen(), SettingsScreen()]
    // 미래의 돌려받을 값이기에 await 선언
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          iconSize: 25.0,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
          onPressed: onPressed,
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  List<int> randomNumbers;

  _Body({
    required this.randomNumbers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers.asMap().entries.map((item) {
          final index = item.key;
          final number = item.value;

          return Padding(
            padding: EdgeInsets.only(bottom: index == 2 ? 0 : 16.0),
            child: NumberRow(number: number),
          );
        }).toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        child: Text('생성하기!'),
        onPressed: onPressed,
      ),
    );
  }
}
