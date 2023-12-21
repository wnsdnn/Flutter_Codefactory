import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    super.key,
    required this.color,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          color: widget.color,
        ),
      ),
    );
  }
}
