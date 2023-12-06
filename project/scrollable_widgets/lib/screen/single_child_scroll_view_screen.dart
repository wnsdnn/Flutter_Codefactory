import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(),
    );
  }

  // 1. 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (color) => renderContainer(
                color: color,
              ),
            )
            .toList(),
      ),
    );
  }

  // 2. 화면이 넘어가지 않아도 스크롤 되게하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3. 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4. 여러가지 physice 정리
  Widget renderPhysice() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      // AlwaysScrollableScrollPhysics - 스크롤 됨
      // BouncingScrollPhysics - iOS 스타일
      // ClampingScrollPhysics - Android 스타일
      physics: ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (color) => renderContainer(
                color: color,
              ),
            )
            .toList(),
      ),
    );
  }


  // 5. SingleChildScorllView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        )
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if(index != null) {
      // print(index);
    }

    return Container(
      height: 300.0,
      color: color,
    );
  }
}
