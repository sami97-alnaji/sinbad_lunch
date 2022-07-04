// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'test pay Memento method',
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: const WebShow(),
  ));
}

class WebShow extends StatefulWidget {
  const WebShow({Key? key}) : super(key: key);

  @override
  State<WebShow> createState() => _WebShowState();
}

class _WebShowState extends State<WebShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titel: 'Payment'),
      body: Center(child: gif()),
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
}

webV() {
  late WebViewController webViewController;
  String url =
      'http://192.168.80.1//ssssssssssss/stripe_payment_getway_php/index.php';
  return WebView(
    initialUrl: url,
    javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: (webViewController) {
      webViewController.loadUrl(url);
    },
    onPageFinished: (url) {
      if (url.contains('?id=')) {
        print('success');
      } else if (url.contains('cancel')) {
        print('cancel');
      }
    },
  );
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
