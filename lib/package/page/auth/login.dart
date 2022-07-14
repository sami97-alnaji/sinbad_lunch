// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
import 'package:sinbad_lunch/Components/image/images.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/save_info/shared_preference.dart';
import 'package:sinbad_lunch/package/page/auth/forgot_passowrd.dart';
import 'package:sinbad_lunch/package/page/auth/register.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  late bool _obscureText = true;
  late FaIcon _iconSuffix = const FaIcon(FontAwesomeIcons.eye);
  final _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var logn;
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
    EasyLoading.dismiss();
    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    if (_isConnectionSuccessful!) {
      try {
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
                  onHorizontalDragCancel: () {
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
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: ColorsApp.primColr,
                        )),
                      ),

                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.10),
                      ),

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
                          padding: const EdgeInsets.all(5.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),

                                /*******************************************************************/
                                // Text Filed for Email
                                TFiled(
                                  controller: _controllerEmail,
                                  onValidator: (value) {
                                    String pattern =
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                        r"{0,253}[a-zA-Z0-9])?)*$";
                                    RegExp regex = RegExp(pattern);
                                    if (value == null ||
                                        value.isEmpty ||
                                        !regex.hasMatch(value) ||
                                        value.contains('@') ||
                                        value.contains('.')) {
                                      return EmailValidator.validate(value!)
                                          ? null
                                          : 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                  hint: WordAppENG.email,
                                  keyboardType: TextInputType.emailAddress,
                                  pIcon: Icon(
                                    Icons.email,
                                    color: ColorsApp.primColr,
                                  ),
                                ),
                                /*******************************************************************/
                                const SizedBox(
                                  height: 12,
                                ),

                                /*******************************************************************/
                                // Text Filed for Password
                                TFiled(
                                    controller: _controllerPassword,
                                    textAction: TextInputAction.done,
                                    onValidator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if (value.length < 6) {
                                        return 'Please enter a password of at least 6 characters';
                                      }
                                      return null;
                                    },
                                    hint: WordAppENG.password,
                                    keyboardType: TextInputType.text,
                                    pIcon: Icon(
                                      Icons.lock_rounded,
                                      color: ColorsApp.primColr,
                                    ),
                                    isObscureText: _obscureText,
                                    // pIcon: Icon(
                                    // Icons.lock,
                                    // color: AppColors.blue,
                                    // ),
                                    sIcon: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: _iconSuffix,
                                    ),
                                    onSIcon: () {
                                      setState(() {
                                        if (_obscureText) {
                                          _iconSuffix = FaIcon(
                                            FontAwesomeIcons.eye,
                                            color: ColorsApp.blak1,
                                          );
                                          _obscureText = false;
                                        } else {
                                          _iconSuffix = FaIcon(
                                            FontAwesomeIcons.eyeSlash,
                                            color: ColorsApp.blak1,
                                          );
                                          _obscureText = true;
                                        }
                                      });
                                    }),
                                /*******************************************************************/
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    btnTxt(
                                      WordAppENG.forgotPass,
                                      fSize: DimenApp.hightSc(context,
                                          hightPy: 0.0209),
                                      onTab: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PageForgotPassword(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      DimenApp.hightSc(context, hightPy: 0.015),
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
                                  height:
                                      DimenApp.hightSc(context, hightPy: 0.015),
                                ),

                                /*******************************************************************/
                                //sub Login
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //space
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    //google login
                                    // Flexible(
                                    //   flex: 8,
                                    //   child: SizedBox(
                                    //     height: DimenApp.hightSc(context, hightPy: 0.065),
                                    //     child: ElevatedButton(
                                    //       style: ElevatedButton.styleFrom(
                                    //         primary: ColorsApp.white,
                                    //         onPrimary: ColorsApp.primColr,
                                    //         elevation: 10,
                                    //         shape: RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius.circular(11.0),
                                    //         ),
                                    //       ),
                                    //       onPressed: () {},
                                    //       child: Row(
                                    //         children: [
                                    //           const FaIcon(FontAwesomeIcons.google),
                                    //           SizedBox(
                                    //               width: DimenApp.widthSc(context, widthPy: 0.03)),
                                    //           AStx("Google"),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // //space
                                    // Flexible(flex:1,child: Container(),),

                                    /*******************************************************************/
                                    // Button to login

                                    Flexible(
                                      flex: 8,
                                      child: SizedBox(
                                        height: DimenApp.hightSc(context,
                                            hightPy: 0.065),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorsApp.white,
                                            onPrimary: ColorsApp.primColr,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              EasyLoading.show(
                                                status: 'loading...',
                                                maskType: EasyLoadingMaskType.black
                                              );
                                              logn = await Autho().logIn(
                                                  email: _controllerEmail.text,
                                                  password:
                                                      _controllerPassword.text);
                                              // ignore: unrelated_type_equality_checks
                                              if (logn ==
                                                      "There is an error in the email or password" ||
                                                  logn == null ||
                                                  logn == "") {
                                                EasyLoading.dismiss();

                                                EasyLoading.showError(
                                                    'error',
                                                    maskType: EasyLoadingMaskType.black
                                                );
                                                Timer(const Duration(seconds: 1), () async {

                                                  await EasyLoading.dismiss();
                                                });
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(SnackBar(
                                                //         content: AStx(
                                                //             "Please verify your information !!!")));
                                                Fluttertoast.showToast(
                                                    msg: logn,
                                                    backgroundColor: ColorsApp.primColr,
                                                    fontSize: 14,
                                                    textColor: ColorsApp.white);
                                              } else {
                                                /****************************************/
                                                EasyLoading.show(
                                                  status: 'loading...',
                                                  maskType: EasyLoadingMaskType.black
                                                );
                                                await UserInfoPreferences
                                                    .SetCompanyId(
                                                        logn["company_id"]);
                                                await UserInfoPreferences
                                                    .SetPhoneNumber(
                                                        logn["phone_number"]);
                                                await UserInfoPreferences
                                                    .SetEmail(logn["email"]);
                                                await UserInfoPreferences
                                                    .SetFirstName(
                                                        logn["first_name"]);
                                                await UserInfoPreferences
                                                    .SetLastName(
                                                        logn["last_name"]);
                                                await UserInfoPreferences
                                                    .SetPassword(
                                                        logn["password"]);
                                                await UserInfoPreferences
                                                    .SetStatusEmail(
                                                        logn["status_email"]);
                                                await UserInfoPreferences
                                                    .SetUserId(logn["user_id"]);
                                                print(logn["user_id"]);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: AStx(
                                                      "You are logged in successfully"),
                                                ));
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PageHome(),
                                                  ),
                                                );
                                                /******************************************/
                                              }
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const FaIcon(FontAwesomeIcons
                                                  .solidPlayCircle),
                                              SizedBox(
                                                  width: DimenApp.widthSc(
                                                      context,
                                                      widthPy: 0.03)),
                                              AStx(WordAppENG.login),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    /*******************************************************************/

                                    //space
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                ),

                                /*******************************************************************/

                                /***************************************/
                                SizedBox(
                                  height:
                                      DimenApp.hightSc(context, hightPy: 0.015),
                                ),

                                //button register
                                Row(
                                  children: [
                                    btnTxt(
                                      WordAppENG.dontHaveRegister,
                                      fSize: DimenApp.hightSc(context,
                                          hightPy: 0.023),
                                      onTab: () async {
                                        // print(    UserInfoPreferences
                                        //       .GetCompanyId(  ));
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const Register(),
                                          ),
                                        );
                                        print(
                                            "I don't have an account, register");
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  // Future signIn() async {
  //   await GoogleSignInApi.login();
  // }
}

// class GoogleSignInApi {
//   static final _googleSingIn = GoogleSignIn();
//
//   static Future<GoogleSignInAccount?> login() => _googleSingIn.signIn();
// }
