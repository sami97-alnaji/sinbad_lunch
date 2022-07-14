// ignore_for_file: camel_case_types

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
// import 'package:sizer/sizer.dart';

class btnCollection extends StatefulWidget {
  btnCollection(this.label, this.imagePath, {this.onTap, Key? key})
      : super(key: key);
  String label;
  String imagePath;
  void Function()? onTap;

  // int? setBackColor ;

  @override
  State<btnCollection> createState() => btnCollectionState();
}

class btnCollectionState extends State<btnCollection> {
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
      padding: const EdgeInsets.all(15.2),
      child: Container(
        // color: ColorsApp.primColr,
        child: SizedBox(
          height: 160, //DimenApp.hightSc(context, hightPy: 0.4),
          width: 160, //DimenApp.widthSc(context, widthPy: 0.23),
          child: TextButton(
            onPressed: widget.onTap,
            // child: Card(
            //   color: ColorsApp.primColr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.0029),
                ),
                Expanded(
                  flex: 7,
                  child: CachedNetworkImage(
                    imageUrl: widget.imagePath,
                    fit: BoxFit.contain,
                    // height: DimenApp.hightSc(context, hightPy: 0.28),
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                      color: ColorsApp.primColr,
                    )),
                  ),

                  // Image.asset(widget.imagePath),
                ),
                SizedBox(
                    height: 29,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 4),
                      child: AStx(
                        widget.label,
                        colr: ColorsApp.blak1,
                        size: 14,
                        isBold: true,
                        oFlow: true,
                      ),
                    )),
              ],
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
            style: ElevatedButton.styleFrom(
              primary: setBackColor,
              onPrimary: ColorsApp.primColr,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              // ),
              // ButtonStyle(
              //   overlayColor: MaterialStateColor.resolveWith(
              //     (states) => ColorsApp.primColr,
              //   ),

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

        // decoration: BoxDecoration(
        //   color: setBackColor,
        //   //PageHome().setBackColor,//setBackColor (),//ColorsApp.white,
        //   // border: Border.all(
        //   //   color: ColorsApp.primColr.withOpacity(0.88),//Colors.black38,
        //   // ),
        //   borderRadius: const BorderRadius.all(Radius.circular(35.0)),
        //   boxShadow: [
        //     BoxShadow(
        //       color: ColorsApp.blak50.withOpacity(0.31),
        //       spreadRadius: 3,
        //       blurRadius: 7,
        //       offset: const Offset(0, 3), // changes position of shadow
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
