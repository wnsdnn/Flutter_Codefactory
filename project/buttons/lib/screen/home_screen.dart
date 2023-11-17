import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              onPressed: () {},
              // onPressed: null, // 비활성화 상태

              style: ButtonStyle(
                // MaterialStateProperty.all - 모든 상태에서 똑같이 적용
                // MaterialStateProperty.resolveWith - 상태에 따라 다르게 적용가능
                // Material State (총 8가지)
                //
                // hoverd - 호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 됐을때 (텍스트 필드)
                // pressed - 눌렸을때
                // dragged - 드래그 됐을떄
                // selected - 선택됐을떄 (체크박스, 라디오 버튼)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을때
                // disabled - 비활성화 됐을때
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if(states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }

                      return Colors.black;
                    }
                ),

                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      // 눌렸을때
                      if(states.contains(MaterialState.pressed)) {
                        return Colors.white;
                      }
                      return Colors.red; // null - 기본값
                    }
                ),

                padding: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if(states.contains(MaterialState.pressed)) {
                        return EdgeInsets.all(100.0);
                      }

                      return EdgeInsets.all(20.0);
                    }
                )
              ),
              child: Text('ButtonStyle'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  // primary: 메일 컬러
                  primary: Colors.red,
                  // 글자, 클릭시 애니메이션 컬러
                  onPrimary: Colors.black,

                  // 그림자 컬러
                  // shadowColor: Colors.green,
                  // 3D 입체감의 높이
                  elevation: 10.0,
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  padding: EdgeInsets.all(32.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 4.0, // 테두리 두께
                  )),
              child: Text(
                'ElevatedButton',
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  // onPrimary만 없고 다 똑같음
                  primary: Colors.green,
                  backgroundColor: Colors.yellow),
              child: Text('OutlinedButton'),
            ),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    primary: Colors.brown, backgroundColor: Colors.blue),
                child: Text('TextButton')),
          ],
        ),
      ),
    );
  }
}
