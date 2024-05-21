import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak5bic_screen.dart';
//import 'package:thirtysix_app/services/stripe_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/checkoutTrArguments.dart';
import 'rezervacija_korak5tr_screen.dart';

////////////////////////////////////////////////////////////////////////
class CheckoutTrPage extends StatefulWidget {
  static const String routeName = "/checkout_tr_payment_intent";
  String? sesId;
  CheckoutTrArguments args;
  CheckoutTrPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CheckoutTrPage> createState() => _CheckoutTrPageState();
}

class _CheckoutTrPageState extends State<CheckoutTrPage> {
  WebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
            initialUrl: initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webviewController) =>
                _webViewController = webviewController,
            onPageFinished: (String url) {
              //<---- add this
              if (url == initialUrl) {
                _redirectToStripe(widget.args.sessionId);
              }
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://example.com')) {
                Navigator.pushNamed(
                    context, RezervacijaKorak5trScreen.routeName,
                    arguments: widget.args);

                // Navigator.of(context)
                //     .pop('success'); // <-- Handle success case
              } else if (request.url.startsWith('https://cancel.com')) {
                Navigator.of(context).pop('cancel');
                // <-- Handle cancel case
              }
              return NavigationDecision.navigate;
            }));
  }

// $apiKey ispod je ustvari PublishableKey kojeg je on snimio u dart file
//To sam mogao i ja staviti u util.dart
  void _redirectToStripe(sesId) {
    //<--- prepare the JS in a normal string
    final redirectToCheckoutJs = '''
var stripe = Stripe(\'pk_test_51NDWrCFgNQXat14ZALPUUNLEwB7tf3ByFuIp7fjjgX9fPtm7bcWkK6zWsaiHsE1zRWywqzcOnLj27Z1U6MKgkXxV00fY3XOvkl'\); 
 
    
stripe.redirectToCheckout({
  sessionId: '${widget.args.sessionId}'
}).then(function (result) {
  result.error.message = 'Error'
});
''';
    _webViewController?.evaluateJavascript(
        redirectToCheckoutJs); //<--- call the JS function on controller
  }
}

String get initialUrl => 'https://adihodzic.github.io/index.html';// 