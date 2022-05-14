import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_basket.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';
import 'package:sinbad_lunch/package/page/page_about_us.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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

                  // Flexible(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 23.0, bottom: 29),
                  //     child:  Container(
                  //       height: 40,
                  //       width: 40,
                  //       child: Expanded(
                  //         child: ElevatedButton(onPressed: (){}, child: AStx('915',colr: ColorsApp.white,size: 1,),
                  //           style: ElevatedButton.styleFrom(
                  //
                  //             primary: ColorsApp.blak1,
                  //             onPrimary:
                  //             ColorsApp.white1.withOpacity(0.7),
                  //             elevation: 10,
                  //             shape: RoundedRectangleBorder(
                  //
                  //               borderRadius: BorderRadius.circular(55.0),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0, bottom: 29),
                    child: Icon(
                      Icons.circle,
                      color: ColorsApp.blak1,
                      size: 40,
                    ),
                  ),
                    Flexible(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 31.0, top: 9),
                      child: AStx('958',colr: ColorsApp.white,size: 15),
                  ),
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
