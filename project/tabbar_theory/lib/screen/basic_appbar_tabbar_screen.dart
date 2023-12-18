import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorWeight: 4.0,
                    // tab - tab의 크기
                    // label - 글자의 크기
                    indicatorSize: TabBarIndicatorSize.tab,
                    // isScrollable: true,
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w300
                    ),
                    tabs: TABS
                        .map(
                          (e) => Tab(
                        icon: Icon(e.icon),
                        child: Text(
                          '${e.label}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          // 스와이프 기능 막기
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
