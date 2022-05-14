

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';


// ignore: camel_case_types, must_be_immutable
class btnTxt extends StatefulWidget {
  btnTxt(this.lebal, {this.onTab, this.fSize = 18, this.colr, Key? key})
      : super(key: key);
  String lebal;
  Color? colr;
  double fSize;
  // ignore: prefer_function_declarations_over_variables
  Function()? onTab = () {};

  @override
  State<btnTxt> createState() => _btnTxtState();
}

class _btnTxtState extends State<btnTxt> {
  Color colr1 = ColorsApp.forPass;

  @override
  Widget build(BuildContext context) {
    final styl=TextStyle(
      fontSize: widget.fSize,
      color: widget.colr ?? ColorsApp.primColr,
    );
    return TextButton(
      // style: ButtonStyle(
      //     shape: MaterialStateProperty.all<BeveledRectangleBorder>(
      //       BeveledRectangleBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //     )
      // ),
      onPressed: widget.onTab,
      child: Text(widget.lebal,
          style:GoogleFonts.openSans(
            textStyle: styl
          ) ),
    );
  }
}
