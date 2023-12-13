import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final List<StatAndStatusModel> models;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: MainCard(
        backgroundColor: lightColor,
        // LayoutBuilder: 현재 화면에 보이는 위젯의 크기를 알수있게 해줌
        child: LayoutBuilder(builder: (context, constraint) {
          final double width = constraint.maxWidth / 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          cateogry: DataUtils.getItemCodeKrString(itemCode: model.itemCode),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat: '${model.stat.getLevelFromRegion(region)}${DataUtils.getUnitFromDataType(itemCode: model.itemCode)}',
                          width: width,
                        ),
                      )
                      .toList(),
                  // children: List.generate(
                  //   6,
                  //   (index) => MainStat(
                  //     cateogry: '미세먼지 $index',
                  //     imgPath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎍/m³',
                  //     width: width,
                  //   ),
                  // ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
