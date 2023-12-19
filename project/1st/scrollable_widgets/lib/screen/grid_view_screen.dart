import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderBuilderCrossAxisCount(),
    );
  }

  // 1
  // 한번에 다그림
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 2, // 가로로 몇개 넣을건지
      crossAxisSpacing: 12.0, // 가로 간격
      mainAxisSpacing: 24.0, // 세로간격
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


  // 2
  // 보이는 것만 그림
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 가로로 몇개 넣을건지
        crossAxisSpacing: 12.0, // 가로 간격
        mainAxisSpacing: 24.0, // 세로간격
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 10, // 카운터 제한 가능
    );
  }


  // 3
  // 최대 사이즈 지정
  Widget renderMaxExtent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // 아이템들의 최대 길이
        maxCrossAxisExtent: 100,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 10, // 카운터 제한 가능
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
