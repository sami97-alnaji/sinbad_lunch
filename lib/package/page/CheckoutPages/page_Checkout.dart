// ignore: file_names
// ignore_for_file: camel_case_types, avoid_prin, slash_for_doc_commentst, slash_for_doc_comments

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/Controller/Order/order_save.dart';
import 'package:sinbad_lunch/Controller/user/get_all_user_info.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/simple_filed.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/components/save_info/shared_preference.dart';
import 'package:sinbad_lunch/package/page/auth/main_test_paymaent.dart';

class Page_Checkout extends StatefulWidget   {
  const Page_Checkout({Key? key}) : super(key: key);

  @override
  State<Page_Checkout> createState() => _Page_CheckoutState();
}

class _Page_CheckoutState extends State<Page_Checkout> {
  final TextEditingController _controllerTip = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var itemsOrder;

  // ignore: prefer_typing_uninitialized_variables
  var orderInfo;
  late FToast fToast;
  /********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful = true;

  // ignore: prefer_typing_uninitialized_variables
  var compInfoDelt;

  bool isLoading = false;

  bool falgScreen = false;

  getCompInfo() async {
    var compInfo = await GetAllUserInfo().compInfo(
        email: UserInfoPreferences.GetEmail()!,
        password: UserInfoPreferences.GetPassword()!);
    setState(() {
      compInfoDelt = compInfo;
    });
  }

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

  double? _tax,
      _taxAmount,
      _deliveryFee,
      _discount,
      _tip,
      _discountPrice,
      _totalPriceFood,
      _totalPriceWithTax,
      _totalPriceWithTaxAndTip;

  Timer? _timer;
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
                "${fMss} ",
                size: 16,
                MLin: 2,
                colr: ColorsApp.white,
              )),
          // const Text("\n"),
        ],
      ),
    );
  }
  _showToast(String fMss) {
    fToast.init(context).showToast(
      child: toast(fMss),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/
    getCompInfo();
    /*****************************************/
    fToast = FToast();
    /*****************************************/
    _tax = 0;
    _deliveryFee = 0;
    _discount = 0;
    _totalPriceFood = 0;
    _discountPrice = 0;
    _totalPriceWithTax = 0;
    _totalPriceWithTaxAndTip = 0;

  }

  double toPrecision(double n) => double.parse(n.toStringAsFixed(2));

  /***************************************************************************/
//Do you want to leave some tips?
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    try {
      if (_isConnectionSuccessful!) {
        if (falgScreen) {

          /*****************************************/
          if(itemsOrder == null && compInfoDelt["tax"] != null) {
            // final paymentController = Get.put(PaymentController());
            itemsOrder = Provider.of<ProductPageVariables>(context);
            double totalFood = 0;
            if (itemsOrder.BasketListItems != null &&
                itemsOrder.BasketListItems != []) {
              for (var x in itemsOrder.BasketListItems) {
                totalFood += x.itemsTotalPrice;
              }
            }
            print("after the total food is");
            setState(() {
              print("the total food is not null");
              itemsOrder.BasketListItems;
              totalFood = toPrecision(totalFood);
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
              _discountPrice =
              totalFood == 0 ? 0.0 : _discount! * _totalPriceFood!;
              print(totalFood);
              _totalPriceWithTax = totalFood == 0
                  ? 0.0
                  : (((_totalPriceFood! - _discountPrice!) +
                  ((_totalPriceFood! - _discountPrice!) * _tax!))) +
                  _deliveryFee!;

              _totalPriceWithTax = toPrecision(_totalPriceWithTax!);
              _totalPriceWithTaxAndTip = _totalPriceWithTax;
              _taxAmount= _totalPriceWithTax! - _totalPriceFood!;
              _taxAmount = toPrecision(_taxAmount!);
              /*****************************************/
            });
            /*****************************************/
          }
          /*******************************************************************************/
          return Scaffold(
            body: Container(
              height: DimenApp.hightSc(context),
              width: DimenApp.widthSc(context),
              color: ColorsApp.primColr,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //header in page "Checkout"
                    SizedBox(
                      height: 75,
                      child: Container(
                        padding: const EdgeInsets.only(top: 35),
                        child: AStx(
                          'Checkout',
                          colr: ColorsApp.white1,
                          size: 16,
                        ),
                      ),
                    ),

                    Container(
                      height: DimenApp.hightSc(context, hightPy: 0.9),
                      color: ColorsApp.grey,
                      child: Column(
                        children: [
                          /*******************************************************************/
                          const SizedBox(
                            height: 2,
                          ),

                          CachedNetworkImage(
                            height: 110,
                            imageUrl:
                                "https://sinbadslunch.com/myBackENd/gif/output-108096-illustration-thank-you.gif",
                            // fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: ColorsApp.primColr,
                            )),
                          ),



                          const SizedBox(
                            height: 12,
                          ),
                          /*******************************************************************/

                          //info message

                          Card(
                            color: Colors.grey.withOpacity(0.5),
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
                              height: 75,
                              // DimenApp.hightSc(context, hightPy: 0.155),
                              // color: ColorsApp.white1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.5, left: 2.5, right: 2.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            height: 60,
                                            imageUrl:
                                                "https://sinbadslunch.com/myBackENd/gif/output50537-dott.gif",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                              color: ColorsApp.primColr,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 13,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Flexible(
                                              child: AStx(
                                            'Contactless delivery',
                                            size: 16,
                                            isBold: true,
                                            colr: ColorsApp.blak50
                                                .withOpacity(0.8),
                                          )),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Flexible(
                                              child: AStx(
                                            'We place the order in the designated place',
                                            size: 13,
                                            isBold: true,
                                            colr: ColorsApp.blak50
                                                .withOpacity(0.8),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: ColorsApp.grey,
                            height: DimenApp.hightSc(context, hightPy: 0.01),
                          ),
/************************************************************************************/
                          //Total
                          SizedBox(
                            width: DimenApp.widthSc(context),
                            height:158,
                            // DimenApp.hightSc(context, hightPy: 0.17),
                            child: Card(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      AStx(
                                        'Total Food :',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      AStx(
                                        'Delivery fee : ',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      AStx(
                                        'Discount : ',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        height: 5.7,
                                      ),
                                      AStx(
                                        'Tip : ',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AStx(
                                        'Tax : ',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      AStx('Total amount: ',size: 13, isBold: true),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      AStx(
                                        '\$${_totalPriceFood!}',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      AStx(
                                        _deliveryFee! == 0
                                            ? 'free'
                                            : '\$${_deliveryFee!}',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),


                                      AStx(
                                        _discountPrice! == 0
                                            ? '\$0.0'
                                            : '\$${_discountPrice!}',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      // Text Filed for Tip
                                      SizedBox(
                                        width: DimenApp.widthSc(context,widthPy: 0.35),
                                        height: 35,
                                        child: TFiled(
                                          controller: _controllerTip,
                                          colorPorder: ColorsApp.blak1,
                                          hint: "",
                                          keyboardType: TextInputType.number,
                                          pIcon: Icon(
                                            Icons.monetization_on_outlined,
                                            color: ColorsApp.blak1,
                                            size: 14,
                                          ),
                                          sSize: 22,
                                          sBorder: 1,
                                          onChanged: (value) {
                                            setState(() {
                                              _tip = double.tryParse(value)??0;
                                              _totalPriceWithTaxAndTip = _totalPriceWithTax! + toPrecision(_tip!);
                                              _totalPriceWithTaxAndTip =  toPrecision(_totalPriceWithTaxAndTip!);

                                              print(_tip);
                                              print(_totalPriceWithTaxAndTip);
                                            });
                                          },
                                        ),
                                      ),
                                      AStx(
                                        _taxAmount! == 0 ? '%0.0' : '\$${_taxAmount!}',
                                        colr: ColorsApp.blak50,
                                        size: 13,
                                      ),
                                      AStx('\$${_totalPriceWithTaxAndTip!}',
                                          isBold: true,size: 13,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /************************************************************************/
                          //Speas Color
                          Container(
                            color: ColorsApp.grey,
                            height: 6,
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
                                            size: 13,
                                                isBold: true,
                                          )),
                                          Flexible(
                                            child: AStx(
                                              'Location : ' +
                                                  compInfoDelt["comp_adderss"]
                                                      .toString(),
                                              MLin: 2,
                                              size: 13,
                                              isBold: true,
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
                                            'delivery time :',
                                            size: 13,
                                                isBold: true,
                                          )),
                                          Flexible(
                                              child: AStx(
                                            compInfoDelt["time_date"] ?? "",
                                            size: 13,
                                                isBold: true,
                                          )),
                                          Flexible(
                                              child: AStx(
                                            'delivery Date :',
                                            size: 13,
                                                isBold: true,
                                          )),
                                          Flexible(
                                              child: AStx(
                                            compInfoDelt["date_time"] ?? "",
                                            size: 13,
                                                isBold: true,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            child: Center(
                              child: Container(
                                // height: 55,
                                // width: 192,
                                padding: const EdgeInsets.only(bottom: 10),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 60,
                                  width: 232,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary: ColorsApp.blak1,
                                      shadowColor: ColorsApp.blak50,
                                      elevation: 7,
                                    ),
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
                                                'make payment \$${_totalPriceWithTaxAndTip!}',
                                                size: 16,
                                                colr: ColorsApp.white1,
                                              ),
                                            ],
                                          ),
                                    onPressed: () async {
                                      if (_controllerTip.text.isEmpty) {
                                        _controllerTip.text = '0';
                                        setState(() {
                                          _tip = double.tryParse(
                                                  _controllerTip.text) ??
                                              0;
                                        });
                                      }
                                      if (double.parse(_controllerTip.text) <
                                          0) {
                                        setState(() {
                                          _tip = double.tryParse(
                                                  _controllerTip.text) ??
                                              0;
                                        });
                                      }
                                      if (double.parse(_controllerTip.text) >
                                          _totalPriceWithTaxAndTip!) {
                                        setState(() {
                                          _tip = double.tryParse(
                                                  _controllerTip.text) ??
                                              0;
                                        });
                                      }
                                      /*******************************************************************************/
                                      _tip = double.tryParse(
                                              _controllerTip.text) ??
                                          0;
                                      /*******************************************************************************/
                                      EasyLoading.show(
                                        status: 'loading...',
                                        // maskType: EasyLoadingMaskType.black
                                      );
                                      /****************************************/
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      setState(() {
                                        isLoading = false;
                                      });

/*******************************************************************************************************************************************/
                                      String? stas1, stas2, stas3;
                                      //save order Information to server
                                      String? token = await FirebaseMessaging.instance.getToken();
                                      var saveOrder =
                                          await OrderSave().orderSaveDataInfo(
                                        user_id:
                                            UserInfoPreferences.GetUserId()!,
                                        company_id:
                                            UserInfoPreferences.GetCompanyId()!,
                                            token_message: token!,
                                        amount: '$_totalPriceFood!',
                                        delivery_fee: '$_deliveryFee!',
                                        tip: _tip!.toString(),
                                        tax: _taxAmount!.toString(),
                                        total_amount:
                                            (_totalPriceWithTaxAndTip)
                                                .toString(),
                                      );
                                      stas1 = saveOrder["status"].toString();
/*******************************************************************************************************************************************/
                                      //check if order is saved
                                      // and get order id
                                      // and save order items to server
                                      var orderId;
                                      if (stas1 == "success") {
                                        print("order saved info");
                                        // ignore: prefer_typing_uninitialized_variables
                                        var orderAdd;
                                        orderId =
                                            saveOrder["invoice"].toString();
                                        for (var item
                                            in itemsOrder.BasketListItems) {
                                          var orderItems = await OrderSave()
                                              .orderSaveDataDetails(
                                            order_info_id: orderId,
                                            food_id: item.itemsId.toString(),
                                            suace_id: item.sauceId != null
                                                ? item.sauceId.toString()
                                                : 'null',
                                            is_free_1Id: item.iSFree1Id != null
                                                ? item.iSFree1Id.toString()
                                                : 'null',
                                            is_free_2Id: item.iSFree2Id != null
                                                ? item.iSFree2Id.toString()
                                                : 'null',
                                            is_free_3Id: item.iSFree3Id != null
                                                ? item.iSFree3Id.toString()
                                                : 'null',
                                            Instruction: item.instructon != null
                                                ? item.instructon.toString()
                                                : 'null',
                                            total_food_Item:
                                                item.itemsTotalPrice.toString(),
                                            number_items:
                                                item.itemsOfNumber.toString(),
                                          );
                                          stas2 =
                                              orderItems["status"].toString();
                                          print(stas2);
                                          if (stas2 == "success") {
                                            print("order items saved");

                                            var saveOrderItem =
                                                orderItems["order_food_id"]
                                                    .toString();

                                            if (item.addingList != null) {
                                              if (item.addingList.length > 0) {
                                                for (var add
                                                    in item.addingList) {
                                                  orderAdd = await OrderSave()
                                                      .orderAdditionsSaveData(
                                                    order_info_id: orderId,
                                                    order_food_id:
                                                        saveOrderItem,
                                                    addition_id: add
                                                        .idAdditional
                                                        .toString(),
                                                  );
                                                  print(orderAdd);
                                                  stas3 = orderAdd!["status"]
                                                      .toString();
                                                  if (stas3 == "success") {
                                                    print(
                                                        "order additions saved");
                                                    print("item is saved");
                                                  } else {
                                                    print(
                                                        "add item is not saved");
                                                    EasyLoading.dismiss();
                                                    EasyLoading.showError(
                                                        stas3);
                                                    _showToast(stas3);
                                                  }
                                                }
                                                EasyLoading.dismiss();
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         OrderConfirmation(
                                                //       orderId: orderId,
                                                //     ),
                                                //   ),
                                                // );
                                              } else {
                                                EasyLoading.dismiss();
                                                EasyLoading.showError(
                                                    orderItems["message"]);
                                              }
                                              _showToast(orderItems["message"]);
                                            }
                                          } else {
                                            EasyLoading.dismiss();
                                            EasyLoading.showError(stas2);
                                            _showToast(stas2);
                                          }

/*******************************************************************************************************************************************/
                                          EasyLoading.dismiss();
                                          if ((stas1 == "success" &&
                                                  stas2 == "success") &&
                                              (stas3 == null ||
                                                  stas3 == "success")) {
                                            EasyLoading.dismiss();
                                            _showToast(
                                                "Order is saved successfully");
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   SnackBar(
                                            //       content:
                                            //           AStx("Order is saved")),
                                            // );
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        WebShowPayMent(
                                                            email:
                                                                UserInfoPreferences
                                                                    .GetEmail()!,
                                                            order_info_id:
                                                                orderId!,
                                                            total_amount:
                                                                (_totalPriceWithTaxAndTip)
                                                                    .toString())));
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
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
        } else {
          Future.delayed(const Duration(milliseconds: 50), () {
          // Here you can write your code
            if (compInfoDelt!=null && compInfoDelt["tax"] != null) {
              setState(() {
                falgScreen = true;
              });
            }
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
}
