import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';

class btnEleSimple extends StatelessWidget {
  btnEleSimple(this.lebal, {this.onTab, Key? key}) : super(key: key);
  String lebal;
  Function()? onTab=(){};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ColorsApp.primColr),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              // BeveledRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            )),
        onPressed: onTab,
        child:
            Text(lebal, style: GoogleFonts.openSans(fontSize: 18, color: ColorsApp.blak50)),
      ),
    );
  }
}
