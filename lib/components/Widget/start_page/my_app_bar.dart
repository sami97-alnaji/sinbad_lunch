// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_basket.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({required this.titel, Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  String titel;

  @override
  Widget build(BuildContext context) {
    var  itemsOrder = Provider.of<ProductPageVariables>(context);
    return AppBar(
      backgroundColor: ColorsApp.primColr,
      centerTitle: true,
      title: AStx(titel,
          colr:  ColorsApp.white1,
          size:  16,
          isBold: true),
      actions: [
        titel == 'Home'
            ? SizedBox(
                height: DimenApp.hightSc(context, hightPy: 0.13),
                // width: DimenApp.widthSc(context, widthPy: 0.6),
                child: Stack(
                    children: [

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 23.0, bottom: 29),
                      //   child: Icon(
                      //     Icons.circle,
                      //     color: ColorsApp.blak1,
                      //     size: 40,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 31.0, top: 9),
                        child: AStx(
                            itemsOrder.BasketListItems!.length.toString(),
                            colr: ColorsApp.white,
                            size: 11),
                      ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const PageBasket()));
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: ColorsApp.blak1.withOpacity(0.7),
                            size: 26,
                          ),
                        ),
                      ),
                    ]),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
      ],
    );
  }
}
