import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: MainCard(
        child: LayoutBuilder(
          builder: (context, constraint) {
            // constraint 현재 감싸고 있는 위젯에서 minWidth, maxWidth 같은 값들을 가져올수 있음
            double cardWidth = constraint.maxWidth / 3;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
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
