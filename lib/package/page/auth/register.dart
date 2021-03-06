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
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/Controller/user/autho.dart';
import 'package:sinbad_lunch/Controller/user/get_all_user_info.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/components/save_info/shared_preference.dart';
import 'package:sinbad_lunch/model/user/company_all.dart';
import 'package:sinbad_lunch/package/page/auth/email_confirmation.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late bool _obscureText = true;
  late FaIcon _iconSuffix = const FaIcon(FontAwesomeIcons.eye);

  // ignore: non_constant_identifier_names
  var ListNameComp = [];

  String? dropDownValueCompName;

  // setState(() {
  // _obscureText = true;
  // _iconSuffix = const FaIcon(FontAwesomeIcons.eye);
  // });

  getNameComp() async {
    List<CompanyAll> w = await GetAllUserInfo().CompanyAllData();
    int oo = 0;
    setState(() {
      for (var i in w) {
        ListNameComp.add(i);
        oo += 1;
      }
    });

    print('oo =  ' + oo.toString());
    // dropDownValueCompName = ListNameComp[0].comp_name;
  }

  @override
  void initState() {
    super.initState();
    getNameComp();
    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/
  }

  final TextEditingController _controllerFName = TextEditingController();
  final TextEditingController _controllerLName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  var dropDownValueCompId = 0;
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
              Fluttertoast.showToast(msg: message, fontSize: 12);
              return false;
            } else {
              Fluttertoast.cancel();
              return true;
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: GestureDetector(
                onHorizontalDragCancel: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: Center(
                  child: Column(
                    children: [
                      // Text Filed for register
                      /*****************************************************************/
                      // Text for name of page
                      // SizedBox(height:  DimenApp.hightSc(context, hightPy: 0.1),),
                      //---------------------------------------------------
                      // Text('REgister',style: TextStyle(
                      //   color: ColorsApp.primColr,
                      //   fontSize: 35,
                      // ),),
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
                          'Register',
                          colr: ColorsApp.blak50,
                          size: 35,
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

                      // //header image
                      // Container(
                      //   height: DimenApp.hightSc(context, hightPy: 0.25),
                      //   width: DimenApp.widthSc(context),
                      //   padding: const EdgeInsets.all(12),
                      //   child: Image.asset(ImageApp.imgLogo),
                      // ),
                      /*****************************************************************/

                      // Container(
                      //                height: DimenApp.hightSc(context, hightPy: 0.15),
                      //                width: DimenApp.widthSc(context),
                      //                decoration: BoxDecoration(
                      //                  color: ColorsApp.white1,
                      //                  borderRadius: const BorderRadius.only(
                      //                    bottomLeft: Radius.circular(50),
                      //                    bottomRight: Radius.circular(50),
                      //                  ),
                      //                ),
                      //                alignment: Alignment.center,
                      //                child:   Text('REgister',style: TextStyle(
                      //                  color: ColorsApp.primColr,
                      //                  fontSize: 35,
                      //                ),),
                      //              ),
                      /************************ Start Form ********************************/
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /*******************************************************************/
                            // Text Filed for First Name
                            TFiled(
                              controller: _controllerFName,
                              onValidator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == ' ') {
                                  return 'Please enter First Name';
                                }
                                return null;
                              },
                              hint: WordAppENG.firstName,
                              keyboardType: TextInputType.text,
                              pIcon: Icon(
                                Icons.perm_identity_rounded,
                                color: ColorsApp.primColr,
                              ),
                            ),
                            /*******************************************************************/
                            const SizedBox(
                              height: 5,
                            ),
                            // Text Filed for Last Name
                            TFiled(
                              controller: _controllerLName,
                              onValidator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == ' ') {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              hint: WordAppENG.lastName,
                              keyboardType: TextInputType.text,
                              pIcon: Icon(
                                Icons.people_outlined,
                                color: ColorsApp.primColr,
                              ),
                            ),
                            /*******************************************************************/
                            // Drop Down Menu For Select Company Name

                            /*******************************************************************/
                            const SizedBox(
                              height: 5,
                            ),
                            // Text Filed for Email Name
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
                              height: 5,
                            ),
                            // Text Filed for Phone Number
                            TFiled(
                              controller: _controllerPhone,
                              onValidator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Phone Number';
                                } else if (value.length != 10) {
                                  return 'Please Enter a Valid Phone Number';
                                }
                                return null;
                              },
                              hint: WordAppENG.phone,
                              keyboardType: TextInputType.phone,
                              pIcon: Icon(
                                Icons.phone,
                                color: ColorsApp.primColr,
                              ),
                              inputFormatter: [
                                // for below version 2 use this
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                // for version 2 and greater you can also use this
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            /*******************************************************************/
                            const SizedBox(
                              height: 5,
                            ),
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

                            Card(
                              elevation: 5,
                              // color: ColorsApp.primColr.withOpacity(0.0),
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: ColorsApp.primColr,
                                    width: 2.0,
                                  ),
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    AStx(
                                      'your Company',
                                      colr: ColorsApp.blak50,
                                    ),
                                    Container(width: 20),
                                    SizedBox(
                                      height: 40,
                                      width:
                                          DimenApp.widthSc(context, widthPy: 0.6),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please choose a company name';
                                            }
                                            return null;
                                          },
                                          // decoration:
                                          // InputDecoration(
                                          //   enabledBorder: OutlineInputBorder(
                                          //     borderSide: BorderSide(color: ColorsApp.blak50, width: 2),
                                          //     borderRadius: BorderRadius.circular(20),
                                          //   ),
                                          //   border: OutlineInputBorder(
                                          //     borderSide: BorderSide(color: ColorsApp.blak50, width: 2),
                                          //     borderRadius: BorderRadius.circular(20),
                                          //   ),
                                          //   // filled: true,
                                          //   // fillColor:ColorsApp.primColr.withOpacity(0.1),
                                          // ),
                                          // validator: (value) => value == null ? "Select a country" : null,
                                          // dropdownColor: ColorsApp.primColr.withOpacity(0.6),

                                          // hint: AStx('Select Your Company')  ,
                                          value: (dropDownValueCompName != null &&
                                                  dropDownValueCompName!.isNotEmpty)
                                              ? dropDownValueCompName
                                              : null,

                                          isExpanded: true,

                                          isDense: true,

                                          // style: inputTextStyle(),

                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                          ),

                                          iconSize: 24,
                                          items: ListNameComp.map((var items) {
                                            return DropdownMenuItem<String>(
                                              value: items.comp_name.toString(),
                                              child: AStx(
                                                  items.comp_name.toString(),
                                                  size: 12),
                                              onTap: () => setState(() {
                                                dropDownValueCompId =
                                                    items.company_id;
                                              }),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) =>
                                              setState(() {
                                            dropDownValueCompName = newValue!;
                                            print(
                                                'dropDownValueCompId  ==  $dropDownValueCompId');
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 33),

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
                                // //google login
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
                                //facebook login
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
                                //           const FaIcon(FontAwesomeIcons.facebookF),
                                //           SizedBox(
                                //               width: DimenApp.widthSc(context, widthPy: 0.03)),
                                //           AStx("Facebook"),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                /*******************************************************************/
                                // Button to Submit

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
                                        if (_formKey.currentState!.validate()) {
                                          EasyLoading.show(
                                            status: 'loading...',
                                            // maskType: EasyLoadingMaskType.black
                                          );
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                          var data = await Autho().signUp(
                                            first_name: _controllerFName.text,
                                            last_name: _controllerLName.text,
                                            email: _controllerEmail.text,
                                            phone_number: _controllerPhone.text,
                                            password: _controllerPassword.text,
                                            company_id:
                                                dropDownValueCompId.toString(),
                                          );
                                          if (data ==
                                              "New record created successfully") {
                                            // call send email page here

                                            bool ff = true;
                                            while (ff) {
                                              var sEmail = await Autho()
                                                  .sendEmail(
                                                      _controllerEmail.text);
                                              if (sEmail == "its Connection") {
                                                ff = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Processing Data')),
                                                );

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PageEmailConfirmation(
                                                      email:
                                                          _controllerEmail.text,
                                                    ),
                                                  ),
                                                );

                                              }
                                            }
                                          }else{
                                            EasyLoading.showError( 'Error');
                                            Fluttertoast.showToast(
                                                msg: data ,
                                                backgroundColor: ColorsApp.primColr,
                                                fontSize: 14,
                                                textColor: ColorsApp.white);
                                          }
                                        }
                                        // for(var i in ListNameComp){
                                        //   print(i.comp_name);
                                        // }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const FaIcon(
                                              FontAwesomeIcons.solidPlayCircle ,size: 17,),
                                          SizedBox(
                                              width: DimenApp.widthSc(context,
                                                  widthPy: 0.03)),
                                          AStx(WordAppENG.register),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //
                                //
                                // SizedBox(
                                //     // height: DimenApp.hightSc(context, hightPy: 0.088),
                                //     // width: DimenApp.widthSc(context),
                                //     child: btnEleSimple(WordAppENG.register, onTab: () {
                                //       Navigator.pushReplacement(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (BuildContext context) => PageHome(),
                                //         ),
                                //       );
                                //     })),
                                //
                                // SizedBox(
                                //   height: DimenApp.hightSc(context, hightPy: 0.03),
                                // ),

                                /*******************************************************************/

                                //space
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
                            ),

                            // SizedBox(
                            //   height: DimenApp.hightSc(context, hightPy: 0.02),
                            // ),
                          ],
                        ),
                      ),
                      /************************ End Form ********************************/
                      /*******************************************************************/

                      /*******************************************************************/
                      // Text \ For Return The Login Page
                      btnTxt(WordAppENG.backToLogin, onTab: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Login(),
                          ),
                        );
                      }),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.03),
                      ),
                      /*******************************************************************/
                      //end Page

                      /*******************************************************************/
                      /*******************************************************************/
                      /*******************************************************************/
                      // SimpleFiled(
                      //   keyboardType: TextInputType.number,
                      //   controller: controllerValue['age'],
                      //   onValidator: (value) =>
                      //       AppValidators.isAge(value),
                      //   hint: KeyLang.age,
                      //   pIcon: Icon(
                      //     Icons.filter_vintage_outlined,
                      //     color: AppColors.blue,
                      //   ),
                      // ),
                      /*******************************************************************/
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
}
//
// class MyBookings extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom paint Demo'),
//       ),
//       body: Center(
//         child: CustomPaint(
//           size: const Size(400, 400),
//           painter: RPSCustomPainter(),
//         ),
//       ),
//     );
//   }
// }
//
// class CurvedPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.teal
//       ..strokeWidth = 15;
//
//     var path = Path();
//
//     path.moveTo(0, size.height * 0.7);
//     path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
//         size.width * 0.5, size.height * 0.8);
//     path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
//         size.width * 1.0, size.height * 0.8);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 21.96;
//
//     Path path0 = Path();
//     path0.moveTo(size.width * 0.4510000, size.height * 0.3133333);
//     path0.lineTo(size.width * 0.8000000, size.height * 0.3200000);
//     path0.lineTo(size.width * 0.7979900, size.height * 0.5604333);
//     path0.lineTo(size.width * 0.7810000, size.height * 0.5416667);
//     path0.lineTo(size.width * 0.7740000, size.height * 0.5200000);
//     path0.lineTo(size.width * 0.7580000, size.height * 0.5000000);
//     path0.lineTo(size.width * 0.7440000, size.height * 0.4933333);
//     path0.lineTo(size.width * 0.7260000, size.height * 0.4833333);
//     path0.lineTo(size.width * 0.7000000, size.height * 0.4800000);
//     path0.lineTo(size.width * 0.6880000, size.height * 0.4783333);
//     path0.lineTo(size.width * 0.6700000, size.height * 0.4900000);
//     path0.lineTo(size.width * 0.6630000, size.height * 0.5100000);
//     path0.lineTo(size.width * 0.6610000, size.height * 0.5233333);
//     path0.lineTo(size.width * 0.6543100, size.height * 0.5438333);
//     path0.lineTo(size.width * 0.6419700, size.height * 0.5566000);
//     path0.lineTo(size.width * 0.6339600, size.height * 0.5666500);
//     path0.lineTo(size.width * 0.6290000, size.height * 0.5700000);
//     path0.lineTo(size.width * 0.6170000, size.height * 0.5700000);
//     path0.lineTo(size.width * 0.5914200, size.height * 0.5745000);
//     path0.lineTo(size.width * 0.5609900, size.height * 0.5901333);
//     path0.lineTo(size.width * 0.5372400, size.height * 0.6108167);
//     path0.lineTo(size.width * 0.4918800, size.height * 0.6069500);
//     path0.lineTo(size.width * 0.4676300, size.height * 0.5701667);
//     path0.lineTo(size.width * 0.4572900, size.height * 0.5245833);
//     path0.lineTo(size.width * 0.4519700, size.height * 0.4866833);
//     path0.lineTo(size.width * 0.4510000, size.height * 0.3133333);
//     path0.close();
//
//     canvas.drawPath(path0, paint0);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
