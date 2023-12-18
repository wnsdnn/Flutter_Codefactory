import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppBarUsingController extends StatefulWidget {
  const AppBarUsingController({super.key});

  @override
  State<AppBarUsingController> createState() => _AppBarUsingControllerState();
}

// TickerProviderStateMixin - 실제 1프레임당 틱이 움직이는걸 효율적으로 해줌
class _AppBarUsingControllerState extends State<AppBarUsingController>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      // TickerProviderStateMixin를 사용했기 때문에 this를 넣음
      vsync: this,
    );

    // tabController의 상태가 변경될떄마다 실행
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appbar Using Controller'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (e) => Tab(
                  icon: Icon(e.icon),
                  child: Expanded(
                    child: Text(e.label),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(e.icon),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tabController.index != 0)
                        ElevatedButton(
                          onPressed: () {
                            tabController.animateTo(
                              tabController.index - 1,
                            );
                          },
                          child: Text('이전'),
                        ),
                      SizedBox(width: 16.0),
                      if (tabController.index != TABS.length -1)
                        ElevatedButton(
                          onPressed: () {
                            tabController.animateTo(
                              tabController.index + 1,
                            );
                          },
                          child: Text('다음'),
                        ),
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
