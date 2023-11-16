import 'package:flutter/material.dart';
import 'package:random_number_generator2/component/number_row.dart';
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
            _Body(maxNumber: maxNumber),
            _Footer(
                maxNumber: maxNumber,
                SliderChangeEvt: OnSilderChanged,
                onButtonPressed: OnButtonPressed,
            )
          ],
        ),
      ),
    );
  }

  void OnSilderChanged(value) {
    setState(() {
      maxNumber = value;
    });
  }

  void OnButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({
    required this.maxNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: NumberRow(number: maxNumber.toInt()));
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged SliderChangeEvt;
  final VoidCallback onButtonPressed;

  const _Footer({
    required this.maxNumber,
    required this.onButtonPressed,
    required this.SliderChangeEvt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: SliderChangeEvt,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: RED_COLOR),
            onPressed: onButtonPressed,
            child: Text('저장!'),
          ),
        ),
      ],
    );
  }
}
