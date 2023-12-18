import 'package:flutter/material.dart';
import 'package:tabbar_theory/screen/appbar_using_controller.dart';
import 'package:tabbar_theory/screen/basic_appbar_tabbar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BasicAppbarTabbarScreen();
                      },
                    ),
                  );
                },
                child: Text('Basic AppBar TabBar Screen'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AppBarUsingController();
                      },
                    ),
                  );
                },
                child: Text('Appbar Using Controller'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
