import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1번 형태
    // DefaultTabController - 이걸쓰면 controller 따로 지정안해줘도 됨
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("BasicAppbarTabbarScreen"),
          bottom: PreferredSize(
            // PreferredSize - 이거쓰면 child 값에 다른 값들이랑 같이 쓸수 있음
            preferredSize: Size.fromHeight(80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  // controller 필수
                  indicatorColor: Colors.red,
                  indicatorWeight: 1.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  labelColor: Colors.yellow,
                  unselectedLabelColor: Colors.green,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: TABS
                      .map(
                        (e) => Tab(
                      icon: Icon(e.icon),
                      child: Text(
                        e.label,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          // NeverScrollableScrollPhysics - 이거 쓰면 스와이프 기능 안됨
          // physics: NeverScrollableScrollPhysics(),
          children: TABS
              .map(
                (e) => Center(
                  child: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
