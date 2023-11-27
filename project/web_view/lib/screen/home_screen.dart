import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wnsdnn Blog'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
