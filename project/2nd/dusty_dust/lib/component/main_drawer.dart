import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/regions.dart';
import 'package:flutter/material.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;

  MainDrawer({
    super.key,
    required this.onRegionTap,
    required this.selectedRegion,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...regions
              .map(
                (area) => ListTile(
                  onTap: () {
                    onRegionTap(area);
                  },
                  title: Text(area),
                  tileColor: Colors.white,
                  selected: area == selectedRegion,
                  selectedColor: Colors.black,
                  selectedTileColor: lightColor,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
