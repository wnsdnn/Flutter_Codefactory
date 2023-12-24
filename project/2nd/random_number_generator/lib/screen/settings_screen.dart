import 'package:flutter/material.dart';
import 'package:random_number_generator/compontent/number_row.dart';
import 'package:random_number_generator/constant/colors.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({
    super.key,
    required this.maxNumber,
  });

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              _Body(
                maxNumber: maxNumber,
              ),
              _Footer(
                maxNumber: maxNumber,
                onButtonPressed: onButtonPressed,
                onSliderChanged: onSliderChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }

  void onSliderChanged(double value) {
    setState(() {
      maxNumber = value;
    });
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({
    super.key,
    required this.maxNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        rowNumber: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final VoidCallback onButtonPressed;
  final ValueChanged<double>? onSliderChanged;

  const _Footer({
    super.key,
    required this.maxNumber,
    required this.onButtonPressed,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              primary: RED_COLOR,
            ),
            child: Text(
              '저장!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
