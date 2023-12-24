import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              // onPressed가 null이면 버튼 비활성화 상태
              onPressed: () {},
              style: ButtonStyle(
                // MaterialState
                //
                // hovered - 호버링 상태 (마우스 커서를 올려놓은상태)
                // focused - 포커스 됐을때 (텍스트 필드)
                // pressed - 눌렸을때 (o)
                // dragged - 드래그됐을때
                // selected - 선택됐을때 (체크박스, 라이오 버튼)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을때
                // disabled - 비활성화 됐을때 (o)
                // error - 에러상태
                //
                // all - 모든상태에서
                // resolveWith - 특정상태에서
                backgroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }

                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }

                    return Colors.deepPurple;
                  },
                ),
                padding: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if(states.contains(MaterialState.pressed)) {
                      return EdgeInsets.all(50.0);
                    }

                    return EdgeInsets.all(15.0);
                  },
                ),
              ),
              child: Text('ButtonStyle'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // 메인 컬러
                primary: Colors.red,
                // 글자색, 눌렀을때 애니메이션 효과 색상
                onPrimary: Colors.black,
                shadowColor: Colors.green,
                // 3D 입체감의 높이
                elevation: 10,
                textStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              child: Text('ElevatedButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  backgroundColor: Colors.yellow,
                  elevation: 10.0,
                  shadowColor: Colors.black,
                  side: BorderSide(
                    color: Colors.transparent,
                  )),
              child: Text('OutlinedButton'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.brown,
                backgroundColor: Colors.blue,
              ),
              child: Text('TextButton'),
            ),
          ],
        ),
      ),
    );
  }
}
