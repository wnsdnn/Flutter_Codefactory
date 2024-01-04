import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_widgets/const/colors.dart';
import 'package:scroll_widgets/layout/main_layout.dart';

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

  // 1
  // 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  // ===================================================

  // 2
  // 화면을 넘어가지 않아도 스크롤되게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // ===================================================

  // 3
  // 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // ===================================================

  // 4
  // 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      // AlwaysScrollableScrollPhysics - 스크롤 됨
      // BouncingScrollPhysics - iOS 스타일
      // ClampingScrollPhysics - Android 스타일
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }


  // ===================================================


  // 5
  // SingleChildScrollView 퍼포먼스
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

  // ===================================================


  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if(index != null) {
      print(index);
    }

    return Container(
      height: 300.0,
      color: color,
    );
  }
}
