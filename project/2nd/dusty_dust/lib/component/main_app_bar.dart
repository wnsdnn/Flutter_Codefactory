import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight;
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      expandedHeight: 500,
      backgroundColor: primaryColor,
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
                  '서울',
                  style: ts.copyWith(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  'asset/img/good.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20.0),
                Text(
                  '좋음',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '나쁘지 않네요!',
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
