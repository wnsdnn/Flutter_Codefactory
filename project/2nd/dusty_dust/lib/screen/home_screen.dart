import 'package:dusty_dust/container/category_card.dart';
import 'package:dusty_dust/container/hourly_card.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/const/regions.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  // Future<Map<ItemCode, List<StatModel>>> fetchData() async {
  //   Map<ItemCode, List<StatModel>> stats = {};
  //   List<Future> futures = [];
  //
  //   for (ItemCode itemCode in ItemCode.values) {
  //     final Future<List<StatModel>> response = StatRepository.fetchData(
  //       itemCode: itemCode,
  //     );
  //     futures.add(response);
  //   }
  //   // List<Future> 타입 안에 있는 Future에 값들이 한번에 호출됨
  //   final results = await Future.wait(futures);
  //
  //   for (int i = 0; i < results.length; i++) {
  //     final key = ItemCode.values[i];
  //     final value = results[i];
  //
  //     stats.addAll({key: value});
  //   }
  //
  //   return stats;
  // }


  Future<void> fetchData() async {
    final now = DateTime.now();
    final fetchTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final box = Hive.box<StatModel>(ItemCode.PM10.name);
    final recent = box.values.last as StatModel;

    if(recent.dataTime.isAtSameMomentAs(fetchTime)) {
      print('이미 최신 데이터가 있습니다.');
      return;
    }

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      final Future<List<StatModel>> response = StatRepository.fetchData(
        itemCode: itemCode,
      );

      futures.add(response);
    }

    // List<Future> 타입 안에 있는 Future에 값들이 한번에 호출됨
    final results = await Future.wait(futures);

    // Hive에 데이터 넣기
    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];  // ItemCode
      final value = results[i];  // List<StatModel>
      final box = Hive.box(key.name);

      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }

      final allKeys = box.keys.toList();

      if(allKeys.length > 24) {
        // start - 시작 인덱스
        // end - 끝 인덱스
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
        // box - valueListenable에서 설정해놓은 Box 객체가 반환됨

        // if(box.values.isEmpty) {
        //   return Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }

        final recentStat = box.values.toList().last as StatModel;

        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            darkColor: status.darkColor,
            lightColor: status.lightColor,
            selectedRegion: region,
            onRegionTap: (region) {
              setState(() {
                this.region = region;
                Navigator.of(context).pop();
              });
            },
          ),
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  status: status,
                  stat: recentStat,
                  region: region,
                  isExpanded: isExpanded,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(height: 16.0),
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
                      ).toList(),
                      const SizedBox(height: 16.0),
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
