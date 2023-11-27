import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


final homeUrl = Uri.parse('https://wnsdnn.github.io/');

class HomeScreen extends StatelessWidget {
  // .. => 뒤에 있는 메소드를 실행하기 하나 반환하는값은 실행한 함수의 대상(WebViewController)을 반환한다.
  WebViewController controller = WebViewController()
    ..loadRequest(homeUrl);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wnsdnn Blog'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUrl);
            },
            icon: Icon(
              Icons.home
            ),
          )
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
