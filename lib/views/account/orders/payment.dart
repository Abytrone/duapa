import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.paymentUrl});
  final String paymentUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: appBar(context: context, title: 'Receipt'),
        body: WebViewWidget(
          controller: WebViewController()
            ..setNavigationDelegate(
              NavigationDelegate(
                // navigationDelegate: (NavigationRequest request) {
                //   if (request.url.startsWith(redirectUrl)) {
                //     // Extract query parameters from the URL
                //     Uri uri = Uri.parse(request.url);
                //     String status = uri.queryParameters['status'] ?? '';
                //     String txRef = uri.queryParameters['tx_ref'] ?? '';
                //     String transactionId =
                //         uri.queryParameters['transaction_id'] ?? '';

                //     // Handle payment status (success or failure)
                //     if (status == 'successful') {
                //       // Payment was successful, close the webview
                //       Navigator.of(context).pop();
                //     } else {
                //       // Handle other statuses if needed
                //       // Example: Show an error message
                //     }

                //     return NavigationDecision
                //         .prevent; // Prevent navigating to the redirect URL
                //   }

                //   return NavigationDecision.navigate; // Continue loading the URL
                // },
                onUrlChange: (change) {
                  // print(change.url);
                  if (change.url!.startsWith('https://con.duapa.online')) {
                    final Uri uri = Uri.parse(change.url!);
                    // print(uri.queryParameters);
                    final String status = uri.queryParameters['status']!;
                    if (status == 'successful') {
                      Navigator.of(context).pop(true);
                    } else {
                      Navigator.of(context).pop(false);
                    }
                    NavigationDecision.prevent;
                  }
                  NavigationDecision.navigate;
                },
              ),
            )
            ..canGoBack()
            ..canGoForward()
            ..loadRequest(Uri.parse(paymentUrl))
            ..setJavaScriptMode(JavaScriptMode.unrestricted),
        ),
      ),
    );
  }
}
