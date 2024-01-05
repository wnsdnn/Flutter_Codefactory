import 'package:flutter/material.dart';
import 'package:scroll_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          renderSliverAppbar(),
          // renderChildSliverList(),
          // renderBuilderSliverList(),
          // renderChildSliverGrid(),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }

  // ===================================================

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤 했을때 리스트의 중간에도 Appbar가 내려오게 할수 있음.
      floating: true,
      // 스크롤 했을때 완전고정
      pinned: false,
      // 자석효과
      // floating이 true일때만 쓸수 있음
      snap: true,
      // 맨위, 맨 마지막에서 한계의 이상으로 스크롤 했을때
      // 남는 공간을 차지
      stretch: true,
      // 앱바 최대 사이즈
      expandedHeight: 200,
      // 앱바 최소 사이즈
      collapsedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpace'),
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: Colors.blue,
      title: Text(
        'CustomScrollViewScreen',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
  }

  // ===================================================

  // ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
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

  // ListView.builder 생성자와 유사함.
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
    );
  }

  // ===================================================

  // GridView.count와 유사함.
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildListDelegate(
        numbers
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

  // GridView.builder와 유사함.
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        ),
        childCount: 100,
      ),
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
