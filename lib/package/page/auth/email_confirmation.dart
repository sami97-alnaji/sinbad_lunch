import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

// ignore: must_be_immutable
class PageEmailConfirmation extends StatefulWidget {
  PageEmailConfirmation({required this.email, Key? key}) : super(key: key);
  String email;

  @override
  State<PageEmailConfirmation> createState() => _PageEmailConfirmationState();
}

class _PageEmailConfirmationState extends State<PageEmailConfirmation> {
  final TextEditingController _controllerCode = TextEditingController();
  DateTime timeBackPressed = DateTime.now();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 1);

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
                    'Email Confirmation',
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
                      TFiled(
                        controller: _controllerCode,
                        onValidator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter some text';
                          }
                          if (value.length < 6) {
                            return 'Please Enter the Code';
                          }
                          return null;
                        },
                        // initValue: 'is empty',
                        hint: "Enter the code sent to your email",
                        keyboardType: TextInputType.number,
                        pIcon: Icon(
                          Icons.code,
                          color: ColorsApp.blak1,
                        ),
                      ),
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
                                      borderRadius: BorderRadius.circular(11.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.



                                       var accp = await Autho().acceptance(widget.email,_controllerCode.text);

                                        if(accp=="Account Verified"){
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PageHome(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: AStx('Account Verified')),
                                          );
                                        }else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: AStx('Error')),
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
      ),
    );
  }
}
