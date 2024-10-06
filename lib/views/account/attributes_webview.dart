import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AttributesWebView extends StatelessWidget {
  const AttributesWebView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: WebViewController()
            ..canGoBack()
            ..canGoForward()
            ..loadRequest(Uri.parse(url))
            ..setJavaScriptMode(JavaScriptMode.unrestricted),
        ),
        // WebView(
        //   initialUrl: url,
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebViewCreated: (controller) {
        //     controller.canGoBack();
        //   },
        // ),
      ),
    );
  }
}
