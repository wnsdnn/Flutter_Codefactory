import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    super.key,
    required this.color,
  }) {
    print('Widget Constructor 실행!');
  }

  @override
  State<HomeScreen> createState() {
    print('createState 실행!');

    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  @override
  void initState() {
    super.initState();

    print('initState 실행!');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('didChangeDepndencies 실행!');
  }

  @override
  void deactivate() {
    print('deactivate 실행!');

    super.deactivate();
  }

  @override
  void dispose() {
    print('despose 실행!');

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    print('didUpdateWidget 실행!');

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('build 실행!');

    return GestureDetector(
      onTap: () {
        setState(() {
          print('setState 실행!');
          number++;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(
          child: Text(number.toString()),
        ),
      ),
    );
  }
}
