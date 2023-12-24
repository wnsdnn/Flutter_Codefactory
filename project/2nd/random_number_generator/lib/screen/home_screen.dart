import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/colors.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(
                randomNumbers: randomNumbers,
              ),
              _Footer(
                onPressed: onRandomNumberGenerate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRandomNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length < 3) {
      final number = rand.nextInt(maxNumber);

      newNumbers.add(number);
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreen();
        },
      ),
    );

    if(result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({
    super.key,
    required this.onPressed,
  });

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
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({
    super.key,
    required this.randomNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: randomNumbers
              .asMap()
              .entries
              .map(
                (nums) => Padding(
                  padding: EdgeInsets.only(
                    bottom: nums.key == 2 ? 0 : 16.0,
                  ),
                  child: Row(
                    children: nums.value
                        .toString()
                        .split('')
                        .map(
                          (num) => Image.asset(
                            'asset/img/$num.png',
                            width: 50.0,
                            height: 70.0,
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        child: Text(
          '생성하기!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
