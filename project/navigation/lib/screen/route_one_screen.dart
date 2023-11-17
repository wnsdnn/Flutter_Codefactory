import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteOneScreen extends StatefulWidget {
  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  State<RouteOneScreen> createState() => _RouteOneScreenState();
}

class _RouteOneScreenState extends State<RouteOneScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
      ],
    );
  }
}
