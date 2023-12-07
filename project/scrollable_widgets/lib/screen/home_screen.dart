import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';
import 'package:scrollable_widgets/screen/custom_scroll_view_screen.dart';
import 'package:scrollable_widgets/screen/grid_view_screen.dart';
import 'package:scrollable_widgets/screen/list_view_screen.dart';
import 'package:scrollable_widgets/screen/reorderable_list_view_screen.dart';
import 'package:scrollable_widgets/screen/scrollbar_screen.dart';
import 'package:scrollable_widgets/screen/single_child_scroll_view_screen.dart';

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
      builder: (context) => SingleChildScrollViewScreen(),
      name: 'SingleChildScrollViewScreen',
    ),
    ScreenModel(
      builder: (context) => ListViewScreen(),
      name: 'ListViewScreen',
    ),
    ScreenModel(
      builder: (context) => GridViewScreen(),
      name: 'GridViewScreen',
    ),
    ScreenModel(
      builder: (context) => ReorderableListViewScreen(),
      name: 'ReorderableListView',
    ),
    ScreenModel(
      builder: (context) => CustomScrollViewScreen(),
      name: 'CustomeScrollViewScreen',
    ),
    ScreenModel(
      builder: (context) => ScrollbarScreen(),
      name: 'ScrollbarScreen',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens
                .map(
                  (screen) => ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: screen.builder
                        ),
                      );
                    },
                    child: Text(screen.name),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }


}
