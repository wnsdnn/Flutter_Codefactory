import 'package:flutter/material.dart';
import 'package:scroll_widgets/const/colors.dart';
import 'package:scroll_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderMaxExtent(),
    );
  }

  // ===================================================

  // 1
  // 한번에 다 그림!
  Widget renderCount() {
    return GridView.count(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
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
  // 보이는것만 그림
  Widget renderBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
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
  // 최대사이즈
  Widget renderMaxExtent() {
    return GridView.builder(
      // grid 아이템들의 최대 길이를 자동으로 세팅
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 100, // 개수도 지정가능
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
