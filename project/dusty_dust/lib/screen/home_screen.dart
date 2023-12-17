import 'package:dusty_dust/container/category_card.dart';
import 'package:dusty_dust/container/hourly_card.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/const/regions.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    // utc기준으로 대한민국의 날짜는 9시간을 추가해줘야함
    final now = DateTime.now().toUtc().add(Duration(hours: 9));
    final fetchTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    // 가장 최신 데이터
    final box = Hive.box<StatModel>(ItemCode.PM10.name);
    final recent = box.values.last as StatModel;

    print(recent.dataTime);
    print(fetchTime);

    // isAtSameMomentAs - 같은 순간이냐 아니냐를 반환
    if(recent.dataTime.isAtSameMomentAs(fetchTime)) {
      print('이미 최신 데이터가 있습니다.');
      return;
    }


    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(itemCode: itemCode),
      );
    }

    // 리스트 안에 Furure값이 전부 들어가게 기다리기
    final results = await Future.wait(futures);

    // Hive에 데이터 넣기
    for (int i = 0; i < results.length; i++) {
      // ItemCode
      final key = ItemCode.values[i];
      // List<StatModel>
      final value = results[i];

      final box = Hive.box<StatModel>(key.name);

      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }

      final allKeys = box.keys.toList();

      if(allKeys.length > 24) {
        // stat = 시작 index
        // end = 끝 index
        // ['red', 'orange', 'yellow', 'green', 'blue']
        // .sublist(1, 3)
        // ['orange', 'yellow']
        final deleteKeys = allKeys.sublist(0, allKeys.length - 24);

        box.deleteAll(deleteKeys);
      }
    }
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        // PM10 (미세먼지)
        // box.values.toList().last
        final recentStat = box.values.toList().last as StatModel;

        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            selectedRegion: region,
            onRegionTap: (String region) {
              setState(() {
                this.region = region;
              });
              Navigator.of(context).pop();
            },
            darkColor: status.darkColor,
            lightColor: status.lightColor,
          ),
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppbar(
                  stat: recentStat,
                  status: status,
                  region: region,
                  dateTime: recentStat.dataTime,
                  isExpanded: isExpanded,
                ),

                // 일반위젯 사용하고 싶을때 사용
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      SizedBox(height: 16.0),
                      ...ItemCode.values.map(
                            (itemCode) {

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                              region: region,
                              itemCode: itemCode,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
