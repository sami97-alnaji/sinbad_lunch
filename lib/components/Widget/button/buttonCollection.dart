import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
// import 'package:sizer/sizer.dart';

class ButtonCollection extends StatefulWidget {
  ButtonCollection(this.label, this.imagePath, {this.onTap, Key? key})
      : super(key: key);
  String label;
  String imagePath;
  void Function()? onTap;

  // int? setBackColor ;

  @override
  State<ButtonCollection> createState() => ButtonCollectionState();
}

class ButtonCollectionState extends State<ButtonCollection> {
  Color setBackColor = ColorsApp.white1;

  @override
  void initState() {
    setState(() {
      // PageHome().setBackColor  ;
    });
    super.initState();
  }

  // Color? setBackColor
  @override
  Widget build(BuildContext context) {
    setState(() {
      // PageHome().setBackColor ;
    });
// double? s=window.physicalSize.width.isNaN?1:window.physicalSize.width;
    return Padding(
      padding: const EdgeInsets.all(17.2),
      child: Container(
        // color: ColorsApp.primColr,
        child: SizedBox(
          height: DimenApp.hightSc(context, hightPy: 0.4),
          width: DimenApp.widthSc(context, widthPy: 0.23),
          child: TextButton(
            onPressed: widget.onTap,
            // child: Card(
            //   color: ColorsApp.primColr,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.0029),
                  ),
                  Expanded(
                    flex: 6,
                    child: Image.asset(widget.imagePath),
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: DimenApp.hightSc(context, hightPy: 0.014),
                            right: 4,
                            bottom: 4),
                        child: AutoSizeText(
                          widget.label,
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorsApp.blak50,
                            // ResponsiveFlutter.of(context).fontSize(3) ,
                          ),
                          maxLines: 2,
                        ),
                      )),
                ],
              ),
            ),
            // ),
            //   style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //
            //           RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(65.0),
            //               side: BorderSide(color: ColorsApp.primColr,)
            //
            //           )
            //       )
            //   ),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                (states) => ColorsApp.primColr,
              ),
              // side: MaterialStateProperty.resolveWith<BorderSide>(
              //         (Set<MaterialState> states) {
              //       final Color color = states.contains(MaterialState.pressed)
              //           ? Colors.blue
              //           : Colors.red;
              //       return BorderSide(color: color, width: 2);
              //     }
              // ),
            ),
          ),
        ),

        decoration: BoxDecoration(
          color: setBackColor,
          //PageHome().setBackColor,//setBackColor (),//ColorsApp.white,
          // border: Border.all(
          //   color: ColorsApp.primColr.withOpacity(0.88),//Colors.black38,
          // ),
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.blak50.withOpacity(0.31),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
