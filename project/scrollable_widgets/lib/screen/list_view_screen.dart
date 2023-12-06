import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // 1
  // 기본 - 모두 한번에 그림
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
    );
  }


  // 2
  // 보이는것만 그림
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


  // 3
  // 2번 + 아이템 사이에 추가할 위젯 넣을수 있음
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        index++;

        // 5개의 item마다 배너 보여주기
        if(index % 5 == 0) {
          return renderContainer(
              color: Colors.black,
              index: index,
              height: 100.0
          );
        }

        return Container();
      },
    );
  }


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
