import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
      // FirebaseMessaging _firebaseMessaging =    FirebaseMessaging();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String token1 = "";
String? mess  ;
// ignore: non_constant_identifier_names
Future firebaseCloudMessaging_Listeners() async {

  //    _firebaseMessaging!.getToken().then((token) {
  // // String? token = await FirebaseMessaging.instance.getAPNSToken();
  //     print("this is token for my by now \n"+token!);
  //     token1 = token;

      setState(() {});
    // });
      String? token = await FirebaseMessaging.instance.getToken();

      token1 = token!;
      print(token);
      print("sami");

}
  /********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful = true;

  Future<void> _tryConnection() async {

    bool? result = false;
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      final response =
          await InternetAddress.lookup('https://www.sinbadslunch.com/');

      setState(() {
        _isConnectionSuccessful = result; //response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful == result; // false;
      });
    }
  }

  _tryConnectionWAit() async {
    await _tryConnection();
  }

  /***************************************************************************/
  @override
  void initState() {
    super.initState();
    /****************************************************/
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/
    firebaseCloudMessaging_Listeners();
    /****************************************************/
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnectionSuccessful!) {
      try {
        return Scaffold(
          appBar: MyAppBar(
            titel: WordAppENG.aboutUs,
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /***************************************************/
                //image face of market
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImageApp.logoMarket,
                    height: DimenApp.hightSc(context, hightPy: 0.45),
                    width: DimenApp.widthSc(context),
                    fit: BoxFit.fill,
                  ),
                ),
                /*************************************************/
                //name of page about us
                Text(WordAppENG.aboutUs,
                    style: TextStyle(
                      color: ColorsApp.primColr,
                      fontSize: 31,
                    )),
                /*************************************************/
                //name of page content about us
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(WordAppENG.contentOfAboutUs,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                ),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.1),
                ),
                /*************************************************/
                //name of page Ordered Online
                SvgPicture.asset(
                  ImageApp.orderedOnline,
                  height: DimenApp.hightSc(context, hightPy: 0.15),
                  width: DimenApp.widthSc(context, widthPy: 0.05),
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //  number of order
                Text('190',
                    style: TextStyle(
                      color: ColorsApp.primColr,
                      fontSize: 31,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //image ordered Online
                Text(WordAppENG.orderedOnline,
                    style: TextStyle(
                      color: ColorsApp.appBar,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.09),
                ),
                /*************************************************/
                //name of page Dishes Served
                SvgPicture.asset(
                  ImageApp.dishesServed,
                  height: DimenApp.hightSc(context, hightPy: 0.15),
                  width: DimenApp.widthSc(context, widthPy: 0.05),
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //  number of order
                Text('459',
                    style: TextStyle(
                      color: ColorsApp.primColr,
                      fontSize: 31,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //image ordered Online
                Text(WordAppENG.dishesServed,
                    style: TextStyle(
                      color: ColorsApp.appBar,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.09),
                ),
                /*************************************************/
                //name of page Home Delivered
                SvgPicture.asset(
                  ImageApp.homeDelivered1,
                  height: DimenApp.hightSc(context, hightPy: 0.15),
                  width: DimenApp.widthSc(context, widthPy: 0.05),
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                SvgPicture.asset(
                  ImageApp.homeDelivered2,
                  height: DimenApp.hightSc(context, hightPy: 0.15),
                  width: DimenApp.widthSc(context, widthPy: 0.05),
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //  number of order
                Text('197',
                    style: TextStyle(
                      color: ColorsApp.primColr,
                      fontSize: 31,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.03),
                ),
                //image ordered Online
                Text(WordAppENG.orderedOnline,
                    style: TextStyle(
                      color: ColorsApp.appBar,
                      fontSize: 25,
                    )),
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.09),
                ),

                /*************************************************/
                //name of page content about us
                Container(
                  color: ColorsApp.white1,
                  width: DimenApp.widthSc(context),
                  child: Column(
                    children: [
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      /*************************************************/
                      //howItWorks
                      Text(WordAppENG.howItWorks,
                          style: TextStyle(
                            color: ColorsApp.primColr,
                            fontSize: 31,
                          )),
                      /*************************************************/
                      //section how iit works  Choose
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      Image.asset(
                        ImageApp.choose,
                        height: DimenApp.hightSc(context, hightPy: 0.08),
                        width: DimenApp.widthSc(context, widthPy: 0.2),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //  number of order
                      Text(WordAppENG.choose,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //image ordered Online
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(WordAppENG.contentChoose,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.09),
                      ),
                      /*************************************************/
                      //section how it works  Order
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      Image.asset(
                        ImageApp.order,
                        height: DimenApp.hightSc(context, hightPy: 0.08),
                        width: DimenApp.widthSc(context, widthPy: 0.2),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //  number of order
                      Text(WordAppENG.order,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //image ordered Online
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(WordAppENG.contentOrder,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.09),
                      ),
                      /*************************************************/
                      //section how iit works  Company Delivery
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      Image.asset(
                        ImageApp.companyDelivery,
                        height: DimenApp.hightSc(context, hightPy: 0.08),
                        width: DimenApp.widthSc(context, widthPy: 0.2),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //  number of order
                      Text(WordAppENG.companyDelivery,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      //image ordered Online
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(WordAppENG.contentCompanyDelivery,
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.09),
                      ),
                      ElevatedButton(onPressed: () async {
                      var  mess1=    await  Autho().sendToken(token: token1);
                        setState(() {
                          mess = mess1;
                        });
                      }, child: const Text('send not'),),

                      Text(mess??"not yet"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } on Exception catch (_) {
        print("throwing new error");

        throw Center(
          child: AStx('Wait a moment please'),
        );
      }
    } else {
      return Center(
        child: AStx('Not connected to any network'),
      );
    }
  }
}
