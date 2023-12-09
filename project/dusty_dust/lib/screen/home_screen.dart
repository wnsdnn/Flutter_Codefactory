import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppbar(),

          // 일반위젯 사용하고 싶을때 사용
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  color: lightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '종류별 통계',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MainStat(
                            cateogry: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎍/m³',
                          ),
                          MainStat(
                            cateogry: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎍/m³',
                          ),
                          MainStat(
                            cateogry: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎍/m³',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
