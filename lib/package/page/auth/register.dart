// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/Controller/user/get_all_user_info.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnTextSm.dart';
import 'package:sinbad_lunch/components/Widget/button/btnEleSimple.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/model/user/company_all.dart';
import 'package:sinbad_lunch/package/page/auth/login.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late bool _obscureText = true;
  late FaIcon _iconSuffix = const FaIcon(FontAwesomeIcons.eye);

  // ignore: non_constant_identifier_names
  var ListNameComp=[];

  String? dropDownValueCompName;
  var dropDownValueCompId=0;

  // setState(() {
  // _obscureText = true;
  // _iconSuffix = const FaIcon(FontAwesomeIcons.eye);
  // });




  getNameComp() async {
    List<CompanyAll> w = await GetAllUserInfo().CompanyAllData();
    int oo=0;
    setState(() {
      for (var i in w) {
        ListNameComp.add(i);
        oo+=1;
      }
    });

    print('oo =  '+oo.toString());
    // dropDownValueCompName = ListNameComp[0].comp_name;
  }



  @override
  void initState() {
    getNameComp();
    super.initState();

  }

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
        body: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragCancel: (){
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            onTap: (){
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
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color:ColorsApp.primColr ,)),
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

                  /*******************************************************************/
                  // Text Filed for First Name
                  TFiled(
                    hint: WordAppENG.firstName,
                    keyboardType: TextInputType.text,
                    pIcon: Icon(
                      Icons.perm_identity_rounded,
                      color: ColorsApp.primColr,
                    ),
                  ),
                  /*******************************************************************/
                  // Text Filed for Last Name
                  TFiled(
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
                  // Text Filed for Email Name
                  TFiled(
                    hint: WordAppENG.email,
                    keyboardType: TextInputType.text,
                    pIcon: Icon(
                      Icons.email,
                      color: ColorsApp.primColr,
                    ),
                  ),
                  /*******************************************************************/
                  // Text Filed for Phone Number
                  // TFiled(
                  //   hint: WordAppENG.phone,
                  //   keyboardType: TextInputType.text,
                  //   pIcon: Icon(
                  //     Icons.phone,
                  //     color: ColorsApp.primColr,
                  //   ),
                  // ),
                  /*******************************************************************/
                  // Text Filed for Password
                  TFiled(
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

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AStx('your Company',colr: ColorsApp.blak50,),
                      ),
                      Container(width:20),
                      SizedBox(
                        height: 40,

                        width: DimenApp.widthSc(context,widthPy: 0.6),
                        child: DropdownButton (

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
                          value:  (dropDownValueCompName!=null && dropDownValueCompName!.isNotEmpty)  ? dropDownValueCompName:null,

                          isExpanded: true,

                          isDense: true,

                          // style: inputTextStyle(),

                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),

                          iconSize: 24,
                          items:ListNameComp.map((var items) {
                            return DropdownMenuItem<String>(
                                value: items.comp_name.toString(),
                                child: AStx(items.comp_name.toString(),size: 20),
                              onTap: ()=>   setState(() {
                                 dropDownValueCompId=items.company_id;
                              })  ,
                            );
                          }
                          ).toList(),
                          onChanged:  (String? newValue) =>setState(() {
                            dropDownValueCompName = newValue!;
                            print('dropDownValueCompId  ==  $dropDownValueCompId');
                          }) ,
                        ),
                      ),
                    ],
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

                              // for(var i in ListNameComp){
                              //   print(i.comp_name);
                              // }
                            },
                            child: Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.solidPlayCircle),
                                SizedBox(
                                    width: DimenApp.widthSc(context, widthPy: 0.03)),
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
                      Flexible(flex:1,child: Container(),),
                    ],
                  ),

                  // SizedBox(
                  //   height: DimenApp.hightSc(context, hightPy: 0.02),
                  // ),




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
