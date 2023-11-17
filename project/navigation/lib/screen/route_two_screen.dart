import 'package:flutter/material.dart';


class RouteTwoScreen extends StatefulWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  State<RouteTwoScreen> createState() => _RouteTwoScreenState();
}

class _RouteTwoScreenState extends State<RouteTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route Two'),
      ),
    );
  }
}
