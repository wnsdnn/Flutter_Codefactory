import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../component/main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: MainCard(
        backgroundColor: lightColor,
        // LayoutBuilder: 현재 화면에 보이는 위젯의 크기를 알수 있게 해줌
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
                  children: ItemCode.values
                      .map(
                        (ItemCode itemCode) => ValueListenableBuilder<Box>(
                          valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
                          builder: (context, box, widget) {
                            final stat = box.values.last as StatModel;
                            final status = DataUtils.getStatusFromItemCodeAndValue(
                                value: stat.getLevelFromRegion(region),
                                itemCode: itemCode
                            );

                            return MainStat(
                              cateogry: DataUtils.getItemCodeKrString(itemCode: itemCode),
                              imgPath: status.imagePath,
                              level: status.label,
                              stat: '${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromDataType(itemCode: itemCode)}',
                              width: width,
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
