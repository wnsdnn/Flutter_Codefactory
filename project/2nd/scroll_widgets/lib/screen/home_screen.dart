import 'package:flutter/material.dart';
import 'package:scroll_widgets/layout/main_layout.dart';
import 'package:scroll_widgets/screen/single_child_scroll_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      primary: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
    final textStyle = TextStyle(
      color: Colors.white,
    );

    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => SingleChildScrollViewScreen()),
                );
              },
              child: Text(
                'SingleChildScrollViewScreen',
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
