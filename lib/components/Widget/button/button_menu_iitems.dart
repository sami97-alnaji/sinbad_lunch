import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';

class ButtonMenuItems extends StatelessWidget {
  ButtonMenuItems(
      {this.imageItem, this.nameItem,this.titelItem, this.pricceItem, this.onTab, Key? key})
      : super(key: key);
  String? imageItem, nameItem, pricceItem,titelItem;
  Function()? onTab = () {};

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton(
          onPressed: onTab,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Images  in list of menu
              Expanded(
                flex: 3,
                // child: Card(
                child: Image.asset(
                  imageItem!,
                  height: DimenApp.hightSc(context, hightPy: 0.16),
                  width: DimenApp.widthSc(context, widthPy: 0.27),
                  fit: BoxFit.fill,
                ),
                // ),
              ),
              SizedBox(
                width: DimenApp.widthSc(context, widthPy: 0.03),
              ),
              // Name of product in menu
              Expanded(
                flex: 6,
                child: SizedBox(
                  width: DimenApp.widthSc(context, widthPy: 0.49),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameItem!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.primColr),
                      ),
                      SizedBox(height: DimenApp.hightSc(context, hightPy: 0.017),),
                      AutoSizeText(
                        titelItem!,
                        style: TextStyle(fontSize: DimenApp.widthSc(context, widthPy: 0.03), color: ColorsApp.blak50),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              // price of product in menu
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: DimenApp.widthSc(context, widthPy: 0.1),
                  child: Text(
                    pricceItem!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
      decoration: BoxDecoration(
        color: ColorsApp.white1,//PageHome().setBackColor,//setBackColor (),//ColorsApp.white,
        // border: Border.all(
        //   color: ColorsApp.primColr.withOpacity(0.88),//Colors.black38,
        // ),
        borderRadius: const BorderRadius.all(Radius.circular(35.0)),
        boxShadow: [
          BoxShadow(
            color:ColorsApp.blak50.withOpacity(0.31),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),

        ],

      ),
    );
  }
}
