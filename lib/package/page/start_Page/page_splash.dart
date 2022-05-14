import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/image/images.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';


class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 4);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Container(
        color: ColorsApp.white1,
        child: Center(
          child:

          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: ImageApp.imgLogo,
            // fit: BoxFit.fitHeight,
            // height: DimenApp.hightSc(context, hightPy: 0.28),
            width: DimenApp.widthSc(context),
            placeholder: (context, url) => Center(child: CircularProgressIndicator(color:ColorsApp.primColr ,)),

          ),
        ),
      ),
    );
  }
}
