import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments: ${arguments}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return RouteThreeScreen();
            //     },
            //   ),
            // );
            Navigator.of(context).pushReplacementNamed(
              '/three',
            );
          },
          child: Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) {
                  return RouteThreeScreen();
                },
              ),
              // route name이 '/'일때만 true '/' 아니면 삭제
              // [HomeScreen() [O], RouteOneScreen() [X], RouteTwoScreen() [X], RouteThreeScreen() [X]]
              (route) => route.settings.name ==  '/',
            );
          },
          child: Text('Push And Remove Until'),
        ),
      ],
    );
  }
}
