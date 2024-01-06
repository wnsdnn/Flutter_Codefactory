import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;

  MainCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightColor,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: child,
    );
  }
}
