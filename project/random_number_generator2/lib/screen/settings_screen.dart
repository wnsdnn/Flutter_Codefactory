import 'package:flutter/material.dart';
import 'package:random_number_generator2/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: maxNumber.toInt().toString().split('').map(
                  (number) {
                    return Image.asset(
                      'asset/img/$number.png',
                      width: 50.0,
                      height: 70.0,
                    );
                  },
                ).toList(),
              ),
            ),
            Slider(
              value: maxNumber,
              min: 1000,
              max: 100000,
              onChanged: (value) {
                setState(() {
                  maxNumber = value;
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: RED_COLOR),
                onPressed: () {
                  Navigator.of(context).pop(maxNumber.toInt());
                },
                child: Text('저장!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
