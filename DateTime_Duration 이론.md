# DateTime_Duration 이론

```
void main() {
  // 날짜
  DateTime now = DateTime.now();
  
  print(now);
  print(now.year);
  print(now.month);
  print(now.day);
  print(now.hour);
  print(now.minute);
  print(now.second);
  print(now.millisecond);
  print('');
  
  
  // 기간
  Duration duration = Duration(seconds: 60);
  print(duration);
  print(duration.inDays);
  print(duration.inHours);
  print(duration.inMinutes);
  print(duration.inSeconds);
  print(duration.inMilliseconds);
  print('');
  
  DateTime specificDays = DateTime(
    2017,
    11, 
    23
  );
  
  print(specificDays);
  print('');
  
  final difference = now.difference(specificDays);
  
  print(difference);
  print(difference.inDays);
  print(difference.inHours);
  print(difference.inMinutes);
  
  
  // 다음인지 아닌지 bool 값 리턴
  print(now.isAfter(specificDays));
  // 위에꺼 반대
  print(now.isBefore(specificDays));
  print('');
  
  print(now);
  // 더하기
  print(now.add(Duration(hours: 10)));
  // 빼기
  print(now.subtract(Duration(seconds: 20)));
}
```