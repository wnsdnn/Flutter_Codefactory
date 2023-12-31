import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({
    this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          number.toString(),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            // [HomeScreen(), RouteOneScreen(), RouteTwoScreen()]
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return RouteTwoScreen();
                },
                settings: RouteSettings(
                  arguments: 789
                )
              ),
            );
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}
