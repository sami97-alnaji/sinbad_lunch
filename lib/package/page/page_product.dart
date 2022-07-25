// ignore_for_file: non_constant_identifier_names, avoid_print, constant_identifier_names, unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
import 'package:sinbad_lunch/package/page/CheckoutPages/order_details.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class Order {
  get_food? plate;
  List<AdditionalTopping>? additional;
  get_suace? suace;
}

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
  // ignore: unused_field

  ///**********************************************************************/

  ///sauce

  var sSc = [];

  var free1Adding = [];
  var free2Adding = [];
  var free3Adding = [];

  var titleFree1 = '';
  var titleFree2 = '';
  var titleFree3 = '';

  String _sauceSelectionId = '';
  String _freeAdding1SelectionId = '';
  String _freeAdding2SelectionId = '';
  String _freeAdding3SelectionId = '';
  double _sauceSelectionPrice = 0;
  get_suace? suaceInfo;
  List<dynamic>? freeAdd1 = [];
  List<dynamic>? freeAdd2 = [];
  List<dynamic>? freeAdd3 = [];
  List<AdditionalToppingg>? addingList = [];

  splitSauce() async {
    var x = await GetAllMenu().get_query_suace(widget.food.food_id!);
    print('widget.food.food_id!  = ' + widget.food.food_id!.toString());
    for (var ss in x) {
      print(ss.suace_id);
      setState(() {
        sSc.add(ss);
      });
      _sauceSelectionId = x[0].suace_id!.toString();
    }
  }

  splitFreeAdding() async {
    var x = widget.food.is_free1 != -1 ||
            widget.food.is_free2 != -1 ||
            widget.food.is_free3 != -1
        ? await GetAllMenu().get_food_Data()
        : [];
    var title = widget.food.is_free1 != -1 ||
            widget.food.is_free2 != -1 ||
            widget.food.is_free3 != -1
        ? await GetAllMenu().get_menu_type_Data()
        : [];
    for (var tt in title) {
      setState(() {
        if (widget.food.is_free1 == tt.menu_type_id) {
          titleFree1 = tt.menu_type_name;
        }
        if (widget.food.is_free2 == tt.menu_type_id) {
          titleFree2 = tt.menu_type_name;
        }
        if (widget.food.is_free3 == tt.menu_type_id) {
          titleFree3 = tt.menu_type_name;
        }
      });
    }
    if (widget.food.is_free1 != -1) {
      for (var ss in x) {
        if (widget.food.is_free1! == ss.menu_type_id) {
          print(ss.menu_type_id);
          setState(() {
            free1Adding.add(ss);
          });
        }
      }
    }

    if (widget.food.is_free2 != -1) {
      for (var ss in x) {
        if (widget.food.is_free2! == ss.menu_type_id) {
          print(ss.menu_type_id);
          setState(() {
            free2Adding.add(ss);
          });
        }
      }
    }

    if (widget.food.is_free3 != -1) {
      // print('splitFreeadding1');

      // print('widget.food.food_id!  = ' + widget.food.food_id!.toString());
      for (var ss in x) {
        if (widget.food.is_free3! == ss.menu_type_id) {
          print(ss.menu_type_id);
          setState(() {
            free3Adding.add(ss);
            // sSc.add(Sauce(
            //   sauceId:ss.suace_id,
            //   sauceName:ss.suace_name ,
            //   saucePrice:ss.price ,
            // ));
          });
        }
      }
    }
  }

  double toPrecision(double n) => double.parse(n.toStringAsFixed(2));

  ///**********************************************************************/

  bool value = false;
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
  double additionsSelectionPrice = 0;

  splitAdditions() async {
    var x = await GetAllMenu().get_additions_Data();
    var l = await GetAllMenu().get_list_additions_Data();
    for (var ll in l) {
      if (widget.food.food_id == ll.food_id) {
        for (var rr in x) {
          if (ll.additions_id == rr.additions_id) {
            print(rr.additions_name);
            setState(() {
              sAd.add(AdditionalTopping(
                additions_id: rr.additions_id,
                extraName: rr.additions_name,
                extraPrice: rr.additions_price ?? 9.9,
                extraStute1: false,
              ));
            });
          }
        }
      }
    }
  }

  Timer? _timer;

  ///**********************************************************************/
  //********************************************************/
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
    fToast = FToast();
    setExtraStute();
    splitAdditions();
    splitSauce();
    splitFreeAdding();
/****************************************************/
    _tryConnectionWAit();
    /****************************************************/
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.show(
      status: 'loading...',
      // maskType: EasyLoadingMaskType.black
    );
    int duration = 1;
    Timer(Duration(seconds: duration), () async {
      if (sAd != []) {
        EasyLoading.dismiss();
        setState(() {
          duration = 0;
        });
      }
      // else {
      //   setState(() {
      //     duration += 1;
      //   });
      // }
      await EasyLoading.dismiss();
    });
  }

  setExtraStute() async {
    List<get_additions> w = await GetAllMenu().get_additions_Data();
    for (var i in w) {
      extraStute.addAll({i.additions_id: false});
    }
  }

  var x = false;
  var isSelection = [];

  int whereIs = 0;
  var hereAm = [];

  /// *************************************/
  late FToast fToast;

  Widget toast(String fMss) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: ColorsApp.blak1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white,),
          const SizedBox(
            width: 12.0,
          ),

          // Flexible(child: AStx( fMss   ,size: 17,)),
          Flexible(
              child: AStx(
            "${fMss} has been added successfully",
            size: 16,
            MLin: 2,
            colr: ColorsApp.white,
          )),
          // const Text("\n"),
        ],
      ),
    );
  }

  // ignore: unused_element
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
          toastDuration: const Duration(seconds: 2),
        );
  }

  /// *********************************************************************/

  TextEditingController? controllerInstruction = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var count;

  /// *********************************************************************/
  @override
  Widget build(BuildContext context) {
    if (_isConnectionSuccessful!) {
      try {
        // FutureBuilderGetAdditions();
        // list_suaces = [];
        int numberOfItems = 0;
        double totalPrice = 0;
        double totalPriceWithOutNum = 0;
        count = Provider.of<ProductPageVariables>(context);
        setState(() {
          numberOfItems =
              int.tryParse(count.controllerCountItems!.text.toString()) ?? 1;
          print('nummm' + numberOfItems.toString());
          // BtnSpinnr.controllerCountItems;
          totalPrice = (widget.food.food_price! +
                  additionsSelectionPrice +
                  _sauceSelectionPrice) *
              numberOfItems;
          totalPrice = toPrecision(totalPrice);
          totalPriceWithOutNum = (widget.food.food_price! +
              additionsSelectionPrice +
              _sauceSelectionPrice);
        });

        return Scaffold(
          drawer: const MyDrawer(),
          appBar: MyAppBar(titel: widget.food.food_name!),
          body: SingleChildScrollView(
            child: GestureDetector(
              onHorizontalDragCancel: () {
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
                      height: DimenApp.hightSc(context, hightPy: 0.28),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.primColr,
                      )),
                    ),
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

                            // هاي بدنا نزبها تحت جنب الكبسة
                            //price item
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 11.0, top: 4.2, right: 11.0),
                              child: AStx(
                                '\$${widget.food.food_price!}',
                                size: 21,
                                colr: ColorsApp.primColr,
                                isBold: true,
                              ),
                            ),
                          ])),
                  //##################################################################
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.022),
                  ),
                  //##################################################################
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AStx(
                      widget.food.food_description?? "",
                      size: 15,
                      colr: ColorsApp.blak50,
                      MLin: 5,
                    ),
                  ),
                  //##################################################################
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.028),
                  ),
                  //##################################################################
                  /************************************************************************/
                  //this menu for  /" Platters "\
                  /************************************************************************/

                  /************************************************************************/
                  // Choice of Suace (radio button)
                  /************************************************************************/
                  choiceOfSuace(),
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
                  additionalToppings(),
                  /************************************************************************/
                  //for free like drink (radio button)
                  /************************************************************************/
                  freePluginFormat(free1Adding, 1, titleFree1),
                  freePluginFormat(free2Adding, 2, titleFree2),
                  freePluginFormat(free3Adding, 3, titleFree3),
                  /************************************************************************/
                  //count items  (spinner button)
                  /************************************************************************/
                  Center(
                    child: SizedBox(
                      width: DimenApp.widthSc(
                        context,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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

                              /********************************************************************/
                              // text filed spinner
                              /********************************************************************/
                              SizedBox(
                                height: DimenApp.hightSc(context,
                                    hightPy: 0.09), //128,
                              ),

                              BtnSpinnr(),

                              /****************************************************************/
                              //  // ------
                            ],
                          ),

                          /****************************************************************/
                        ],
                      ),
                    ),
                  ),
                  /************************************************************************/
                  /************************************************************************/

                  ///alert box

                  // count.note(),
                  // SizedBox(
                  //   height: DimenApp.hightSc(context, hightPy: 0.011), //128,
                  // ),

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
                            // for (var i in additionalToppingsChose) {
                            //   print(
                            //       'additionalToppingsChose   ${i.additions_name}');
                            // }
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
                                    builder: (BuildContext context) =>
                                        PageHome()));

                            // _showBuilderToast();
                            _showToast(widget.food.food_name.toString());
                            print('listAdditionsIsEmpty $listAdditionsIsEmpty');
                            print(widget.food.food_description);
                            /********************************************************************/

                            var itemCard = OrderDetails(
                              itemsId: widget.food.food_id!,
                              itemsName: widget.food.food_name!,
                              itemsImage: widget.food.food_image!,
                              food_description: widget.food.food_description,
                              itemsOfNumber: numberOfItems,
                              itemsTotalPrice: totalPrice,
                              sauceId: suaceInfo != null
                                  ? suaceInfo!.suace_id
                                  : null,
                              sauceName: suaceInfo != null
                                  ? suaceInfo!.suace_name
                                  : null,
                              saucePrice:
                                  suaceInfo != null ? suaceInfo!.price : null,
                              instructon: controllerInstruction != null &&
                                      controllerInstruction!.text
                                          .toString()
                                          .isNotEmpty
                                  ? controllerInstruction!.text.toString()
                                  : null,
                              addingList:
                                  addingList != null && addingList!.isNotEmpty
                                      ? addingList
                                      : null,
                              iSFree1Id:
                                  freeAdd1 != null && freeAdd1!.isNotEmpty
                                      ? freeAdd1![0]
                                      : null,
                              isFree1Name:
                                  freeAdd1 != null && freeAdd1!.isNotEmpty
                                      ? freeAdd1![1]
                                      : null,
                              iSFree2Id:
                                  freeAdd2 != null && freeAdd2!.isNotEmpty
                                      ? freeAdd2![0]
                                      : null,
                              isFree2Name:
                                  freeAdd2 != null && freeAdd2!.isNotEmpty
                                      ? freeAdd2![1]
                                      : null,
                              iSFree3Id:
                                  freeAdd3 != null && freeAdd3!.isNotEmpty
                                      ? freeAdd3![0]
                                      : null,
                              isFree3Name:
                                  freeAdd3 != null && freeAdd3!.isNotEmpty
                                      ? freeAdd3![1]
                                      : null,
                            );
                            bool flagItemCard = false;
                            // count.BasketListItems.add(itemCard);
                            if (count.BasketListItems.isNotEmpty ||
                                count.BasketListItems.length > 0) {
                              for (var i in count.BasketListItems) {
                                if (i.itemsId == itemCard.itemsId &&
                                    i.sauceId == itemCard.sauceId &&
                                    i.iSFree1Id == itemCard.iSFree1Id &&
                                    i.iSFree2Id == itemCard.iSFree2Id &&
                                    i.iSFree3Id == itemCard.iSFree3Id) {
                                  flagItemCard = true;
                                  if (itemCard.addingList != null &&
                                      itemCard.addingList!.isNotEmpty &&
                                      i.addingList!.isNotEmpty &&
                                      itemCard.addingList!.length ==
                                          i.addingList!.length) {
                                    for (int j = 0;
                                        j < itemCard.addingList!.length;
                                        j++) {
                                      if (i[j].idAdditional !=
                                          itemCard
                                              .addingList![j].idAdditional) {
                                        flagItemCard = false;
                                      }
                                    }
                                  }
                                  if (flagItemCard) {
                                    i.itemsTotalPrice += totalPrice;
                                    i.itemsOfNumber += numberOfItems;
                                    print('numberOfItems $numberOfItems');
                                    flagItemCard = true;
                                  }
                                }
                              }
                            }
                            if (!flagItemCard) {
                              count.BasketListItems.add(itemCard);
                            }
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AStx(
                                      'Add to Cart',
                                      size: 22,
                                      colr: Colors.black54,
                                    ),
                                    // price item
                                    AStx(
                                      '\$${totalPrice}',
                                      size: 20,
                                      isBold: true,
                                      colr: Colors.black54.withOpacity(0.5),
                                    ),
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

/*******************************************************************************/
  //get_additions
  /// *****************************************************************************/
  List<get_additions>? additions;

/*******************************************************************************/
  //get_list_additions
  /// *****************************************************************************/
  List<Widget> listAddi = [];
  List<get_list_additions>? listAdditions;
  int listAdditionsIsEmpty = -1;

  Widget buildListAdditions() {
    return ListView.builder(
      itemCount: listAddi.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
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
        return AStx(listSuace.suace_id!.toString());
      },
    );
  }

/*******************************************************************************/

  ///Radio Button
  funSauce({get_food? food, get_suace? su, int? freeNum = 0}) {
    String prc = su != null
        ? (su.price == 0.0 ? 'free' : '\$' + su.price!.toString())
        : "";
    return ListTile(
      title: AStx(
        food == null ? su!.suace_name! : food.food_name!,
        colr: ColorsApp.blakText,
        size: 16,
      ),
      trailing: food == null
          ? AStx(
              prc,
              colr: ColorsApp.primColr,
              size: 16,
            )
          : null,
      leading: Radio(
        activeColor: ColorsApp.primColr,
        value: su != null ? su.suace_id.toString() : food!.food_id.toString(),
        groupValue: freeNum == 0
            ? _sauceSelectionId
            : freeNum == 1
                ? _freeAdding1SelectionId
                : freeNum == 2
                    ? _freeAdding2SelectionId
                    : _freeAdding3SelectionId,
        onChanged: (String? value) {
          setState(() {
            freeNum == 0
                ? _sauceSelectionId = value!
                : freeNum == 1
                    ? _freeAdding1SelectionId = value!
                    : freeNum == 2
                        ? _freeAdding2SelectionId = value!
                        : _freeAdding3SelectionId = value!;
            // ignore: unnecessary_null_comparison
            if (su != null) {
              _sauceSelectionPrice = su.price!;
              suaceInfo = su;
            }
            if (food != null) {
              switch (freeNum) {
                case 1:
                  freeAdd1 != null ? freeAdd1!.clear(): null ;
                  freeAdd1!.add(food.food_id);
                  freeAdd1!.add(food.food_name);
                  print("freeAdd1  :  "+freeAdd1!.length.toString());
                  break;
                case 2:
                  freeAdd2!.add(food.food_id);
                  freeAdd2!.add(food.food_name);

                  break;
                case 3:
                  freeAdd3!.add(food.food_id);
                  freeAdd3!.add(food.food_name);

                  break;
              }
            }
          });
        },
      ),
    );
  }

/*******************************************************************************/
/*******************************************************************************/
////////////////////////////Free plugin format
  freePluginFormat(List freeAdding, int freeNum, String titleFree) {
    return freeAdding.isNotEmpty
        ? SizedBox(
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
                        'Free   $titleFree',
                        colr: ColorsApp.forPass1,
                        size: 19,
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
                    children: [
                      /****************************************************************/

                      ...freeAdding.map(
                        (e) => funSauce(food: e, freeNum: freeNum),
                      ),
                      /****************************************************************/
                    ],
                  ),
                  /****************************************************************/
                ],
              ),
            ),
          )
        : Container();
  }

  /// *****************************************************************************/
  choiceOfSuace() {
    return sSc.isNotEmpty
        ? SizedBox(
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
                        size: 18,
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.05),
                  ),
                  Column(
                    children: [
                      /****************************************************************/

                      ...sSc.map(
                        (e) => funSauce(su: e),
                      ),
                      /****************************************************************/
                    ],
                  ),
                  /****************************************************************/
                ],
              ),
            ),
          )
        : Container();
  }

  /// *****************************************************************************/
  additionalToppings() {
    return sAd.isNotEmpty
        ? SizedBox(
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
                        size: 18,
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.05),
                  ),
                  Column(
                    children: <Widget>[
                      /****************************************************/

                      /****************************************************/

                      ...sAd.map((e) => ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: AStx(
                                    e.extraName,
                                    colr: ColorsApp.blakText,
                                    MLin: 2,
                                    size: 16,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AStx(
                                    '\$' + e.extraPrice.toString(),
                                    colr: ColorsApp.primColr,
                                    MLin: 2,
                                    size: 16,
                                  ),
                                ),
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
                                      additionalToppingsChose
                                          .add(e.additions_id);
                                      additionsSelectionPrice += e.extraPrice;
                                      addingList!.add(AdditionalToppingg(
                                          idAdditional: e.additions_id,
                                          nameAdditional: e.extraName,
                                          priceAdditional: e.extraPrice));
                                    });
                                  } else {
                                    setState(() {
                                      additionalToppingsChose
                                          .remove(e.additions_id);
                                      additionsSelectionPrice -= e.extraPrice;
                                      addingList!.remove(AdditionalToppingg(
                                          idAdditional: e.additions_id,
                                          nameAdditional: e.extraName,
                                          priceAdditional: e.extraPrice));
                                    });
                                  }
                                });
                              },
                            ),
                          )),
                      /***************************************************/
                      // TextButton(
                      //     onPressed: () {
                      //       print(additionalToppingsChose);
                      //       print(additionsSelectionPrice);
                      //       print(controllerInstruction!.text);
                      //     },
                      //     child: Text('Choice of Suace',
                      //         style: GoogleFonts.oxygen(
                      //             fontSize: 20, fontWeight: FontWeight.bold)))
                    ],
                  ),

                  /****************************************************************/
                ],
              ),
            ),
          )
        : Container();
  }
/*******************************************************************************/

/*******************************************************************************/
/*******************************************************************************/

}
