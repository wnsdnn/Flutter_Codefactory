import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppBarUsingController extends StatefulWidget {
  const AppBarUsingController({super.key});

  @override
  State<AppBarUsingController> createState() => _AppBarUsingControllerState();
}

class _AppBarUsingControllerState extends State<AppBarUsingController>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      // TickerProviderStateMixin을 with 해줘서 this를 적어주면 됨
      vsync: this,
    );

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
                      if (tabController.index != TABS.length - 1)
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
