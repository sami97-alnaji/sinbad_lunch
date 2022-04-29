import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

enum BestTutorSite { TahiniSauce, GarlicSauce, TazikiSauce }

class additionalTopping {
  String extraName, extraPrice;
  bool extraStute;

  additionalTopping(
    this.extraName,
    this.extraPrice,
    this.extraStute,
  );
}

class PageProduct extends StatefulWidget {
  PageProduct({required this.title, Key? key}) : super(key: key);
  String title;

  @override
  _PageProductState createState() => _PageProductState();
}

class _PageProductState extends State<PageProduct> {
  BestTutorSite _site = BestTutorSite.TazikiSauce;

  var additionalToppings = [
    additionalTopping('Add Extra Meat', '\$1.99', false),
    additionalTopping('Calamata', '\$0.75', false),
    additionalTopping('Jalapeno', '\$0.75', false),
    additionalTopping('Extra Feta Sauce', '\$0.75', false),
    additionalTopping('Extra Garlic Sauce', '\$0.75', false),
    additionalTopping('Extra Tahini Sauce', '\$0.75', false),
    additionalTopping('Extra Taziki Sauce', '\$0.75', false),
    additionalTopping('Feta', '\$0.75', false),
    additionalTopping('Sriacha', '\$1.00', false),
    additionalTopping('Hummus', '\$0.75', false),
  ];

  bool value = false;

  var additionalToppingsChose = [];

  /// ********************************************/
  TextEditingController controllerCountItems = TextEditingController();

  /***************************************/
  bool isLoading = false;
  int CountItems = 1;

  @override
  void initState() {
    controllerCountItems.text = CountItems.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: MyAppBar(titel: widget.title),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: DimenApp.hightSc(context, hightPy: 0.025),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                ImageApp.imGyro,
                height: DimenApp.hightSc(context, hightPy: 0.4),
              ),
            ),
            // title item
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //name item
                      AStx(
                        'Chicken Kabob',
                        size: 20,
                        isBold: true,
                      ),
                      // AutoSizeText('Chicken Kabob',
                      //     style: GoogleFonts.oxygen(
                      //         color: ColorsApp.blak1,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold)),

                      // هاي بدنا نزبها تحت جنب الكبسة
                      //price item
                      //   AutoSizeText('\$5.00',
                      //     style: GoogleFonts.oxygen(
                      //         fontSize: 17, fontWeight: FontWeight.bold)),
                    ])),
            //##################################################################
            SizedBox(
              height: DimenApp.hightSc(context, hightPy: 0.028),
            ),
            //##################################################################
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:AStx(
                    'Chicken kabob Platter served with rice, salad, and suace add extra meat \$1.99',
                size: 15,
                colr: ColorsApp.blak50,
              ),
              // AutoSizeText(
              //     'Chicken kabob Platter served with rice, salad, and suace add extra meat \$1.99',
              //     style: GoogleFonts.oxygen(
              //       fontSize: 15,
              //       color: ColorsApp.blak50,
              //     )),
            ),
            //##################################################################
            SizedBox(
              height: DimenApp.hightSc(context, hightPy: 0.028),
            ),
            //##################################################################
            /************************************************************************/
            //this menu for  /" Platters "\
            /************************************************************************/

//   width: DimenApp.widthSc(context),
//           height: DimenApp.hightSc(context),

            /************************************************************************/
            // Choice of Suace (radio button)
            /************************************************************************/
            SizedBox(
              width: DimenApp.widthSc(context),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: DimenApp.widthSc(context, widthPy: 0.01),
                        ),
                        AStx(
                          'Choice of Suace',
                          size: 20,
                          isBold: true,
                        ),
                        // AutoSizeText('Choice of Suace',
                        //     style: GoogleFonts.oxygen(
                        //         fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: DimenApp.hightSc(context, hightPy: 0.05),
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: AStx(
                            'Taziki Sauce',
                          ),
                          // Text('Taziki Sauce',
                          //     style: GoogleFonts.oxygen(
                          //       fontSize: 18,
                          //     )),
                          leading: Radio(
                            activeColor: ColorsApp.primColr,
                            value: BestTutorSite.TazikiSauce,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: AStx(
                        'Garlic Sauce',
                        ),
                          // AutoSizeText('Garlic Sauce',
                          //     style: GoogleFonts.oxygen(
                          //       fontSize: 18,
                          //     )

                          // ),
                          leading: Radio(
                            activeColor: ColorsApp.primColr,
                            value: BestTutorSite.GarlicSauce,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title:
                          AStx(
                            'Tahini Sauce ',
                          ),
                          // AutoSizeText(
                          //   'Tahini Sauce ',
                          //   style: GoogleFonts.oxygen(
                          //     fontSize: 18,
                          //   ),
                          // ),
                          leading: Radio(
                            activeColor: ColorsApp.primColr,
                            value: BestTutorSite.TahiniSauce,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    /****************************************************************/
                  ],
                ),
              ),
            ),
            /************************************************************************/
            // Instruction  (text area)
            /************************************************************************/
            SizedBox(
              width: DimenApp.widthSc(context),
              child: Card(
                color: ColorsApp.white1,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: ColorsApp.white,
                    child: TextField(
                      // expands: true,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: ColorsApp.primColr,
                        focusColor: ColorsApp.primColr,
                        labelStyle: GoogleFonts.oxygen(
                          color: ColorsApp.primColr,
                          // decorationStyle:TextDecorationStyle.dotted ,
                        ),
                        border: const OutlineInputBorder(
                            // borderSide: BorderSide(
                            //   width: 0,
                            //   style: BorderStyle.none,
                            //   color: ColorsApp.primColr,
                            // ),
                            // borderRadius: BorderRadius.circular(80.0),
                            ),
                        labelText: 'Instruction',
                        hintText: 'instruction manual！\n\n\n\n\n',
                        focusedBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: ColorsApp.primColr,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: ColorsApp.primColr,
                            width: 2.0,
                          ),
                        ),
                      ),
                      cursorColor: ColorsApp.primColr,

                      minLines: null,
                      // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
            ),
            /************************************************************************/
            //Additional Toppings (checkbox)
            /************************************************************************/
            SizedBox(
              width: DimenApp.widthSc(context),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: DimenApp.widthSc(context, widthPy: 0.01),
                        ),
                        AStx(
                          'Additional Toppings',
                          size: 20,
                          isBold: true,
                        ),
                        // AutoSizeText('Additional Toppings',
                        //     style: GoogleFonts.openSans(
                        //         fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: DimenApp.hightSc(context, hightPy: 0.05),
                    ),
                    Column(
                      children: <Widget>[
                        ...additionalToppings.map((e) => ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AStx(
                                    e.extraName,
                                  ),
                                  AStx(
                                    e.extraPrice,
                                  ),
                                  // AutoSizeText(e.extraName,
                                  //     style: GoogleFonts.oxygen(
                                  //       fontSize: 18,
                                  //     )),
                                  // AutoSizeText(e.extraPrice,
                                  //     style: GoogleFonts.oxygen(
                                  //       fontSize: 18,
                                  //     )),
                                ],
                              ),
                              leading: Checkbox(
                                activeColor: ColorsApp.primColr,
                                value: e.extraStute,
                                onChanged: (bool? value) {
                                  setState(() {
                                    e.extraStute = value!;
                                    if (e.extraStute) {
                                      additionalToppingsChose.add(e.extraName);
                                    } else {
                                      additionalToppingsChose
                                          .remove(e.extraName);
                                    }
                                  });
                                },
                              ),
                            )),
                        // TextButton(
                        //     onPressed: () {
                        //       print(additionalToppingsChose);
                        //     },
                        //     child: const Text('Choice of Suace',
                        //         style: GoogleFonts.oxygen(
                        //             fontSize: 20, fontWeight: FontWeight.bold)))
                      ],
                    ),
                    /****************************************************************/
                  ],
                ),
              ),
            ),
            /************************************************************************/
            //count items  (spinner button)
            /************************************************************************/
            Center(
              child: SizedBox(
                width: DimenApp.widthSc(
                  context,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //     // ++++++
                        //     SizedBox(
                        //       width:88 ,//DimenApp.widthSc(context, widthPy: 0.16),
                        //       height: 60,//DimenApp.hightSc(context, hightPy: 0.084),
                        //       child: Container(
                        //      margin: const EdgeInsets.only(top: 4.5 ),
                        // //for web        margin: const EdgeInsets.only(top: 4.5,bottom: 5),
                        //         decoration: BoxDecoration(
                        //           color: ColorsApp.primColr,
                        //           borderRadius: const BorderRadius.only(
                        //             topLeft: Radius.circular(40),
                        //             bottomLeft: Radius.circular(40),
                        //           ),
                        //           border: Border.all(
                        //             width: 3,
                        //             color: ColorsApp.primColr,
                        //             style: BorderStyle.solid,
                        //           ),
                        //         ),
                        //         child: TextButton(
                        //           onPressed: () {
                        //             if (CountItems < 55) {
                        //               CountItems++;
                        //               controllerCountItems.text =
                        //                   CountItems.toString();
                        //             }
                        //           },
                        //           child: const AutoSizeText('+',
                        //               style: GoogleFonts.oxygen(
                        //                 fontSize: 38,
                        //                 color: Colors.black54,
                        //               )),
                        //         ),
                        //       ),
                        //     ),

                        /********************************************************************/
                        // text filed spinner
                        /********************************************************************/
                        SizedBox(
                          height:
                              DimenApp.hightSc(context, hightPy: 0.13), //128,
                        ),
                        Container(
                          width: DimenApp.widthSc(context, widthPy: 0.6),
                          // 200,
                          // ,
                          height: DimenApp.hightSc(context, hightPy: 0.11),
                          //128,
                          // color: Colors.blue,

                          // margin: const EdgeInsets.only(top: 0, bottom: 2),
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: ColorsApp.white1,
                            child: TextField(
                              controller: controllerCountItems,
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // border: OutlineInputBorder(
                                //     // borderRadius: BorderRadius.circular(10.0),
                                //     ),
                                icon: IconButton(
                                    onPressed: () {
                                      if (CountItems < 55) {
                                        CountItems++;
                                        controllerCountItems.text =
                                            CountItems.toString();
                                      }
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: ColorsApp.primColr,
                                    )),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (CountItems > 1) {
                                      CountItems--;
                                      controllerCountItems.text =
                                          CountItems.toString();
                                    }
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: ColorsApp.primColr,
                                  ),
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            shadowColor: ColorsApp.blak50,
                            elevation: 8,
                          ),
                        ),
                        /****************************************************************/
                        //  // ------
                        //  SizedBox(
                        //    width: 88,//DimenApp.widthSc(context, widthPy: 0.16),
                        //    height: 60,//DimenApp.hightSc(context, hightPy: 0.084),
                        //    child: Container(
                        //      margin: const EdgeInsets.only(top: 4.5 ),
                        // //for web     // margin: const EdgeInsets.only(top: 4.5,bottom: 5),
                        //      decoration: BoxDecoration(
                        //        color: ColorsApp.primColr,
                        //        borderRadius: const BorderRadius.only(
                        //          topRight: Radius.circular(40),
                        //          bottomRight: Radius.circular(40),
                        //        ),
                        //        border: Border.all(
                        //          width: 3,
                        //          color: ColorsApp.primColr,
                        //          style: BorderStyle.solid,
                        //        ),
                        //      ),
                        //
                        //      child: TextButton(
                        //        onPressed: () {
                        //          if (CountItems > 1) {
                        //            CountItems--;
                        //            controllerCountItems.text =
                        //                CountItems.toString();
                        //          }
                        //        },
                        //        child: const AutoSizeText('-',
                        //            style: GoogleFonts.oxygen(
                        //              fontSize: 38,
                        //              color: Colors.black54,
                        //            )),
                        //      ),
                        //    ),
                        //  ),
                      ],
                    ),

                    /****************************************************************/
                  ],
                ),
              ),
            ),
            /************************************************************************/
            //Button add to cart
            /************************************************************************/
            //button 1 Submit
            /************************************************************************/
            Center(
              child: Container(
                height: DimenApp.hightSc(context, hightPy: 0.1),
                width: DimenApp.widthSc(context),
                padding: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                child: SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.08),
                  width: DimenApp.widthSc(context, widthPy: 0.82),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: ColorsApp.primColr,
                      shadowColor: ColorsApp.blak50,
                      elevation: 7,
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PageHome()));
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AStx(
                                'Add to Cart',
                                size: 22,
                                colr: Colors.black54,
                              ),
                              // price item
                              AStx(
                                '\$5.00',
                                size: 17,
                                isBold: true,
                                colr: Colors.black54.withOpacity(0.5),
                              ),
                              // AutoSizeText(
                              //   'Add to Cart',
                              //   style: GoogleFonts.oxygen(
                              //     fontSize: 22,
                              //     color: Colors.black54,
                              //   ),
                              // ),
                              // price item
                              // AutoSizeText('\$5.00',
                              //     style: GoogleFonts.oxygen(
                              //       fontSize: 17,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.black54.withOpacity(0.5),
                              //     )),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            /************************************************************************/
          ],
        ),
      ),
    );
  }
}
