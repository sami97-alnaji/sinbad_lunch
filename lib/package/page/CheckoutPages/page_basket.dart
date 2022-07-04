// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btn_menu_iitems.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_Checkout.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

import '../../definitions/items_menu/items_menu.dart';

class PageBasket extends StatefulWidget {
  const PageBasket({Key? key}) : super(key: key);

  @override
  State<PageBasket> createState() => _PageBasketState();
}

class _PageBasketState extends State<PageBasket> {
  /// *************************************/
  /// *************************************/
  var itemsOrder;

  /// *************************************/
  /// *************************************/
  bool isLoading = false;
  bool isLoadingg = false;

  /// *************************************/
  @override
  void initState() {
    // for (int i = 0; i < 5; i++) {
    //   itemsMenu.add(ItemsMenu(
    //     imageItem: ImageApp.imGyro,
    //     nameItem: WordAppENG.gloryBeginingRestrant,
    //     titelItem: WordAppENG.titelItemgloryBeginingRestrant,
    //     pricceItem: '51.00',
    //   ));
    // }
    super.initState();
  }

  /// *************************************/
  var itemsMenu = [];

  /// *************************************/
  int ii = 0;

  @override
  Widget build(BuildContext context) {
    itemsOrder = Provider.of<ProductPageVariables>(context);
    double totalFood = 0;
    if (itemsOrder.BasketListItems != null &&
        itemsOrder.BasketListItems != []) {
      for (var x in itemsOrder.BasketListItems) {
        setState(() {
          totalFood += (x.itemsTotalPrice  );
        });
      }
    }
    setState(() {
      itemsOrder.BasketListItems;
    });
    return Scaffold(
      // appBar: MyAppBar(titel: 'Basket'),
      body: Container(
        color: ColorsApp.primColr,
        // height: DimenApp.hightSc(context),
        // width: DimenApp.widthSc(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header in page "My Cart"
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
                      height: DimenApp.hightSc(context, hightPy: 0.53),
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
                                          titelItem: e.itemsName,
                                          pricceItem:e.itemsTotalPrice ,
                                          numm:e.itemsOfNumber,
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
                      height: 120,
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
                                AStx('\$${totalFood}',
                                    colr: ColorsApp.blak50),
                                AStx('free', colr: ColorsApp.blak50),
                                AStx('\$0.0', colr: ColorsApp.blak50),
                                AStx('\$${totalFood}', isBold: true),
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
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: DimenApp.widthSc(context),
                          height: 88,
                          // DimenApp.hightSc(context, hightPy: 0.155),
                          // color: ColorsApp.white1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Column(
                                  children: [
                                    Flexible(child: AStx('Company :')),
                                    Flexible(
                                      child: AStx('Google Co.'),
                                    ),
                                    Flexible(
                                      child: AStx(
                                          'Location : ' +
                                              '4029 N Pleasant Ave, Birmingham, MO 64161, United States',
                                          MLin: 2),
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
                              height: DimenApp.hightSc(context, hightPy: 0.07),
                              width: DimenApp.widthSc(context),
                              padding: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: DimenApp.hightSc(context, hightPy: 0.076),
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
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Page_Checkout()));
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
                                              'Go to Checkout',
                                              size: 22,
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
                              height: DimenApp.hightSc(context, hightPy: 0.07),
                              width: DimenApp.widthSc(context),
                              padding: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: DimenApp.hightSc(context, hightPy: 0.076),
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
                                      isLoadingg = true;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    setState(() {
                                      isLoadingg = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PageHome()));
                                  },
                                  child: (isLoadingg)
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
                                              'Add More...',
                                              size: 22,
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
  }

  EditLinsForLocation(String L) {
    String line = '';
    int o = 0;
    print(L.length);
    for (var i = 0; i < L.length; i++) {
      if (i % 25 == 0) {
        line += '\n';
      }
      line += L[i];
    }
    print(L);

    return line;
  }
}
