import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiwaliOffersHomePage extends StatefulWidget {
  @override
  _DiwaliOffersHomePageState createState() => _DiwaliOffersHomePageState();
}

class _DiwaliOffersHomePageState extends State<DiwaliOffersHomePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript for interactivity
      ..setBackgroundColor(const Color(0xFFFFFFFF)) // Set white background
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {
            debugPrint("Page started loading: $url");
          },
          onPageFinished: (String url) {
            debugPrint("Page finished loading: $url");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Error: ${error.description}");
          },
        ),
      )
      ..loadFlutterAsset('assets/diwali_home.html'); // Load the local Diwali homepage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diwali Offers Home 🎇")),
      body: WebViewWidget(controller: _controller), // Display WebView
    );
  }
}

