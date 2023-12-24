import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
  final int rowNumber;

  const NumberRow({
    super.key,
    required this.rowNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: rowNumber
          .toString()
          .split('')
          .map(
            (e) => Image.asset(
              'asset/img/$e.png',
              width: 50.0,
              height: 70.0,
            ),
          )
          .toList(),
    );
  }
}
