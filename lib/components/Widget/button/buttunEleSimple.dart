import 'package:flutter/material.dart';
import 'package:sinbad_lunch/Components/Colors/colors.dart';

class ButtonEleSimple extends StatelessWidget {
  ButtonEleSimple(this.lebal, {this.onTab, Key? key}) : super(key: key);
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
            Text(lebal, style: TextStyle(fontSize: 18, color: ColorsApp.blak1)),
      ),
    );
  }
}
