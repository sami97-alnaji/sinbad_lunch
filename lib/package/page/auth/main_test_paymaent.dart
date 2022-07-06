// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'test pay Memento method',
//     theme: ThemeData(
//       primarySwatch: Colors.amber,
//     ),
//     home: const WebShow(),
//   ));
// }

// ignore: must_be_immutable
class WebShowPayMent extends StatefulWidget {
    WebShowPayMent({  required   this.total_amount, required   this.email,required   this.order_info_id,Key? key}) : super(key: key);
  String total_amount, email, order_info_id;
  @override
  State<WebShowPayMent> createState() => _WebShowPayMentState();
}

class _WebShowPayMentState extends State<WebShowPayMent> {
 var  itemsOrder  ;
  @override
  void initState() {
    super.initState();
    int duration = 0;
    Timer(Duration(seconds: duration), () async {



      // else {
      //   setState(() {
      //     duration += 1;
      //   });
      // }
      await EasyLoading.dismiss();
    });
  }
  @override
  Widget build(BuildContext context) {
    itemsOrder = Provider.of<ProductPageVariables>(context);
    return Scaffold(
      appBar: MyAppBar(titel: 'Payment'),
      body: Center(child: webV(context
      ,total_amount:  widget.total_amount,email:  widget.email,order_info_id:  widget.order_info_id)),
      // WebViewConfiguration(
      //   initialUrl: 'https://www.paypal.com/vn/home',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   navigationDelegate: (NavigationRequest request) {
      //     if (request.url.contains('https://www.paypal.com/vn/home')) {
      //       return NavigationDecision.navigate;
      //     }
      //     return NavigationDecision.prevent;
      //   },
      // ),

      // ElevatedButton(
      //   onPressed:  _launchURL,
      //   child: Text('Show Flutter homepage'),
      // ),
    );
  }

  gif() {
    //https://lottiefiles.com/58362-man-delivery    /* 58362-man-delivery.gif
    String _imageUrl = 'http://192.168.80.1//ssssssssssss/pablita-delivery.gif';
    // Image.asset("assets/gif/58362_man_delivery.gif");
    return Container(
      color: ColorsApp.primColr,
      child: CachedNetworkImage(
        imageUrl: _imageUrl,
        fit: BoxFit.fitHeight,
        height: DimenApp.hightSc(context, hightPy: 0.28),
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
          color: ColorsApp.primColr,
        )),
      ),
    );
  }


webV(BuildContext context,
    {required String total_amount, required String email, required String order_info_id}) {

  //https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/
  // stripe_payment_getway_php/index.php?id=ch_3LIH69ACwSiydFk91Pa11Eg7&des=Invoice%20#118422707
  late WebViewController webViewController;
  String url =
      'https://sinbadslunch.com/myBackENd/Back-End Sinbad-Lunch API/stripe_payment_getway_php/index.php?''total_amount=$total_amount&email=$email&order_info_id=$order_info_id';
  print('url: $url');
  return WebView(
    initialUrl: url,
    javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: (webViewController) {
      webViewController.loadUrl(url);
    },
    onPageFinished: (url) {
      if (url.contains('?id=')) {
        print('success');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: AStx("Success")),
        );
        itemsOrder.BasketListItems.clear();

        Timer(const Duration(seconds: 1), () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>
                      PageHome()));
        });
      } else if (url.contains('cancel')) {
        print('cancel');
      }
    },
  );
}
}
// _launchURL() async {
//   const url =
//       'http://192.168.80.1//ssssssssssss/stripe_payment_getway_php/index.php';
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrl(Uri.parse(url));
//   } else {
//     throw 'Could not launch $url';
//   }
// }
