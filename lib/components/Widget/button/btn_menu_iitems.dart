// ignore_for_file: camel_case_types, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/order_details.dart';
import 'package:sinbad_lunch/package/page/page_Home.dart';

class btnMenuItems extends StatefulWidget {
  btnMenuItems(
      {this.ii,
      this.imageItem,
      this.nameItem,
      this.titelItem,
      this.pricceItem,
      this.height = 0.15,
      this.onTab,
      this.controllerCountItems,
      this.isAdd = false,
      this.numm,
      this.op,
      Key? key})
      : super(key: key);
  OrderDetails? op;
  TextEditingController? controllerCountItems;
  String? imageItem, nameItem, titelItem;
  Function()? onTab = () {};
  double? pricceItem, height;
  bool isAdd;
  int? numm, ii;

  @override
  State<btnMenuItems> createState() => _btnMenuItemsState();
}

class _btnMenuItemsState extends State<btnMenuItems> {
  TextEditingController? controllerCountItemss = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var itemsOrder = Provider.of<ProductPageVariables>(context);
    if (widget.numm != null) {
      controllerCountItemss!.text = widget.numm.toString();
    }
    double imgSiz = 100;
    return   SizedBox(
      height: 100, // DimenApp.hightSc(context, hightPy: widget.height ?? 0.48),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: widget.onTab,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Images  in list of menu
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Expanded(
                    flex: 7,
                    // child: Card(
                    child: CachedNetworkImage(
                      imageUrl: widget.imageItem!,
                      fit: BoxFit.fitHeight,
                      height: imgSiz,
                      width: imgSiz,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.primColr,
                      )),
                    ),

                    // Image.asset(
                    //   imageItem!,
                    //   height: imgSiz  ,//DimenApp.hightSc(context, hightPy: 0.20),
                    //   width:imgSiz,// DimenApp.widthSc(context, widthPy: 0.27),
                    //   fit: BoxFit.fill,
                    // ),
                    // ),
                  ),
                ),
                // SizedBox(
                //   // width: DimenApp.widthSc(context, widthPy: 0.018),
                // ),
                // Name of product in menu
                Expanded(
                  flex: 15,
                  child: SizedBox(
                    width: DimenApp.widthSc(context, widthPy: 0.49),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 12,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    // height: DimenApp.hightSc(context, hightPy: height ?? 0.28),
                                    width:
                                        DimenApp.widthSc(context, widthPy: 0.4),
                                    child: AStx(widget.nameItem!,
                                        isBold: true,
                                        size: 11,
                                        colr: ColorsApp.primColr,
                                        MLin: 2),
                                  ),
                                  // Container(
                                  //   // height: DimenApp.hightSc(context, hightPy:  0.2),
                                  //   width: DimenApp.widthSc(context ),
                                  //   child:
                                  Flexible(
                                    child: SizedBox(
                                      height: 42,
                                      width: DimenApp.widthSc(context,
                                          widthPy: 0.55),
                                      child: AStx(
                                        widget.titelItem!,
                                        size: 6,
                                        colr: ColorsApp.blak50,
                                        MLin: 3,
                                      ),
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 11,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AStx(
                                  "\$" +
                                      (/*widget.numm==null?*/ widget.pricceItem!
                                          .toString() /*:(widget.pricceItem! * widget.numm!).toString()*/),
                                  size: 11,
                                  isBold: true,
                                ),
                              ),
                              widget.isAdd
                                  ? SizedBox(
                                      width: DimenApp.widthSc(context,
                                          widthPy: 0.34),
                                      child: SizedBox(
                                        width: 100,
                                        height: 188,
                                        child: Container(
                                          width: DimenApp.widthSc(context,
                                              widthPy: 0.6),
                                          //DimenApp.widthSc(context, widthPy: 0.6),
                                          // 200,
                                          // ,
                                          height: 80,
                                          //80, //DimenApp.hightSc(context, hightPy: 0.11),
                                          //128,
                                          // color: Colors.blue,

                                          // margin: const EdgeInsets.only(top: 0, bottom: 2),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              AStx("X ${widget.numm}",size: 9,),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              IconButton(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.trash,
                                                  size: 15,
                                                  color: ColorsApp.forPass,
                                                ),
                                                onPressed: () {

                                                  setState(() {
                                                    itemsOrder.BasketListItems!
                                                        .remove(widget.op);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => PageHome()));
                                                    print('is Deleted');
                                                    print('is Deleted');
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        // BtnSpinnr(num:numm,),
                                      ),
                                    )
                                  : SizedBox(
                                      width: DimenApp.widthSc(context,
                                          widthPy: 0.12),
                                height: DimenApp.hightSc(context,
                                          hightPy: 0.1),

                                      child: ElevatedButton(
                                        onPressed: widget.onTab,
                                        child: FaIcon(
                                          FontAwesomeIcons.plus,
                                          color: ColorsApp.white1,

                                          /// return here
                                          size: 10,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorsApp.blak1,
                                          onPrimary:
                                              ColorsApp.white1.withOpacity(0.7),
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),

                                      // BtnSpinnr(controllerCountItems:controllerCountItems,wdt: 50,hit: 42,),
                                    ),
                            ],
                          ),
                        ),
                        // SizedBox(height: DimenApp.hightSc(context, hightPy: 0.017),),

                        // price of product in menu

                        // AStx(
                        //   pricceItem!,
                        //   size: 20,
                        //   isBold: true,
                        // ),
                      ],
                    ),
                  ),
                ),
                // price of product in menu
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: ColorsApp.white1,
              onPrimary: ColorsApp.primColr,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
        // decoration: BoxDecoration(
        //   color: ColorsApp.white1,//PageHome().setBackColor,//setBackColor (),//ColorsApp.white,
        //   // border: Border.all(
        //   //   color: ColorsApp.primColr.withOpacity(0.88),//Colors.black38,
        //   // ),
        //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
        //   boxShadow: [
        //     BoxShadow(
        //       color:ColorsApp.blak50.withOpacity(0.31),
        //       spreadRadius: 3,
        //       blurRadius: 7,
        //       offset: const Offset(0, 3), // changes position of shadow
        //     ),
        //
        //   ],
        //
        // ),
      ),
    );
  }
}
