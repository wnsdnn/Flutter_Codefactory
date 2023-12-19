import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
  final int number;

  const NumberRow({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number.toString().split('').map(
            (number) {
          return Image.asset(
            'asset/img/$number.png',
            width: 50.0,
            height: 70.0,
          );
        },
      ).toList(),
    );
  }
}
