import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  CategoryCard({
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
        child: LayoutBuilder(builder: (context, constraint) {
          // constraint 현재 감싸고 있는 위젯에서 minWidth, maxWidth 같은 값들을 가져올수 있음
          double cardWidth = constraint.maxWidth / 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  physics: PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: ItemCode.values
                      .map(
                        (ItemCode itemCode) => ValueListenableBuilder<Box>(
                          valueListenable:
                              Hive.box<StatModel>(itemCode.name).listenable(),
                          builder: (context, box, widget) {
                            final stat = box.values.toList().last as StatModel;
                            final status =
                                DataUtils.getStatusFromItemCodeAndValue(
                              value: stat.getLevelFromRegion(region),
                              itemCode: itemCode,
                            );

                            return MainStat(
                              width: cardWidth,
                              level: status.label,
                              imgPath: status.imagePath,
                              category: DataUtils.getItemCodeStringKrString(
                                itemCode: itemCode,
                              ),
                              stat:
                                  '${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}',
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
