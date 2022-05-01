import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_basket.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';
import 'package:sinbad_lunch/package/page/page_about_us.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.white1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.1),
          ),
          btnTxt('Menu', onTab: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PageHome(),
              ),
            );
          }),
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.02),
          ),
          btnTxt('About Us'),
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.02),
          ),
          btnTxt('About Us', onTab: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const AboutUs()));
          }),
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.02),
          ),
          // LOg OUt
          btnTxt('logout', onTab: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Register(),
              ),
            );
          }),
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.02),
          ),
          SizedBox(
            height: DimenApp.hightSc(context, hightPy: 0.13),
            // width: DimenApp.widthSc(context, widthPy: 0.6),
            child: Stack(

                // color: ColorsApp.primColr,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0, bottom: 29),
                    child: Icon(
                      Icons.circle,
                      color: ColorsApp.red1,
                      size: 28,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 33.0, top: 7),
                    child: Text('1'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const PageBasket()));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: ColorsApp.primColr,
                        size: 33,
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
