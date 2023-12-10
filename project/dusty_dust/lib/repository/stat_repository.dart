import 'package:dio/dio.dart';
import 'package:dusty_dust/const/data.dart';
import 'package:dusty_dust/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData() async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK'
      },
    );

    final items = response.data['response']['body']['items'];

    return items.map<StatModel>( (item) => StatModel.fromJson(json: item) ).toList();
  }
}