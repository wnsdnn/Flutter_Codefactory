import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
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
        ),
      ),
    );
  }
}
