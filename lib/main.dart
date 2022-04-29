import 'package:flutter/material.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_basket.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';
import 'package:sinbad_lunch/package/page/page_about_us.dart';
import 'package:sinbad_lunch/package/page/page_product.dart';
import 'package:sinbad_lunch/package/page/start_Page/page_splash.dart';

void main() {
  runApp(const SinbadsLunch());
}

class SinbadsLunch extends StatelessWidget {
  const SinbadsLunch({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sinbads Lunch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.deepPurple,
      ),
      home:const PageBasket(), //PageProduct(title: '55f5f5',), //PageHome(),//PageSplash(),//Register(),
    );
  }
}

