
enum ItemCode {
  // 미세먼지
  PM10,
  // 초미세먼지
  PM25,
  // 이산화질소
  NO2,
  // 오존
  O3,
  // 일산화탄소
  CO,
  // 이황산가스
  SO2,
}

class StatModel {
  final double daegu;
  final double chungnam;
  final double incheon;
  final double daejeon;
  final double gyeongbuk;
  final double sejong;
  final double gwangju;
  final double jeonbuk;
  final double gangwon;
  final double ulsan;
  final double jeonnam;
  final double seoul;
  final double busan;
  final double jeju;
  final double chungbuk;
  final double gyeongnam;
  final double gyeonggi;
  final DateTime dataTime;
  final ItemCode itemCode;



  // JSON형태로부터 데이터를 받아온다.
  StatModel.fromJson({required Map<String, dynamic> json})
    :
      daegu = double.parse(json['daegu'] ?? '0'),
      chungnam = double.parse(json['chungnam'] ?? '0'),
      incheon = double.parse(json['incheon'] ?? '0'),
      daejeon = double.parse(json['daejeon'] ?? '0'),
      gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
      sejong = double.parse(json['sejong'] ?? '0'),
      gwangju = double.parse(json['gwangju'] ?? '0'),
      jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
      gangwon = double.parse(json['gangwon'] ?? '0'),
      ulsan = double.parse(json['ulsan'] ?? '0'),
      jeonnam = double.parse(json['jeonnam'] ?? '0'),
      seoul = double.parse(json['seoul'] ?? '0'),
      busan = double.parse(json['busan'] ?? '0'),
      jeju = double.parse(json['jeju'] ?? '0'),
      chungbuk = double.parse(json['chungbuk'] ?? '0'),
      gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
      gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
      dataTime = DateTime.parse(json['dataTime']),
      itemCode = parseItemCode(json['itemCode']);


  static ItemCode parseItemCode(String raw) {
    if(raw == 'PM2.5') {
      return ItemCode.PM25;
    }

    // firstWhere - 루프에서 첫번째로 맞는 값이 있으면 리턴후 루프 종료
    return ItemCode.values.firstWhere((element) => element.name == raw);
  }


  double getLevelFromRegion(String region) {
    if(region == '서울') {
      return this.seoul;
    } else if(region == '경기') {
      return this.gyeonggi;
    } else if(region == '대구') {
      return this.daegu;
    } else if(region == '충남') {
      return this.chungnam;
    } else if(region == '인천') {
      return this.incheon;
    } else if(region == '대전') {
      return this.daejeon;
    } else if(region == '경북') {
      return this.gyeongbuk;
    } else if(region == '광주') {
      return this.gwangju;
    } else if(region == '전북') {
      return this.jeonbuk;
    } else if(region == '강원') {
      return this.gangwon;
    } else if(region == '울산') {
      return this.ulsan;
    } else if(region == '전남') {
      return this.jeonnam;
    } else if(region == '부산') {
      return this.busan;
    } else if(region == '제주') {
      return this.jeju;
    } else if(region == '충북') {
      return this.chungbuk;
    } else if(region == '경남') {
      return this.gyeongnam;
    } else {
      throw Exception('알수 없는 지역입니다.');
    }
  }
}
