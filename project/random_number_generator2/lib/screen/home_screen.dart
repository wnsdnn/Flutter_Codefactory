import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator2/constant/color.dart';
import 'package:random_number_generator2/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> NumberList = [
    2274,
    5926,
    1560,
  ];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '랜덤숫자 생성기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    color: RED_COLOR,
                    onPressed: () async {
                      final int? resultNumber = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SettingsScreen(maxNumber: maxNumber);
                          },
                        ),
                      );

                      if(resultNumber != null) {
                        maxNumber = resultNumber;
                      }
                    },
                    icon: Icon(Icons.settings),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: NumberList.asMap().entries.map(
                    (item) {
                      final index = item.key;
                      final value = item.value;

                      return Padding(
                        padding: EdgeInsets.only(bottom: index == 2 ? 0 : 16.0),
                        child: Row(
                          children: value.toString().split('').map(
                            (number) {
                              return Image.asset(
                                'asset/img/$number.png',
                                width: 50.0,
                                height: 70.0,
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: RED_COLOR,
                    ),
                    onPressed: () {
                      final rand = Random();
                      final Set<int> newNumbers = {};

                      while(newNumbers.length != 3) {
                        newNumbers.add(rand.nextInt(maxNumber));
                      }

                      setState(() {
                        NumberList = newNumbers.toList();
                      });
                    },
                    child: Text('생성하기!')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
