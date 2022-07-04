import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_basket.dart';
import 'package:sinbad_lunch/package/page/auth/email_confirmation.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';
import 'package:sinbad_lunch/package/page/page_about_us.dart';
import 'package:sinbad_lunch/package/page/page_product.dart';
import 'package:sinbad_lunch/package/page/start_Page/page_splash.dart';
import 'package:sinbad_lunch/package/test%20Bottun%20top%20the%20page/dashboardpage.dart';
import 'package:sinbad_lunch/package/test%20Bottun%20top%20the%20page/testHttp.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

GlobalKey globalKey = GlobalKey();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = 'pk_test_51L3li7ACwSiydFk9eQqnMwccWFmWpBtBZ0IvksGJ7PrOrRi2DebvH3mStyIiS2HaMpflH4nGRr60SULdQ9ABMxj1003NrDLx2S';
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProductPageVariables>(
      create: (context) => ProductPageVariables(),
    ),
  ], child: const SinbadsLunch()));
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
        primarySwatch: Colors.orange,
      ),
      home:const  Login(),//Register(),//EmailConfirmation(),//PageHome(),//PageSplash(), // DashboardPage(),// const testHttp(),//PageProduct(title: '55f5f5',), // PageBasket(), //
    );
  }
}





