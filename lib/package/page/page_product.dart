// ignore_for_file: non_constant_identifier_names, avoid_print, constant_identifier_names, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/Controller/menu/getAllMenu.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnSpinner.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_additions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_food.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_list_additions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_list_suace.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_suace.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

enum BestTutorSite {
  TahiniSauce, GarlicSauce, TazikiSauce


}

class  Order{
  get_food? plate;
  List<AdditionalTopping>? additional;
  get_suace? suace;

}

// class Sauce{
//   int?sauceId;
// double? saucePrice;
// String? sauceName;
//
// Sauce({this.sauceId,this.saucePrice, this.sauceName});
// }


class AdditionalTopping {
  int? additions_id;
  String? extraName;
  double? extraPrice;
  bool? extraStute1;

  AdditionalTopping({
    this.additions_id,
    this.extraName,
    this.extraPrice,
    this.extraStute1,
  });
}

// ignore: must_be_immutable
class PageProduct extends StatefulWidget {
  PageProduct({required this.food, Key? key}) : super(key: key);

  // String title;
  get_food food;
  // static TextEditingController controllerCountItems = TextEditingController();
  @override
  _PageProductState createState() => _PageProductState();
}

class _PageProductState extends State<PageProduct> {
  BestTutorSite _site = BestTutorSite.TazikiSauce;
  // ignore: unused_field

  ///**********************************************************************/

  ///sauce

  var sSc = [];
   String _sauceSelectionId ='';
   double _sauceSelectionPrice=0;


  splitSauce() async {
    var x=await GetAllMenu().get_query_suace(widget.food.food_id!);
print('widget.food.food_id!  = '+widget.food.food_id!.toString());
    for (var ss in x) {
      print(ss.suace_id);
      setState(() {
        sSc.add(ss);
        // sSc.add(Sauce(
        //   sauceId:ss.suace_id,
        //   sauceName:ss.suace_name ,
        //   saucePrice:ss.price ,
        // ));
      });
      _sauceSelectionId=x[0].suace_id! .toString();
    }
  }
  ///**********************************************************************/
  // var additionalToppings = [
  //   additionalTopping(extraName: 'Add Extra Meat',extraPrice: 1.99, extraStute1: false),
  //   additionalTopping('Calamata', '\$0.75', false),
  //   additionalTopping('Jalapeno', '\$0.75', false),
  //   additionalTopping('Extra Feta Sauce', '\$0.75', false),
  //   additionalTopping('Extra Garlic Sauce', '\$0.75', false),
  //   additionalTopping('Extra Tahini Sauce', '\$0.75', false),
  //   additionalTopping('Extra Taziki Sauce', '\$0.75', false),
  //   additionalTopping('Feta', '\$0.75', false),
  //   additionalTopping('Sriacha', '\$1.00', false),
  //   additionalTopping('Hummus', '\$0.75', false),
  // ];

  bool value = false;

  // List<get_additions> additionalToppingsChose = [];
  var additionalToppingsChose = [];

  /// ********************************************/


  /// *************************************/

  bool isLoading = false;
  int CountItems = 1;
  Map<int?, bool> extraStute = {};
  int additionalnum = -1;

  List<get_list_additions>? list_additions;
  ///**********************************************************************/

  ///additions

  var sAd = [];
  double additionsSelectionPrice=0;

  // FutureBuilderGetAdditions() => FutureBuilder<List<get_additions>>(
  //   future: GetAllMenu().get_additions_Data(),
  //   // if you mean this method well return image url
  //   builder: (BuildContext context1,
  //       AsyncSnapshot<List<get_additions>> snapshot) {
  //     if (snapshot.connectionState == ConnectionState.done) {
  //       additions = snapshot.data;
  //       return splictAdditi(additions);
  //     } else if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const Text("loading ...");
  //     } else {
  //       return Container();
  //     }
  //   },
  // );

  splitAdditions(/*List<get_additions>? additions*/) async {
    var x=await GetAllMenu().get_additions_Data();
    for (var rr in x) {
      print(rr.additions_name);
      setState(() {
        sAd.add(AdditionalTopping(
          additions_id: rr.additions_id,
          extraName: rr.additions_name,
          extraPrice: rr.additions_price??9.9,
          extraStute1: false,
        ));
      });

    }
  }
  ///**********************************************************************/
  @override
  void initState() {
    // BtnSpinnr.controllerCountItems!.text = CountItems.toString();
    fToast = FToast();
    // fToast.init(globalKey.currentState!.context);
    setExtraStute();
    // FutureBuilderGetAdditions();
    splitAdditions();
    splitSauce();
    // set_list_additions();

    // list_suaces = [];
    // GetAllMenuGet_additions_Data();
    super.initState();
  }

  setExtraStute() async {
    List<get_additions> w = await GetAllMenu().get_additions_Data();
    for (var i in w) {
      extraStute.addAll({i.additions_id: false});
    }
    print('sdsdsdsd  $additionalnum');

    // await FutureBuilderGetAdditions();
  }

  var x = false;
  var isSelection = [];

  // GetAllMenuGet_additions_Data() async {
  //   var cv = await GetAllMenu().get_additions_Data(widget.food.food_id!);
  //   var lcv = await GetAllMenu().get_list_additions_Data();
  //   for (var j in cv) {
  //     for (var i in lcv) {
  //       j.stut = false;
  //       // print(' listAdditionsIsEmpty55dd55d5d5 += ${i}  ');
  //       if (i.food_id == widget.food.food_id) {
  //         // listAdditionsIsEmpty += 1;
  //         isSelection.add(false);
  //         if (i.additions_id == j.additions_id) {
  //           setState(() {
  //             listAdditionsIsEmpty = listAdditionsIsEmpty + 1;
  //           });
  //
  //           listAddi.add(ListTile(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 AStx(
  //                   j.additions_name!,
  //                 ),
  //                 AStx(
  //                   j.additions_price!.toString(),
  //                 ),
  //               ],
  //             ),
  //             leading: Checkbox(
  //               activeColor: ColorsApp.primColr,
  //               value: j.stut,
  //               // isSelection[listAdditionsIsEmpty],//extraStute[additionalnum],
  //               onChanged: (bool? value) {
  //                 setState(() {
  //                   x = value!;
  //                   j.stut = value;
  //                   isSelection[listAdditionsIsEmpty] =
  //                       !isSelection[listAdditionsIsEmpty];
  //                   additionalnum = j.additions_id!;
  //                   // print(
  //                   //     ' extraStute[additionalnum]  ${extraStute[additionalnum]}');
  //                   // extraStute[additionalnum] = value!;
  //                   // print(
  //                   //     ' extraStute[additionalnum]Aftr  ${extraStute[additionalnum]}');
  //                   //
  //                   // print(' additionalnum  ${additionalnum}');
  //                   if (j.stut! /*isSelection[listAdditionsIsEmpty]*/) {
  //                     print(
  //                         'j. isSelection[listAdditionsIsEmpty] ${isSelection[listAdditionsIsEmpty]}');
  //
  //                     additionalToppingsChose.add(j);
  //                   } else {
  //                     print('j.stutdddd');
  //                     additionalToppingsChose.remove(j);
  //                   }
  //                 });
  //               },
  //             ),
  //           ));
  //           setState(() {});
  //         }
  //       }
  //     }
  //   }
  // }

  int whereIs = 0;
  var hereAm = [];

  /// *************************************/
  late FToast fToast;

  Widget toast(String fMss) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          const Text("This is a Custom Toast"),
          const Text("\n"),
          Text(fMss),
        ],
      ),
    );
  }

  _showBuilderToast(String fMss) {
    fToast.init(context).showToast(
        child: toast(fMss),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  _showToast(String fMss) {
    fToast.init(context).showToast(
          child: toast(fMss),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 8),
        );
  }

  /// *********************************************************************/




  TextEditingController? controllerInstruction = TextEditingController();



  /// *********************************************************************/
  @override
  Widget build(BuildContext context) {
    // FutureBuilderGetAdditions();
    // list_suaces = [];
    int num=0;
    double total=0;
    var count=Provider.of<ProductPageVariables>(context);
setState(() {
  num=int.tryParse(count.controllerCountItems!.text.toString())??1;
  print('nummm'+num.toString());
  // BtnSpinnr.controllerCountItems;
  total=(widget.food.food_price!+additionsSelectionPrice+_sauceSelectionPrice)*num;
});

    return Scaffold(
        drawer: const MyDrawer(),
        appBar: MyAppBar(titel: widget.food.food_name!),
        body: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragCancel: (){
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.025),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.food.food_image!,
                    fit: BoxFit.fitHeight,
                    height: DimenApp.hightSc(context, hightPy: 0.35),
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: ColorsApp.primColr,
                    )),
                  ),

                  // Image.asset(
                  //   ImageApp.imGyro,
                  //   height: DimenApp.hightSc(context, hightPy: 0.4),
                  // ),
                ),
                // title item
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //name item
                          Expanded(
                            child: AStx(
                              widget.food.food_name!,
                              colr: ColorsApp.forPass1,
                              size: 24,

                              isBold: true,
                            ),
                          ),
                          // AutoSizeText('Chicken Kabob',
                          //     style: GoogleFonts.oxygen(
                          //         color: ColorsApp.blak1,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold)),

                          // هاي بدنا نزبها تحت جنب الكبسة
                          //price item
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0,top: 4.2,right: 11.0),
                            child: AStx('\$${widget.food.food_price!}',
                               size: 22,colr: ColorsApp.primColr,
                            isBold: true,
                              ),
                          ),
                        ])),
                //##################################################################
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.028),
                ),
                //##################################################################
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AStx(
                    widget.food.food_description!,
                    size: 15,
                    colr: ColorsApp.blak50,
                    MLin: 3,
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
                              'Choice of Sauce',
                              colr: ColorsApp.forPass1,
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
                          children:  [
                            /****************************************************************/


                            ...sSc.map((e) =>funSauce(e )
                            , ),
                            /****************************************************************/
                            // ListTile(
                            //   title: AStx(
                            //     'Taziki Sauce',
                            //     colr: ColorsApp.blakText,
                            //   ),
                            //   // Text('Taziki Sauce',
                            //   //     style: GoogleFonts.oxygen(
                            //   //       fontSize: 18,
                            //   //     )),
                            //   trailing:  AStx('01.2'),
                            //   leading: Radio(
                            //     activeColor: ColorsApp.primColr,
                            //     value: BestTutorSite.TazikiSauce,
                            //     groupValue: _site,
                            //     onChanged: (BestTutorSite? value) {
                            //       setState(() {
                            //         _site = value!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            // ListTile(
                            //   title: AStx(
                            //     'Garlic Sauce',
                            //     colr: ColorsApp.blakText,
                            //   ),
                            //   // AutoSizeText('Garlic Sauce',
                            //   //     style: GoogleFonts.oxygen(
                            //   //       fontSize: 18,
                            //   //     )
                            //
                            //   // ),
                            //   leading: Radio(
                            //     activeColor: ColorsApp.primColr,
                            //     value: BestTutorSite.GarlicSauce,
                            //     groupValue: _site,
                            //     onChanged: (BestTutorSite? value) {
                            //       setState(() {
                            //         _site = value!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            // ListTile(
                            //   title: AStx(
                            //     'Tahini Sauce ',
                            //     colr: ColorsApp.blakText,
                            //   ),
                            //   // AutoSizeText(
                            //   //   'Tahini Sauce ',
                            //   //   style: GoogleFonts.oxygen(
                            //   //     fontSize: 18,
                            //   //   ),
                            //   // ),
                            //   leading: Radio(
                            //     activeColor: ColorsApp.primColr,
                            //     value: BestTutorSite.TahiniSauce,
                            //     groupValue: _site,
                            //     onChanged: (BestTutorSite? value) {
                            //       setState(() {
                            //         _site = value!;
                            //       });
                            //     },
                            //   ),
                            // ),
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
                          controller: controllerInstruction,
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
                              colr: ColorsApp.forPass1,
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
                            /****************************************************/
                            // // listAdditionsIsEmpty!=-1?
                            // // FutureBuilderGetAdditions(),
                            //
                            // // ListView.builder(
                            // //   shrinkWrap: true,
                            // //   itemCount: listAddi.length,
                            // //   physics: const NeverScrollableScrollPhysics(),
                            // //   // scrollDirection: Axis.horizontal,
                            // //   itemBuilder: (context, index) {
                            // //     // final list_addition = list_additions[index];
                            // //     return listAddi[index];
                            // //   },
                            // // ),
                            //
                            // ...listAddi.map((e) => e),
                            /****************************************************/

                            ...sAd.map((e) =>
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: AStx(
                                      e.extraName,
                                      colr: ColorsApp.blakText,
                                      MLin: 2,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AStx(
                                      '\$'+ e.extraPrice.toString(),
                                         colr: ColorsApp.primColr,
                                      MLin: 2,
                                    ),
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
                                value: e.extraStute1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    e.extraStute1 = value!;
                                    if (e.extraStute1) {
                                      setState(() {
                                        additionalToppingsChose.add(e.additions_id);
                                        additionsSelectionPrice+=e.extraPrice;
                                      });

                                    } else {
                                      setState(() {
                                        additionalToppingsChose
                                            .remove(e.additions_id);
                                        additionsSelectionPrice-=e.extraPrice;
                                      });

                                    }
                                  });
                                },
                              ),
                            )),
                            /***************************************************/
                            TextButton(
                                onPressed: () {
                                  print(additionalToppingsChose);
                                  print(additionsSelectionPrice);
                                  print( controllerInstruction!.text );

                                },
                                child:  Text('Choice of Suace',
                                    style: GoogleFonts.oxygen(
                                        fontSize: 20, fontWeight: FontWeight.bold)))
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

                            BtnSpinnr(
                              // controllerCountItems:  controllerCountItems,
                            ),

                            // Container(
                            //   width: DimenApp.widthSc(context, widthPy: 0.6),
                            //   // 200,
                            //   // ,
                            //   height:80, //DimenApp.hightSc(context, hightPy: 0.11),
                            //   //128,
                            //   // color: Colors.blue,
                            //
                            //   // margin: const EdgeInsets.only(top: 0, bottom: 2),
                            //   padding: const EdgeInsets.all(10),
                            //   child: Card(
                            //     color: ColorsApp.white1,
                            //     child: TextField(
                            //       controller: controllerCountItems,
                            //       readOnly: true,
                            //       textAlign: TextAlign.center,
                            //       decoration: InputDecoration(
                            //         border: InputBorder.none,
                            //         // border: OutlineInputBorder(
                            //         //     // borderRadius: BorderRadius.circular(10.0),
                            //         //     ),
                            //         icon: IconButton(
                            //             onPressed: () {
                            //               if (CountItems < 55) {
                            //                 CountItems++;
                            //                 controllerCountItems.text =
                            //                     CountItems.toString();
                            //               }
                            //             },
                            //             icon: FaIcon(
                            //               FontAwesomeIcons.plus,
                            //               color: ColorsApp.primColr,
                            //             )),
                            //         suffixIcon: IconButton(
                            //           onPressed: () {
                            //             if (CountItems > 1) {
                            //               CountItems--;
                            //               controllerCountItems.text =
                            //                   CountItems.toString();
                            //             }
                            //           },
                            //           icon: FaIcon(
                            //             FontAwesomeIcons.minus,
                            //             color: ColorsApp.primColr,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(18.0),
                            //     ),
                            //     shadowColor: ColorsApp.blak50,
                            //     elevation: 8,
                            //   ),
                            // ),

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
                          for (var i in additionalToppingsChose) {
                            print('additionalToppingsChose   ${i.additions_name}');
                          }
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => PageHome()));
                          // Fluttertoast.showToast(
                          //     msg: "This is Center Short Toast",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     // gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 5,
                          //     backgroundColor: Colors.green.shade600.withOpacity(0.7),
                          //     textColor: Colors.white,
                          //     fontSize: 16.0,
                          // );

                          // _showBuilderToast();
                          _showToast(count.controllerCountItems!.text.toString());
                          print('listAdditionsIsEmpty $listAdditionsIsEmpty');
                          print(widget.food.food_id);
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
                                    '\$$total',
                                    size: 20,
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
        ),
      )
    ;

  }

/*******************************************************************************/
  //get_additions
  /// *****************************************************************************/
  List<get_additions>? additions;



//   Widget buildAdditions(List<get_additions>? additions) {
//     return ListView.builder(
//       shrinkWrap: true,
// //menu_type_id
//       itemCount: additions!.length,
//       physics: const BouncingScrollPhysics(),
//       // scrollDirection:Axis.vertical,
//       itemBuilder: (context, index) {
//         final addition = additions[index];
//         additionalnum = addition.additions_id!;
//         print(' listAdditions += ${listAdditions!.length}  ');
//         for (var i = listAdditions!.length - 1; i >= 0; i--) {
//           // print(' listAdditionsIsEmpty55dd55d5d5 += ${i}  ');
//           if (listAdditions![i].food_id == widget.food.food_id) {
//             // listAdditionsIsEmpty += 1;
//
//             if (listAdditions![i].additions_id == addition.additions_id) {
//               // listAdditionsIsEmpty = listAdditionsIsEmpty + 1;
//
//               listAddi.add(ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     AStx(
//                       addition.additions_name! + 'dsd',
//                       colr: ColorsApp.blakText,
//                     ),
//                     AStx(
//                       addition.additions_price!.toString() + 'dsd',
//                       colr: ColorsApp.blakText,
//                     ),
//                   ],
//                 ),
//                 leading: Checkbox(
//                   activeColor: ColorsApp.primColr,
//                   value: extraStute[additionalnum],
//                   onChanged: (bool? value) {
//                     setState(() {
//                       additionalnum = addition.additions_id!;
//                       print(
//                           ' extraStute[additionalnum]  ${extraStute[additionalnum]}');
//                       extraStute[additionalnum] = value!;
//                       print(
//                           ' extraStute[additionalnum]Aftr  ${extraStute[additionalnum]}');
//
//                       print(' additionalnum  $additionalnum');
//                       if (extraStute[additionalnum]!) {
//                         additionalToppingsChose.add(addition);
//                       } else {
//                         additionalToppingsChose.remove(addition);
//                       }
//                     });
//                   },
//                 ),
//               ));
//             }
//           }
//         }
//
//         // for(var i in listAddi) {
//         //   return i;
//         // }
//         return Container();
//       },
//     );
//   }




/*******************************************************************************/
  //get_list_additions
  /// *****************************************************************************/
  List<Widget> listAddi = [];
  List<get_list_additions>? listAdditions;
  int listAdditionsIsEmpty = -1;

  // set_list_additions() async {
  //   List<get_list_additions>? listAdditions1 =
  //       await GetAllMenu().get_list_additions_Data();
  //   setState(() {
  //     listAdditions = listAdditions1;
  //   });
  // }

  Widget buildListAdditions() {
    // FutureBuilderGetAdditions();
    return ListView.builder(
      itemCount: listAddi.length,
      physics: const BouncingScrollPhysics(),
      // scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        // final list_addition = list_additions[index];
        return listAddi[index];
      },
    );
  }

/*******************************************************************************/
//get_suace
  /// *****************************************************************************/
  List<get_suace>? suaces;

  FutureBuilderGetSuace() => FutureBuilder<List<get_suace>>(
        future: GetAllMenu().get_suace_Data(),
        // if you mean this method well return image url
        builder:
            (BuildContext context1, AsyncSnapshot<List<get_suace>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            suaces = snapshot.data;
            return buildSuace(suaces);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading ...");
          } else {
            return Container();
          }
        },
      );

  Widget buildSuace(List<get_suace>? suaces) {
    return ListView.builder(
      shrinkWrap: true,
//menu_type_id
      itemCount: suaces!.length,
      physics: const BouncingScrollPhysics(),
      // scrollDirection:Axis.vertical,
      itemBuilder: (context, index) {
        final suace = suaces[index];

        return Text(suace.suace_name!);

        //   Card(
        //   child: Row(
        //       children:
        //       [
        //         Column(
        //           children: [
        //             AStx(food.food_id!.toString(),MLin: 2,),
        //             AStx(food.kitchen_id!.toString(),MLin: 2,),
        //             AStx(food.food_name!.toString(),MLin: 2,),
        //             AStx(food.food_description!.toString(),MLin: 2,),
        //             AStx(food.food_image!.toString(),MLin: 2,),
        //             AStx(food.food_price!.toString(),MLin: 2,),
        //           ],
        //         ),
        //       ]
        //   ),
        // );
      },
    );
  }

/*******************************************************************************/

  //get_list_suace
  /// *****************************************************************************/
  List<get_list_suace>? list_suaces;

  FutureBuilderGet_menu_type() => FutureBuilder<List<get_list_suace>>(
        future: GetAllMenu().get_list_suace_Data(),
        // if you mean this method well return image url
        builder: (BuildContext context,
            AsyncSnapshot<List<get_list_suace>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            list_suaces = snapshot.data;
            return buildMenuType(list_suaces);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading ...");
          } else {
            return Container();
          }
        },
      );

  Widget buildMenuType(List<get_list_suace>? listSuaces) {
    return ListView.builder(
      itemCount: listSuaces!.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final listSuace = listSuaces[index];
        return Text(listSuace.suace_id!.toString());
      },
    );
  }
/*******************************************************************************/
///Radio Button
funSauce(get_suace su) {
  String prc=  su.price == 0.0 ? 'free':'\$'+su.price!.toString();
  return ListTile(
  title: AStx(
    su.suace_name!,
    colr: ColorsApp.blakText,
  ),
  // Text('Taziki Sauce',
  //     style: GoogleFonts.oxygen(
  //       fontSize: 18,
  //     )),
  trailing:  AStx(prc,colr: ColorsApp.primColr),
  leading: Radio(
    activeColor: ColorsApp.primColr,
    value: su.suace_id.toString(),
    groupValue: _sauceSelectionId,
    onChanged: (String? value ) {
          setState(() {
            _sauceSelectionId = value!;
            _sauceSelectionPrice=su.price!;
          });
        },
  ),
);
}


/*******************************************************************************/

}
