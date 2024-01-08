import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/model/status_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StatModel stat;
  final String region;

  MainAppBar({
    super.key,
    required this.status,
    required this.stat,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight;
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      expandedHeight: 500,
      backgroundColor: status.primaryColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: appBarHeight,
            ),
            child: Column(
              children: [
                Text(
                  region,
                  style:
                      ts.copyWith(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.0),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20.0),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  status.comment,
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
