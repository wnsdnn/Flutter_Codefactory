import 'package:flutter/material.dart';
import 'package:scroll_widgets/layout/main_layout.dart';
import 'package:scroll_widgets/screen/grid_view_screen.dart';
import 'package:scroll_widgets/screen/list_view_screen.dart';
import 'package:scroll_widgets/screen/reorderable_list_view_screen.dart';
import 'package:scroll_widgets/screen/single_child_scroll_view_screen.dart';

// 데이터 모델
class ScreenModel {
  final WidgetBuilder builder;
  final String name;

  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
        builder: (_) => SingleChildScrollViewScreen(),
        name: 'SingleChildScrollViewScreen'),
    ScreenModel(builder: (_) => ListViewScreen(), name: 'ListViewScreen'),
    ScreenModel(builder: (_) => GridViewScreen(), name: 'GridViewScreen'),
    ScreenModel(builder: (_) => ReorderableListViewScreen(), name: 'ReorderableListViewScreen'),
  ];

  HomeScreen({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens.map((screenInfo) {
              return ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: screenInfo.builder));
                },
                child: Text(
                  screenInfo.name,
                  style: textStyle,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
