import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/image/images.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/save_info/shared_preference.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  Xo() async {
    if ((UserInfoPreferences.GetEmail() != null &&
            UserInfoPreferences.GetEmail() != '') &&
        (UserInfoPreferences.GetPassword() != null &&
            UserInfoPreferences.GetPassword() != '')) {
      // print(UserInfoPreferences.GetEmail());
      // print(UserInfoPreferences.GetPassword());
      var logn = await Autho().logIn(
          email: UserInfoPreferences.GetEmail() ?? "",
          password: UserInfoPreferences.GetPassword() ?? "");
      // ignore: unrelated_type_equality_checks
      if (logn == "Please verify your information !!!" ||
          logn == null ||
          logn == "") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Login()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: AStx("Please verify your information !!!")));

      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PageHome()));
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Login()));
    }
  }

  //********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful = true;

  Future<void> _tryConnection() async {
    bool? result = false;
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      final response =
          await InternetAddress.lookup('https://www.sinbadslunch.com/');

      setState(() {
        _isConnectionSuccessful = result;//response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful == result;// false;
      });
    }
  }

  _tryConnectionWAit() async {
    await _tryConnection();
  }

  //***************************************************************************/

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Xo();
    });

/****************************************************/
    _tryConnectionWAit();
    /****************************************************/
  }

  @override
  Widget build(BuildContext context) {

    DateTime timeBackPressed = DateTime.now();

      try {
        if (_isConnectionSuccessful!) {
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
              child: CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: ImageApp.imgLogo,
                // fit: BoxFit.fitHeight,
                // height: DimenApp.hightSc(context, hightPy: 0.28),
                width: DimenApp.widthSc(context),
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: ColorsApp.primColr,
                )),
              ),
            ),
          ),
        );
        print(_isConnectionSuccessful);

        } else {
          print(_isConnectionSuccessful);
          return Center(
            child: AStx('Not connected to any network'),
          );
        }

      } on Exception catch (_) {
        print("throwing new error");

        throw Center(
          child: AStx('Wait a moment please'),
        );
      }

  }
}
