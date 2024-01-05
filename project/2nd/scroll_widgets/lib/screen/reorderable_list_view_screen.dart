import 'package:flutter/material.dart';
import 'package:scroll_widgets/const/colors.dart';
import 'package:scroll_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            // oldIndex와 newIndex 모두 이동이 되기 전에 산정한다.

            // [red, ornage, yellow]
            // [0, 1, 2]
            //
            // red를 yellow 다음으로 옮기고싶다.
            // red : 0 oldIndex -> 3 newIndex (newIndex - 1 해줘야함)
            // [orange, yellow, red]

            // [red, orange, yellow]
            // yellow를 맨앞으로 옮기고싶다.
            // yellow : 2 oldIndex -> 0 newIndex
            // [yellow, red, orange]

            if (oldIndex < newIndex) {
              newIndex--;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        },
      ),
    );
  }

  // ===================================================

  Widget renderDefault() {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // oldIndex와 newIndex 모두 이동이 되기 전에 산정한다.

          // [red, ornage, yellow]
          // [0, 1, 2]
          //
          // red를 yellow 다음으로 옮기고싶다.
          // red : 0 oldIndex -> 3 newIndex (newIndex - 1 해줘야함)
          // [orange, yellow, red]

          // [red, orange, yellow]
          // yellow를 맨앞으로 옮기고싶다.
          // yellow : 2 oldIndex -> 0 newIndex
          // [yellow, red, orange]

          if (oldIndex < newIndex) {
            newIndex--;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
    );
  }

  // ===================================================

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      key: Key(index.toString()),
      height: height ?? 300.0,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
