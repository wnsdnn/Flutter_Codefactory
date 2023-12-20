import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


final homeUrl = Uri.parse('https://wnsdnn.github.io');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()..loadRequest(homeUrl);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Wnsdnn Blog',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUrl);
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      )
    );
  }
}
