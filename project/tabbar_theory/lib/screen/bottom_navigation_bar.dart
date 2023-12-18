import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
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
        title: Text('Bottom Navigation Bar'),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Center(
                child: Icon(e.icon),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        // 선택된 탭의 label을 보여줄건지
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: tabController.index,
        // 탭이 선택되었을때 효과
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          tabController.index = index;
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                ),
                label: e.label
              ),
            )
            .toList(),
      ),
    );
  }
}
