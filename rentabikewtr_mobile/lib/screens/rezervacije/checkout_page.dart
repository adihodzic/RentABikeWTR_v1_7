import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak5bic_screen.dart';
//import 'package:thirtysix_app/services/stripe_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/bicikli.dart';

//import 'bicikli/bicikli_list_screen.dart';

// //import 'package:flutter/webview_flutter/webview_flutter.dart';
// class CheckoutPage extends StatefulWidget {
//   static const String routeName = "/checkout_payment_intent";
//   String? sesijaId;
//   //String? argumentsPay;
//   CheckoutPage({Key? key}) : super(key: key);

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//         "Payment Checkout",
//         style: TextStyle(fontSize: 20),
//       )),
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             var items = [
//               {"productPrice": 4, "productName": "Apple", "qty": 4},
//               {"productPrice": 5, "productName": "PineApple", "qty": 5},
//             ];
//             await StripeService.stripePaymentCheckout(
//                 items, 500, context, mounted, onSuccess: () {
//               print("SUCCESS");
//             }, onCancel: () {
//               print("Cancel");
//             }, onError: (e) {
//               print("Error" + e.toString());
//             });
//           },
//           style: TextButton.styleFrom(
//               backgroundColor: Colors.teal,
//               onSurface: Colors.white,
//               shape: BeveledRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(1)),
//               )),
//           child: Text("Checkout"),
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////
class CheckoutPage extends StatefulWidget {
  static const String routeName = "/checkout_payment_intent";
  String? sesId;
  // Bicikli? argumentsBic;
  CheckoutArguments args;
  CheckoutPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
                    context, RezervacijaKorak5bicScreen.routeName,
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