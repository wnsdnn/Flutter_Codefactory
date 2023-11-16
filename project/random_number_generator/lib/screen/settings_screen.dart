import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: maxNumber.toInt()
                      .toString()
                      .split('')
                      .map(
                        (e) => Image.asset(
                          'asset/img/$e.png',
                          width: 50.0,
                          height: 70.0,
                        ),
                      )
                      .toList(),
                ),
              ),
              Slider(
                value: maxNumber,
                min: 1000,
                max: 100000,
                onChanged: (value) {
                  // Slider는 버튼의 위치를 혼자서 못 바꿔줘서
                  // value에다가 값을 넣어준뒤 다시 빌드 해줘야 버튼이 움직인다.
                  setState(() {
                    maxNumber = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // pop - 맨 마지막 화면 없애기
                  Navigator.of(context).pop(maxNumber.toInt());
                },
                style: ElevatedButton.styleFrom(
                  primary: RED_COLOR,
                ),
                child: Text('저장!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
