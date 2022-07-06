// ignore_for_file: avoid_print, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/Controller/user/get_all_user_info.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btn_menu_iitems.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/components/save_info/shared_preference.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_Checkout.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class PageBasket extends StatefulWidget {
  const PageBasket({Key? key}) : super(key: key);

  @override
  State<PageBasket> createState() => _PageBasketState();
}

class _PageBasketState extends State<PageBasket> {
  /// *************************************/
  bool falgScreen = false;

  /// *************************************/
  // ignore: prefer_typing_uninitialized_variables
  var itemsOrder;

  // ignore: prefer_typing_uninitialized_variables
  var compInfoDelt;

  getCompInfo() async {
    var compInfo = await GetAllUserInfo().compInfo(
        email: UserInfoPreferences.GetEmail()!,
        password: UserInfoPreferences.GetPassword()!);
    setState(() {
      compInfoDelt = compInfo;
    });
  }

  /// *************************************/
  /// *************************************/
  bool isLoading = false;
  bool isLoadingg = false;

  // var comp_name = "";
  // var comp_adderss = "";
  // var delivery_fee = "";
  // var request_start_time = "";
  // var request_time_out = "";
  // var delivery_time = "";
  // var Delivery_Limit = "";
  // var delivery_status = "";
  // var time_date = "";

  // setCompData() {
  //   comp_name = compInfoDelt["comp_name"];
  //   comp_adderss = compInfoDelt["comp_adderss"];
  //   delivery_fee = compInfoDelt["delivery_fee"];
  //   request_start_time = compInfoDelt["request_start_time"];
  //   request_time_out = compInfoDelt["request_time_out"];
  //   delivery_time = compInfoDelt["delivery_time"];
  //   Delivery_Limit = compInfoDelt["Delivery_Limit"];
  //   delivery_status = compInfoDelt["delivery_status"];
  //   time_date = compInfoDelt["time_date"];
  //   date_time = compInfoDelt["date_time"];
  // }
  /// *************************************/
  Timer? _timer;
  double? _tax,
      _deliveryFee,
      _discount,
      _discountPrice,
      _totalPriceFood,
      _totalPriceWithTax;

  @override
  void initState() {
    super.initState();
    _tryConnectionWAit();
    getCompInfo();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    int duration = 1;
    Timer(Duration(seconds: duration), () async {
      await EasyLoading.dismiss();

      await EasyLoading.dismiss();
    });
    /*****************************************/
    _tax = 0;
    _deliveryFee = 0;
    _discount = 0;
    _totalPriceFood = 0;
    _discountPrice = 0;
    _totalPriceWithTax = 0;
    /*****************************************/
    // EasyLoading.showProgress(0.3, status: 'downloading...');
  }

  /// *************************************/
  var itemsMenu = [];

  /// *************************************/
  int ii = 0;
  var addin = "";
  //********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful = true;

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

  double toPrecision(double n) => double.parse(n.toStringAsFixed(2));
  /***************************************************************************/
  @override
  Widget build(BuildContext context) {
    try {
      if (_isConnectionSuccessful!) {
        if (falgScreen) {
          itemsOrder = Provider.of<ProductPageVariables>(context);
          double totalFood = 0;
          if (itemsOrder.BasketListItems != null &&
              itemsOrder.BasketListItems != []) {
            for (var x in itemsOrder.BasketListItems) {
              setState(() {
                totalFood += (x.itemsTotalPrice);
              });
            }
          }
          setState(() {
            try {
              itemsOrder.BasketListItems;
              /*****************************************/
              _tax = totalFood == 0
                  ? 0.0
                  : double.tryParse(compInfoDelt["tax"]) ?? 0.0;
              _deliveryFee = totalFood == 0
                  ? 0.0
                  : double.tryParse(compInfoDelt["delivery_fee"]) ?? 0.0;
              _discount = totalFood == 0
                  ? 0.0
                  : double.tryParse(compInfoDelt["discount"]) ?? 0.0;
              _totalPriceFood = totalFood;
              totalFood = toPrecision(totalFood);
              _totalPriceFood = toPrecision(_totalPriceFood!);
              _discountPrice =
                  totalFood == 0 ? 0.0 : _discount! * _totalPriceFood!;
              _totalPriceWithTax = totalFood == 0
                  ? 0.0
                  : (((_totalPriceFood! - _discountPrice!) +
                          ((_totalPriceFood! - _discountPrice!) * _tax!))) +
                      _deliveryFee!;
              _totalPriceWithTax = toPrecision(_totalPriceWithTax!);
            } on FormatException catch (e) {
              print('data is not valid');
              print(e);
            }
            /*****************************************/
          });

          return Scaffold(
            // appBar: MyAppBar(titel: 'Basket'),
            body: Container(
              color: ColorsApp.primColr,
              height: DimenApp.hightSc(
                context,
              ),
              width: DimenApp.widthSc(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //header in page "My Cart"
                    SizedBox(
                      height:65,
                      child: Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: AStx(
                          'My Cart',
                          isBold: true,
                          colr: ColorsApp.white1,
                        ),
                      ),
                    ),
                    //Main header in page
                    Container(
                      height: DimenApp.hightSc(context, hightPy: 0.96),
                      // color: ColorsApp.grey,
                      child: Column(
                        children: [
                          //it is selected items
                          /************************************************************************/

                          SizedBox(
                            width: DimenApp.widthSc(context),
                            height: DimenApp.hightSc(context, hightPy: 0.44),
                            // color: ColorsApp.red1,
                            child: SingleChildScrollView(
                              // color: ColorsApp.white1,
                              child: Container(
                                // color: ColorsApp.blak1,
                                child: itemsOrder.BasketListItems != null &&
                                        itemsOrder.BasketListItems != []
                                    ? Column(
                                        children: [
                                          ...itemsOrder.BasketListItems.map(
                                            (e) => btnMenuItems(
                                                op: e,
                                                imageItem: e.itemsImage,
                                                nameItem: e.itemsName,
                                                titelItem: e.food_description,
                                                pricceItem: e.itemsTotalPrice,
                                                numm: e.itemsOfNumber,
                                                isAdd: true,
                                                // height:0.15,
                                                onTab: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (BuildContext context) =>
                                                  //             PageProduct(
                                                  //                 title: e.nameItem)));
                                                }),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                decoration: BoxDecoration(
                                  color: ColorsApp.white1,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    // bottomRight: Radius.circular(40.0),
                                    topLeft: Radius.circular(40.0),
                                    // bottomLeft: Radius.circular(40.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /************************************************************************/
                          //Speas Color
                          Container(
                            color: ColorsApp.grey,
                            height: DimenApp.hightSc(context, hightPy: 0.01),
                          ),
                          /************************************************************************/
                          //Total
                          SizedBox(
                            width: DimenApp.widthSc(context),
                            height: 50,
                            // DimenApp.hightSc(context, hightPy: 0.17),
                            child: Card(
                              color: ColorsApp.white1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: ColorsApp.blak1,
                                ),
                                // borderRadius:  BorderRadius.only(
                                //   topRight: Radius.circular(40.0),
                                //   bottomRight: Radius.circular(40.0),
                                //   topLeft: Radius.circular(40.0),
                                //   bottomLeft: Radius.circular(40.0),
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        AStx('Total Food ',
                                            colr: ColorsApp.blak1,
                                            size: 14,
                                            isBold: true),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        AStx('\$${_totalPriceFood!}',
                                            colr: ColorsApp.blak1,
                                            size: 13,
                                            isBold: true),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          /************************************************************************/
                          //Speas Color
                          Container(
                            color: ColorsApp.grey,
                            height: DimenApp.hightSc(context, hightPy: 0.01),
                          ),
                          // Location and time
                          /************************************************************************/
                          //Company information and delivery time
                          Card(
                            color: ColorsApp.white1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // borderRadius:  BorderRadius.only(
                              //   topRight: Radius.circular(40.0),
                              //   bottomRight: Radius.circular(40.0),
                              //   topLeft: Radius.circular(40.0),
                              //   bottomLeft: Radius.circular(40.0),
                              // ),
                            ),
                            child: SizedBox(
                              width: DimenApp.widthSc(context),
                              height: 88,
                              // DimenApp.hightSc(context, hightPy: 0.155),
                              // color: ColorsApp.white1,
                              child: Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: AStx(
                                            'Company : ' +
                                                compInfoDelt["comp_name"]
                                                    .toString(),
                                          )),
                                          Flexible(
                                            child: AStx(
                                              'Location : ' +
                                                  compInfoDelt["comp_adderss"]
                                                      .toString(),
                                              MLin: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: AStx(
                                            'Delivery Time ',
                                          )),
                                          Flexible(
                                              child: AStx(
                                                  compInfoDelt["time_date"] ??
                                                      "")),
                                          Flexible(
                                              child: AStx(
                                            'delivery Date ',
                                          )),
                                          Flexible(
                                              child: AStx(
                                                  compInfoDelt["date_time"] ??
                                                      "")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.014),
                          ),

                          //button 1 Submit
                          /************************************************************************/
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              //button 1 Submit
                              /************************************************************************/
                              Flexible(
                                child: Center(
                                  child: Container(
                                    height: DimenApp.hightSc(context,
                                        hightPy: 0.1),
                                    width: DimenApp.widthSc(context,widthPy: 0.36),
                                    padding: const EdgeInsets.only(bottom: 0),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: DimenApp.hightSc(context,
                                          hightPy: 0.066),
                                      width: DimenApp.widthSc(context,
                                          widthPy: 0.82),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          primary: ColorsApp.blak1,
                                          shadowColor: ColorsApp.blak50,
                                          elevation: 7,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          setState(() {
                                            isLoading = false;
                                          });

                                          // ignore: unnecessary_null_comparison
                                          print("comp_name" +
                                                      compInfoDelt![
                                                          "delivery_status"] ==
                                                  null
                                              ? ""
                                              : compInfoDelt[
                                                  "delivery_status"]);
                                          if (itemsOrder.BasketListItems !=
                                                  null &&
                                              compInfoDelt['delivery_status'] ==
                                                  'Open' &&
                                              itemsOrder
                                                      .BasketListItems.length >
                                                  0) {
                                            setMessage(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const Page_Checkout()));
                                          } else {
                                            setMessage(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PageHome()));
                                          }
                                        },
                                        child: (isLoading)
                                            ? const SizedBox(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 1.5,
                                                ))
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AStx(
                                                    'Go to Checkout',
                                                    size: 10,
                                                    colr: ColorsApp.white1,
                                                  ),
                                                  // price item
                                                  // AStx(
                                                  //   '\$5.00',
                                                  //   size: 17,
                                                  //   isBold: true,
                                                  //   colr: Colors.black54.withOpacity(0.5),
                                                  // ),
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
                              ),
                              /************************************************************************/
                              const SizedBox(
                                width: 15,
                              ),
                              /************************************************************************/
                              //button 1 Add more...
                              /************************************************************************/
                              Flexible(
                                child: Center(
                                  child: Container(
                                    height: DimenApp.hightSc(context,
                                        hightPy: 0.07),
                                    width: DimenApp.widthSc(context),
                                    padding: const EdgeInsets.only(bottom: 0),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: DimenApp.hightSc(context,
                                          hightPy: 0.061),
                                      width: DimenApp.widthSc(context,
                                          widthPy: 0.7),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          primary: ColorsApp.blak1,
                                          shadowColor: ColorsApp.blak50,
                                          elevation: 7,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            isLoadingg = true;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          setState(() {
                                            isLoadingg = false;
                                          });

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PageHome()));
                                        },
                                        child: (isLoadingg)
                                            ? const SizedBox(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 1.5,
                                                ))
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AStx(
                                                    'Add More...',
                                                    size: 11,
                                                    colr: ColorsApp.white1,
                                                  ),
                                                  // price item
                                                  // AStx(
                                                  //   '\$5.00',
                                                  //   size: 17,
                                                  //   isBold: true,
                                                  //   colr: Colors.black54.withOpacity(0.5),
                                                  // ),
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
                              ),
                              /************************************************************************/
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          /************************************************************************/
                          const SizedBox(
                            height: 65,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: ColorsApp.grey,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          // bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                          // bottomLeft: Radius.circular(40.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(child: Text('Basket'),),
          );
        } else {
          Future.delayed(const Duration(milliseconds: 1300), () {
// Here you can write your code

            setState(() {
              falgScreen = true;
            });
          });
          //output-94702-loader-place-holder-animation.gif
          return Scaffold(
            body: Container(
              color: ColorsApp.primColr,
              child: CachedNetworkImage(
                height: double.infinity,
                imageUrl:
                    "https://sinbadslunch.com/myBackENd/gif/output-94702-loader-place-holder-animation.gif",
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: ColorsApp.primColr,
                )),
              ),
            ),
          );
        }
      } else {
        return Center(
          child: AStx('Not connected to any network'),
        );
      }
    } on Exception catch (_) {
      print("throwing new error");

      throw Center(
        child: AStx('Wait a moment please'),
      );
    }
  }

  setMessage(BuildContext context) {
    // setCompData();
    if (compInfoDelt['messg_d'] != null) {
      getCompInfo();
      print(compInfoDelt['time_date'].toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: AStx(compInfoDelt['messg_d'].toString())),
      );
    }
  }

  SplitAddin(var L) {
    if (L == null) {
      var line = "";
      for (var i = 0; i < L.length; i++) {
        line += L[i].nameAdditional;
      }

      return line;
    } else {
      return "";
    }
  }
}
