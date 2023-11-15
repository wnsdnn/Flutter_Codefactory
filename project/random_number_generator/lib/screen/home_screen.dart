import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [2274, 5926, 1560];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
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
      newNumbers.add(rand.nextInt(10000));
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        IconButton(
          iconSize: 25.0,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
          onPressed: () {},
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
            child: Row(
              children: number
                  .toString()
                  .split('')
                  .map((num) => Image.asset(
                        'asset/img/$num.png',
                        height: 65.0,
                        width: 45.0,
                      ))
                  .toList(),
            ),
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
