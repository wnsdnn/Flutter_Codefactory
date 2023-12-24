import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: RED_COLOR,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [123, 456, 789]
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
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: RED_COLOR,
                  ),
                  child: Text(
                    '생성하기!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
