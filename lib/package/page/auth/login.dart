// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
import 'package:sinbad_lunch/Components/Widget/textFF.dart';
import 'package:sinbad_lunch/Components/image/images.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/button/btnEleSimple.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';

import '../page_Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

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
      child: Scaffold(
        body: Container(
          height: DimenApp.hightSc(context),
          width: DimenApp.widthSc(context),
          color: ColorsApp.white,
          child: SingleChildScrollView(
            child: GestureDetector(
              onHorizontalDragCancel: (){
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child: Column(
                children: [
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.07),
                  ),
                  //logo
                  CachedNetworkImage(
                      imageUrl: ImageApp.imgLogo,
                      // fit: BoxFit.fitHeight,
                      // height: DimenApp.hightSc(context, hightPy: 0.28),
                      width: DimenApp.widthSc(context),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color:ColorsApp.primColr ,)),
                  ),
                  // (
                  //   ImageApp.imgLogo,
                  //   width: DimenApp.widthSc(context),
                  // ),

                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.10),
                  ),



                  // //sub Login
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     //space
                  //     Flexible(flex:1,child: Container(),),
                  //   //google login
                  //     Flexible(
                  //       flex: 8,
                  //       child: SizedBox(
                  //         height: DimenApp.hightSc(context, hightPy: 0.065),
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             primary: ColorsApp.white,
                  //             onPrimary: ColorsApp.primColr,
                  //             elevation: 10,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(11.0),
                  //             ),
                  //           ),
                  //           onPressed: () {},
                  //           child: Row(
                  //             children: [
                  //                 FaIcon(FontAwesomeIcons.google,color:ColorsApp.primColr,),
                  //               SizedBox(
                  //                   width: DimenApp.widthSc(context, widthPy: 0.03)),
                  //               AStx("Google",colr: ColorsApp.blak50,),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     //space
                  //     Flexible(flex:1,child: Container(),),
                  //     //facebook login
                  //     Flexible(
                  //       flex: 8,
                  //       child: SizedBox(
                  //         height: DimenApp.hightSc(context, hightPy: 0.065),
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             primary: ColorsApp.white,
                  //             onPrimary: ColorsApp.primColr,
                  //             elevation: 10,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(11.0),
                  //             ),
                  //           ),
                  //           onPressed: () {},
                  //           child: Row(
                  //             children: [
                  //                 FaIcon(FontAwesomeIcons.facebookF,color:ColorsApp.primColr,),
                  //               SizedBox(
                  //                   width: DimenApp.widthSc(context, widthPy: 0.03)),
                  //               AStx("Facebook",colr: ColorsApp.blak50,),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     //space
                  //     Flexible(flex:1,child: Container(),),
                  //   ],
                  // ),

                  Card(
                    // shape: BeveledRectangleBorder(
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    // /************************************************/
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    /************************************************/

                    // shape: StadiumBorder(
                    //   side: BorderSide(
                    //     color: Colors.black,
                    //     width: 2.0,
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          //email
                          TextFF(WordAppENG.entrEmail),
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.04),
                          ),
                          //password
                          TextFF(WordAppENG.entrPass),
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.004),
                          ),
                          Row(
                            children: [
                              btnTxt(
                                WordAppENG.forgotPass,
                                fSize: DimenApp.hightSc(context, hightPy: 0.0209),
                                onTab: () {
                                  print('login');
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.015),
                          ),
                          //button login
                          // SizedBox(
                          //   width: DimenApp.widthSc(context, widthPy: 0.88),
                          //   child: btnEleSimple(
                          //     WordAppENG.login,
                          //
                          //     onTab: () {
                          //       print('sami');
                          //
                          //       Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (BuildContext context) => PageHome(),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: DimenApp.hightSc(context, hightPy: 0.015),
                          // ),
                          // /***************************************/
                          // SizedBox(
                          //   height: DimenApp.hightSc(context, hightPy: 0.015),
                          // ),

                          /****************************************/
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.015),
                          ),

                          /*******************************************************************/
                          //sub Login
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //space
                              Flexible(flex:1,child: Container(),),
                              //google login
                              Flexible(
                                flex: 8,
                                child: SizedBox(
                                  height: DimenApp.hightSc(context, hightPy: 0.065),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorsApp.white,
                                      onPrimary: ColorsApp.primColr,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11.0),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        const FaIcon(FontAwesomeIcons.google),
                                        SizedBox(
                                            width: DimenApp.widthSc(context, widthPy: 0.03)),
                                        AStx("Google"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //space
                              Flexible(flex:1,child: Container(),),

                              /*******************************************************************/
                              // Button to login

                              Flexible(
                                flex: 8,
                                child: SizedBox(
                                  height: DimenApp.hightSc(context, hightPy: 0.065),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorsApp.white,
                                      onPrimary: ColorsApp.primColr,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11.0),
                                      ),
                                    ),
                                    onPressed: () {

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => PageHome(),
                                              ),
                                            );
                                    },
                                    child: Row(
                                      children: [
                                        const FaIcon(FontAwesomeIcons.solidPlayCircle),
                                        SizedBox(
                                            width: DimenApp.widthSc(context, widthPy: 0.03)),
                                        AStx(WordAppENG.login),
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                              /*******************************************************************/



                              //space
                              Flexible(flex:1,child: Container(),),
                            ],
                          ),

                          /*******************************************************************/

                          /***************************************/
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.015),
                          ),

                          //button register
                          Row(
                            children: [
                              btnTxt(
                                WordAppENG.dontHaveRegister,
                                fSize: DimenApp.hightSc(context, hightPy: 0.023),
                                onTab: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Register(),
                                    ),
                                  );
                                  print("I don't have an account, register");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    await GoogleSignInApi.login();
  }
}

class GoogleSignInApi {
  static final _googleSingIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSingIn.signIn();
}
