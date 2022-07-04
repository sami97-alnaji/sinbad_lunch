
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';



// ignore: must_be_immutable
class BtnSpinnr extends StatelessWidget {
  BtnSpinnr({this.wdt,this.hit, Key? key, this.num}) : super(key: key);
  double? wdt,hit;
  int? num;
  TextEditingController? controllerCountItemss =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var count=Provider.of<ProductPageVariables>(context);
    if(num!=null){
      controllerCountItemss!.text=num.toString();
    }
    return Container(
      width:  wdt??DimenApp.widthSc(context, widthPy: 0.6),//DimenApp.widthSc(context, widthPy: 0.6),
      // 200,
      // ,
      height:  hit??80,//80, //DimenApp.hightSc(context, hightPy: 0.11),
      //128,
      // color: Colors.blue,

      // margin: const EdgeInsets.only(top: 0, bottom: 2),
      padding: const EdgeInsets.all(10),
      child: Card(
        color: ColorsApp.white1,
        child: TextField(
          controller:controllerCountItemss!.text.isNotEmpty ?controllerCountItemss: count.controllerCountItems,
          readOnly: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //     // borderRadius: BorderRadius.circular(10.0),
            //     ),
            icon: IconButton(
                onPressed: ()=>count.pulss(controllerCountItems1:num!=null?controllerCountItemss:null),
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  color: ColorsApp.green,
                  /// return here
                  // size: 13,
                )),
            suffixIcon: IconButton(
              onPressed: () =>count.minuss(controllerCountItems1:num!=null?controllerCountItemss:null),
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
