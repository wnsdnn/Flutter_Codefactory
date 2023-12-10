import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        color: lightColor,
        // LayoutBuilder: 현재 화면에 보이는 위젯의 크기를 알수있게 해줌
        child: LayoutBuilder(
          builder: (context, constraint) {
            final double width = constraint.maxWidth / 3;

            return Column(
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
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: List.generate(
                      6,
                      (index) => MainStat(
                        cateogry: '미세먼지 $index',
                        imgPath: 'asset/img/best.png',
                        level: '최고',
                        stat: '0㎍/m³',
                        width: width,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
