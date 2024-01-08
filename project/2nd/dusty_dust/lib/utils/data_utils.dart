import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/model/status_model.dart';

class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${getTimeFormat(dateTime.month)}-${getTimeFormat(dateTime.day)} ${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }

  // 단위반환
  static String getUnitFromItemCode({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '㎍/㎥';
      case ItemCode.PM25:
        return '㎍/㎥';
      default:
        return 'ppm';
    }
  }

  // 국문이름 반환
  static String itemCodeStringKrString({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.SO2:
        return '아황산가스';
    }
  }

  static StatusModel getStatusFromItemCodeAndValue({
    required double value,
    required ItemCode itemCode,
}) {
    // 최소치보단 작은 것들 중에 젤 마지막 항목 가져오기
    return statusLevel.where(
          (level) {
            if(itemCode == ItemCode.PM10) {
              return level.minFineDust < value;
            } else if(itemCode == ItemCode.PM25) {
              return level.minUltraFineDust < value;
            } else if(itemCode == ItemCode.CO) {
              return level.minCO < value;
            } else if(itemCode == ItemCode.O3) {
              return level.minO3 < value;
            } else if(itemCode == ItemCode.NO2) {
              return level.minNO2 < value;
            } else if(itemCode == ItemCode.SO2) {
              return level.minSO2 < value;
            } else {
              throw Exception('알수없는 ItemCode입니다.');
            }
          },
    ).last;
  }
}
