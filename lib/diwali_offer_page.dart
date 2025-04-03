import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiwaliOfferPage extends StatefulWidget {
  @override
  _DiwaliOfferPageState createState() => _DiwaliOfferPageState();
}

class _DiwaliOfferPageState extends State<DiwaliOfferPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript
      ..setBackgroundColor(const Color(0xFFFFFFFF)) // White background
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
      ..loadFlutterAsset('assets/diwali_offer.html'); // Load Diwali offer page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diwali Offers 🎇")),
      body: WebViewWidget(controller: _controller), // Display WebView
    );
  }
}

