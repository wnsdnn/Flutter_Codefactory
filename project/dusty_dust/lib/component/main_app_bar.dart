import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget {
  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500.0,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              // 시스템에서 앱바에 지정해주는 기본 height값을 가져올수 있음
                top: kToolbarHeight
            ),
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  'asset/img/mediocre.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20.0),
                Text(
                  '보통',
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
