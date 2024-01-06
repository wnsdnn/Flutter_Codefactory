import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Card(
        color: lightColor,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraint) {
            // constraint 현재 감싸고 있는 위젯에서 minWidth, maxWidth 같은 값들을 가져올수 있음
            double cardWidth = constraint.maxWidth / 3;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '종류별 통계',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      20,
                      (index) => MainStat(
                        category: '미세먼지$index',
                        imgPath: 'asset/img/best.png',
                        level: '최고',
                        stat: '0㎍/㎥',
                        width: cardWidth,
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
