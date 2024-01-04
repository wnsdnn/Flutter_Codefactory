import 'package:flutter/material.dart';
import 'package:scroll_widgets/const/colors.dart';
import 'package:scroll_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // ===================================================

  // 1
  // 모두 한번에 그림
  Widget renderDefault() {
    return ListView(
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


  // 2
  // 보이는 것만 그림
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }


  // ===================================================


  // 3
  // 2번 + 중간중간에 추가할 위젯 넣을수 있음
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: numbers.length,
      separatorBuilder: (context, index) {
        index += 1;

        if(index % 5 == 0) {
          return renderContainer(
              color: Colors.black,
              index: index,
              height: 50.0
          );
        }

        return Container();
      },
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
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
