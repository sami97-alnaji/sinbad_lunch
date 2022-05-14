import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';

class btnMenuItems extends StatelessWidget {
  btnMenuItems(
      {this.imageItem,
      this.nameItem,
      this.titelItem,
      this.pricceItem,
      this.height = 0.18,
      this.onTab,
      this.controllerCountItems,
      Key? key})
      : super(key: key);
  TextEditingController? controllerCountItems;
  String? imageItem, nameItem,  titelItem;
  Function()? onTab = () {};
  double? pricceItem,height;

  @override
  Widget build(BuildContext context) {
    double imgSiz =90;
    return SizedBox(
      height: DimenApp.hightSc(context, hightPy: height ?? 0.38),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: onTab,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Images  in list of menu
                Expanded(
                  flex: 7,
                  // child: Card(
                  child:
                  CachedNetworkImage(
                    imageUrl:  imageItem!,
                    fit: BoxFit.fitHeight,
                    height: imgSiz,
                    width: imgSiz,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color:ColorsApp.primColr ,)),

                  ),

                  // Image.asset(
                  //   imageItem!,
                  //   height: imgSiz  ,//DimenApp.hightSc(context, hightPy: 0.20),
                  //   width:imgSiz,// DimenApp.widthSc(context, widthPy: 0.27),
                  //   fit: BoxFit.fill,
                  // ),
                  // ),
                ),
                SizedBox(
                  width: DimenApp.widthSc(context, widthPy: 0.03),
                ),
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
                            children: [
                              Column(
                                children: [
                                  Container(
                                    // height: DimenApp.hightSc(context, hightPy: height ?? 0.28),
                                    width: DimenApp.widthSc(context, widthPy: 0.6),
                                    child: AStx(nameItem!,
                                        size: 18,
                                        isBold: true,
                                        colr: ColorsApp.primColr,
                                    MLin: 2),
                                  ),
                                  // Container(
                                  //   // height: DimenApp.hightSc(context, hightPy:  0.2),
                                  //   width: DimenApp.widthSc(context ),
                                  //   child:
                                    Flexible(
                                      child: SizedBox(
                                        height: 30,
                                        width:  DimenApp.widthSc(context,widthPy: 0.5 ),
                                        child: AStx(
                                          titelItem!,
                                          size: 18,
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
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AStx("\$"+
                                  pricceItem!.toString(),
                                  size: 20,
                                  isBold: true,
                                ),
                              ),
                              SizedBox(
                                width: DimenApp.widthSc(context, widthPy: 0.1),
                                child: ElevatedButton(
                                  onPressed:onTab,
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: ColorsApp.white1,

                                    /// return here
                                    size: 13,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorsApp.blak1,
                                    onPrimary:
                                        ColorsApp.white1.withOpacity(0.7),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
