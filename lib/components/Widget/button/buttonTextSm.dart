import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';

class ButtonTxt extends StatelessWidget {
  ButtonTxt(this.lebal, {this.onTab, this.fSize = 18, this.colr, Key? key})
      : super(key: key);
  String lebal;
  Color? colr;
  Color colr1 = ColorsApp.forPass;
  double fSize;
  Function()? onTab = () {};

  @override
  Widget build(BuildContext context) {
    final styl=TextStyle(
      fontSize: fSize,
      color: colr ?? ColorsApp.primColr,
    );
    return TextButton(
      // style: ButtonStyle(
      //     shape: MaterialStateProperty.all<BeveledRectangleBorder>(
      //       BeveledRectangleBorder(
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //     )
      // ),
      onPressed: onTab,
      child: Text(lebal,
          style:GoogleFonts.openSans(
            textStyle: styl
          ) ),
    );
  }
}
