import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.red,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.green,
                ),
              ],
            ),
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.orange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.red,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.orange,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.green,
                ),
              ],
            ),
            Container(
              width: 50.0,
              height: 50.0,
              color: Colors.green,
            ),
          ],
        )
      ),
    );
  }
}
