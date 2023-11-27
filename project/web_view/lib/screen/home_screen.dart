import 'package:flutter/material.dart';

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
        title: Text('Wnsdnn Blog'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
