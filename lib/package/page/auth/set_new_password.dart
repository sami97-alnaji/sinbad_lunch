import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';

// ignore: must_be_immutable
class PageSetNewPassword extends StatefulWidget {
  PageSetNewPassword(this.email, {Key? key}) : super(key: key);
  String email;

  @override
  State<PageSetNewPassword> createState() => _PageSetNewPasswordState();
}

class _PageSetNewPasswordState extends State<PageSetNewPassword> {
  late bool _obscureText1 = true;
  late FaIcon _iconSuffix1 = const FaIcon(FontAwesomeIcons.eye);
  late bool _obscureText2 = true;
  late FaIcon _iconSuffix2 = const FaIcon(FontAwesomeIcons.eye);
  final TextEditingController _controllerPassword1 = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    if (_isConnectionSuccessful!) {
      try {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: DimenApp.hightSc(context, hightPy: 0.25),
                    width: DimenApp.widthSc(context),
                    decoration: BoxDecoration(
                      color: ColorsApp.primColr,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: AStx(
                      'Forgot Password',
                      colr: ColorsApp.blak50,
                      size: 30,
                    ),
                  ),
                  /*****************************************************************/
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.03),
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
                  /*****************************************************************/
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.06),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*******************************************************************/
                        // Text Filed for Password 1
                        TFiled(
                            controller: _controllerPassword1,
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
                            isObscureText: _obscureText1,
                            // pIcon: Icon(
                            // Icons.lock,
                            // color: AppColors.blue,
                            // ),
                            sIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: _iconSuffix1,
                            ),
                            onSIcon: () {
                              setState(() {
                                if (_obscureText1) {
                                  _iconSuffix1 = FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: ColorsApp.blak1,
                                  );
                                  _obscureText1 = false;
                                } else {
                                  _iconSuffix1 = FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: ColorsApp.blak1,
                                  );
                                  _obscureText1 = true;
                                }
                              });
                            }),
                        /*******************************************************************/
                        /*******************************************************************/
                        // Text Filed for Password 2
                        TFiled(
                            controller: _controllerPassword2,
                            textAction: TextInputAction.done,
                            onValidator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length < 6) {
                                return 'Please enter a password of at least 6 characters';
                              }
                              if (value != _controllerPassword1.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            hint: WordAppENG.password,
                            keyboardType: TextInputType.text,
                            pIcon: Icon(
                              Icons.lock_rounded,
                              color: ColorsApp.primColr,
                            ),
                            isObscureText: _obscureText2,
                            // pIcon: Icon(
                            // Icons.lock,
                            // color: AppColors.blue,
                            // ),
                            sIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: _iconSuffix2,
                            ),
                            onSIcon: () {
                              setState(() {
                                if (_obscureText2) {
                                  _iconSuffix2 = FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: ColorsApp.blak1,
                                  );
                                  _obscureText2 = false;
                                } else {
                                  _iconSuffix2 = FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: ColorsApp.blak1,
                                  );
                                  _obscureText2 = true;
                                }
                              });
                            }),
                        /*******************************************************************/
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              //space
                              Flexible(
                                flex: 1,
                                child: Container(),
                              ),

                              /*******************************************************************/
                              // Button to Submit

                              Flexible(
                                flex: 8,
                                child: SizedBox(
                                  height:
                                      DimenApp.hightSc(context, hightPy: 0.065),
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
                                      if (_formKey.currentState!.validate()) {
                                        EasyLoading.show(
                                          status: 'Loading...',
                                        );
                                        var _result = await Autho().setNewPass(
                                            email: widget.email,
                                            password:
                                                _controllerPassword2.text);
                                        if (_result == "let's do it") {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Let the fun begin!')),
                                          );
                                        }
                                      } else {
                                        EasyLoading.dismiss();
                                        EasyLoading.showError(
                                           'Please check your password'
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Email is wrong')),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        const FaIcon(
                                            FontAwesomeIcons.solidPaperPlane),
                                        SizedBox(
                                            width: DimenApp.widthSc(context,
                                                widthPy: 0.03)),
                                        AStx("Submit"),
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
                        ),
                      ],
                    ),
                  ),
                ],
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
}
