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
  late TabController tabController;

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
        // label 값들 보이게 하기
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: tabController.index,
        // 탭바 선택시 확대 안시키기
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          tabController.animateTo(value);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
