import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';

class BtnSpinnr extends StatelessWidget {
  BtnSpinnr({this.controllerCountItems,this.wdt,this.hit, Key? key}) : super(key: key);

  TextEditingController? controllerCountItems; //= TextEditingController();
  int CountItems = 1;
  double? wdt,hit;
  // void initState() {
  //   controllerCountItems?.text = CountItems.toString();
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    // controllerCountItems?.text = CountItems.toString();
    return Container(
      width: wdt??DimenApp.widthSc(context, widthPy: 0.6),//DimenApp.widthSc(context, widthPy: 0.6),
      // 200,
      // ,
      height: hit??80,//80, //DimenApp.hightSc(context, hightPy: 0.11),
      //128,
      // color: Colors.blue,

      // margin: const EdgeInsets.only(top: 0, bottom: 2),
      padding: const EdgeInsets.all(10),
      child: Card(
        color: ColorsApp.white1,
        child: TextField(
          controller: controllerCountItems!,
          readOnly: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //     // borderRadius: BorderRadius.circular(10.0),
            //     ),
            icon: IconButton(
                onPressed: () {
                  if (CountItems < 60) {
                    CountItems++;
                    controllerCountItems!.text = CountItems.toString();
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  color: ColorsApp.green,
                  /// return here
                  // size: 13,
                )),
            suffixIcon: IconButton(
              onPressed: () {
                if (CountItems > 1) {
                  CountItems--;
                  controllerCountItems!.text = CountItems.toString();
                }
              },
              icon: FaIcon(
                FontAwesomeIcons.minus,
                color: ColorsApp.green,
                // size: 13,
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        shadowColor: ColorsApp.blak50,
        elevation: 8,
      ),
    );
  }
}
