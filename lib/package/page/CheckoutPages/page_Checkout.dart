// ignore: file_names
// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/Controller/Order/order_save.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';

class Page_Checkout extends StatefulWidget {
  const Page_Checkout({Key? key}) : super(key: key);

  @override
  State<Page_Checkout> createState() => _Page_CheckoutState();
}

class _Page_CheckoutState extends State<Page_Checkout> {
  // ignore: prefer_typing_uninitialized_variables
  var itemsOrder;

  @override
  Widget build(BuildContext context) {
    // final paymentController = Get.put(PaymentController());
    itemsOrder = Provider.of<ProductPageVariables>(context);
    double totalFood = 0;
    if (itemsOrder.BasketListItems != null &&
        itemsOrder.BasketListItems != []) {
      for (var x in itemsOrder.BasketListItems) {
        totalFood += x.itemsTotalPrice;
      }
    }
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
                height: DimenApp.hightSc(context, hightPy: 0.10),
                child: Container(
                  padding: const EdgeInsets.only(top: 55),
                  child: AStx(
                    'My Cart',
                    size: 20,
                    isBold: true,
                    colr: ColorsApp.white1,
                  ),
                ),
              ),

              Container(
                height: DimenApp.hightSc(context, hightPy: 0.9),
                color: ColorsApp.grey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            AStx('Total Food :', colr: ColorsApp.blak50),
                            AStx('Delivery fee : ', colr: ColorsApp.blak50),
                            AStx('Discount : ', colr: ColorsApp.blak50),
                            AStx('Total : ', isBold: true),
                          ],
                        ),
                        Column(
                          children: [
                            AStx('\$$totalFood', colr: ColorsApp.blak50),
                            AStx('free', colr: ColorsApp.blak50),
                            AStx('\$0.0', colr: ColorsApp.blak50),
                            AStx('\$$totalFood ', isBold: true),
                          ],
                        ),
                      ],
                    ),
                    /************************************************************************/
                    //Speas Color
                    Container(
                      color: ColorsApp.grey,
                      height: DimenApp.hightSc(context, hightPy: 0.016),
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
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: DimenApp.widthSc(context),
                          height: 150,
                          // DimenApp.hightSc(context, hightPy: 0.155),
                          // color: ColorsApp.white1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Column(
                                  children: [
                                    AStx('Company :'),
                                    AStx('Google Co.'),
                                    AStx(
                                      'Location : '
                                      '4029 N Pleasant Ave, Birmingham, MO 64161, United States',
                                      MLin: 3,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 6,
                                child: Column(
                                  children: [
                                    Flexible(child: AStx('delivery time :')),
                                    Flexible(child: AStx('12:15 AM')),
                                    Flexible(child: AStx('2022/4/19')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: DimenApp.hightSc(context, hightPy: 0.036),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var ordInfId = await OrderSave().orderSaveDataInfo();
                          print(ordInfId);
                          // var itemsOrder = Provider.of<ProductPageVariables>(
                          //     context,
                          //     listen: false); // get itemsOrder
                          //
                          // if (itemsOrder.BasketListItems != null &&
                          //     itemsOrder.BasketListItems != []) {
                          //   for (var x in itemsOrder.BasketListItems!) {
                          //     print('object');
                          //     print('object');
                          //
                          //     var numberItems = x.itemsOfNumber.toString();
                          //     var itemsTotalPrice =
                          //         x.itemsTotalPrice.toString();
                          //     var orderFoodId = x.itemsId.toString();
                          //     OrderSave().orderSaveDataDetails(numberItems,itemsTotalPrice,orderFoodId );
                          //   }
                          // }


                          // paymentController.makePayment(
                          //     amount: totalFood.toString(),
                          //     currency: 'USD',
                          //     context: context);
                        },
                        child: AStx(
                          // ignore: unnecessary_brace_in_string_interps
                          'make payment \$${totalFood}',
                          colr: ColorsApp.blak50,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
