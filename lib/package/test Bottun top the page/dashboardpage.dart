// // ignore_for_file: avoid_print
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
// import 'package:http/http.dart' as http;
//
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () async {
//               await   mackPayment();
//             },
//
//             child: Container(
//               height: 51,
//               width: 200,
//               decoration: const BoxDecoration(
//                 color: Colors.amberAccent,
//
//               ),
//               child: Center(
//                 child: AStx('Pay'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Map<String,dynamic>?  paymentIntentData;
//
//
//   Future<void> mackPayment() async {
//     try {
//       paymentIntentData =await createPaymentIntent('52','USD');
//       await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntentData!['client_secret'],
//         applePay: true,
//         googlePay: true,
//         style: ThemeMode.dark,
//         merchantCountryCode: 'US',
//         merchantDisplayName: 'ASIF',
//
//       ),);
//     } catch (e) {
//       print('exception' + e.toString());
//     }
//   }
//
//   displayPaymentShee() async{
//
//     try{
//     await  Stripe.instance.presentPaymentSheet(
//         parameters: PresentPaymentSheetParameters(
//             clientSecret: paymentIntentData!['client_secret'],
//             confirmPayment: true,
//           )
//       );
//
//       setState(() {
//         paymentIntentData = null ;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: AStx('Paid successfully'),
//       ));
//
//
//     }on StripeException catch(e){
//       print('exception' + e.toString());
//       showDialog<void>(
//         context: context,
//         // barrierDismissible: barrierDismissible,
//         // false = user must tap button, true = tap outside dialog
//         builder: (BuildContext dialogContext) {
//           return AlertDialog(
//             title: AStx('Not Pay'),
//             content: AStx('Cancelled'),
//             actions: <Widget>[
//               FlatButton(
//                 child: AStx('buttonText'),
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop(); // Dismiss alert dialog
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try{
//       Map<String,dynamic> body={
//         'amount': calculateAmount(amount),
//         'currency':currency,
//         'Payment_method_type[]':'card'
//       };
//       var response =await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
//
//           body: body,
//           headers: {
//             'Authorization': 'Bearer sk_test_51L3li7ACwSiydFk9b7yI3pVEaHenD7SawR0iZUg97rUIk1Qyfatg7fUpAGbIK67nNpqf6M2Sz77wMZn125hvnMMx00LM2aQGuN',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           }
//       );
//
//       return jsonDecode(response.body.toString());
//     }catch(e){
//       print('exception' + e.toString());
//     }
//   }
//
//   calculateAmount(String amount) {
//     final price=int.parse(amount)*100;
//     return price.toString();
//   }
//
// }

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  var response;
  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      print('paymentIntentData ${paymentIntentData!.length }' );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));

        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
     await Stripe.instance.presentPaymentSheet();

      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      //هون بكتب الكود الي بعد ما ينجح الدفع راح يتنفذ
      print('is secssesed  sami   ');
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
        response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L3li7ACwSiydFk9b7yI3pVEaHenD7SawR0iZUg97rUIk1Qyfatg7fUpAGbIK67nNpqf6M2Sz77wMZn125hvnMMx00LM2aQGuN',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      print('Start');
      print('response   =  ${response.statusCode}');
      print(jsonDecode(response.body));
      print('End');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    double a = (double.parse(amount)) * 100;
    print('a == $a');
    int b = a.round();
    print('b == $b');
    return b.toString();
  }
  getResponse(){
    return response.body;
  }
}

/*
id: pi_3L41u8ACwSiydFk904hRzfWy,
 object: payment_intent,
  amount: 9985,
   amount_capturable: 0,
    amount_details: {tip: {}},
     amount_received: 0,
      application: null,
       application_fee_amount: null,
        automatic_payment_methods: null,
         canceled_at: null, cancellation_reason: null,
          capture_method: automatic,
           charges: {object: list, data: [], has_more: false, total_count: 0, url: /v1/charges?payment_intent=pi_3L41u8ACwSiydFk904hRzfWy},
           client_secret: pi_3L41u8ACwSiydFk904hRzfWy_secret_ujXf2ZInomEo3sm1zw0Lf0Hct,
            confirmation_method: automatic,
            created: 1653653072,
             currency: usd,
              customer: null,
               description: null,
                invoice: null,
                 last_payment_error: null,
                  livemode: false,
                   metadata: {},
                    next_action: null,
                     on_behalf_of: null,
                      payment_method: null,
                       payment_method_options: {card: {installments: null, mandate_options: null, network: null, request_three_d_secure: automatic}},
                        payment_method_types: [card],
                         processing: null,
                         receipt_email: null,
                          review: null,
                          setup_future_usage: null,
                           shipping: null,
                           source: null,
                            statement_descripto
 */

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed: () => paymentController.makePayment(
                    amount: '10', currency: 'USD'),
                child: AStx('make payment 10')),
            ElevatedButton(
                onPressed: () => paymentController.makePayment(
                    amount: '99.85', currency: 'USD'),
                child: AStx('make payment 99.8')),
            ElevatedButton(onPressed: (){
              print(paymentController.getResponse().toString());
            }, child: AStx('detiles')),
          ],
        ),
      ),
    );
  }
}
