import 'package:flutter/material.dart';

class EventListDetail extends StatefulWidget {
  const EventListDetail({super.key});

  @override
  State<EventListDetail> createState() => _EventListDetailState();
}

class _EventListDetailState extends State<EventListDetail> {
  int count = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                Text(
                  'Event Details',
                  style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 50.0,
                ),
                // Main Container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'WorldSkills Competition 2022 Special Edition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'view counts: ${count}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Image.asset(
                                      'asset/img/Logo_WS_Lyon2024_Black_RGB-1.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Image.asset(
                                      'asset/img/Logo_WS_Lyon2024_Black_RGB-1.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Image.asset(
                                      'asset/img/Logo_WS_Lyon2024_Black_RGB-1.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          'This year, 61 international skill competitions will take place across Europe, North America, and East Asia from September to November 2022.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 17.0
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
