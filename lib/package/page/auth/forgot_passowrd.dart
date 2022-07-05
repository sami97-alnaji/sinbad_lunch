import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/package/page/auth/email_confirmation.dart';

// ignore: must_be_immutable
class PageForgotPassword extends StatefulWidget {
  const PageForgotPassword({Key? key}) : super(key: key);

  @override
  State<PageForgotPassword> createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  /********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful=true;

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.woolha2.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful = false;
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
    _tryConnectionWAit();
    /****************************************************/
  }

  @override
  Widget build(BuildContext context) {
    if(_isConnectionSuccessful!) {
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                  var forgot = await  Autho().forgotPassword(
                                        email: _controllerEmail.text);

                                   if (forgot=="it/'s ok"){
                                     // call send email page here
                                     Autho().sendEmail(_controllerEmail.text);
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(
                                       const SnackBar(
                                           content: Text('Processing Data')),
                                     );
                                     Navigator.pushReplacement(
                                       context,
                                       MaterialPageRoute(
                                         builder: (BuildContext context) =>
                                             PageEmailConfirmation(
                                               isForgot: true,
                                               email: _controllerEmail.text,
                                             ),
                                       ),
                                     );
                                   }else{
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(
                                       const SnackBar(
                                           content: Text('Email is wrong')),
                                     );
                                   }

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
    }else{
      return Center(
        child: AStx('Not connected to any network'),
      );
    }
  }
}
