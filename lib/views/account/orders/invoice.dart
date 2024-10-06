import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../services/server.dart';

class PaymentInvoice extends StatelessWidget {
  const PaymentInvoice({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Receipt'),
      body: WebViewWidget(
        controller: WebViewController()
          ..canGoBack()
          ..canGoForward()
          ..loadRequest(Uri.parse('$protocol$baseUrl/receipt/$orderId'))
          ..setJavaScriptMode(JavaScriptMode.unrestricted),
      ),
    );
  }
}
