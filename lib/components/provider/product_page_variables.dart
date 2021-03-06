// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/model/user/user_info.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/order_details.dart';

class ProductPageVariables with ChangeNotifier {
  TextEditingController? controllerCountItems = TextEditingController();

  int _CountItems = 1;
  double totalFood = 0;
  List<OrderDetails>? BasketListItems =[];

  UserInfo? userInfo;

  set CountItems(int value) {
    _CountItems = value;
    notifyListeners();
  }

  reVariables() {
    //   controllerCountItems = TextEditingController();
    //

    CountItems = 1;
    controllerCountItems!.text = _CountItems.toString();
    // print('provider');
    notifyListeners();
  }

  minuss({TextEditingController? controllerCountItems1}) {
    if(controllerCountItems1==null   ) {
    if (_CountItems > 1) {
      _CountItems--;
      controllerCountItems!.text = _CountItems.toString();
      print(controllerCountItems!.text);
    }
    }else{
      int x=int.parse(controllerCountItems1.text.toString());
      if(x>=0){
        controllerCountItems1.text=(x-1).toString();
      }
    }
    notifyListeners();
  }

  pulss( {TextEditingController? controllerCountItems1} ) {
    if(controllerCountItems1==null) {

      if (_CountItems < 60) {
        _CountItems++;
        controllerCountItems!.text = _CountItems.toString();
        print(controllerCountItems!.text);
      }
    print('is the add');
    }else{
      print('is not the add');

      int x=int.parse(controllerCountItems1.text.toString());
      if(x<60){
       controllerCountItems1.text=(x+1).toString();
      }
    }

    notifyListeners();

  }

    note(){
    return SizedBox(
      // height: 50,
      child: Card(
        // color:  const Color(0xfffeefe3).withOpacity(0.9) ,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.only( left: 15,right: 12),
              child: FaIcon(
                FontAwesomeIcons.exclamation,
                // FontAwesomeIcons.infoCircle,
                size: 20,
                color: ColorsApp.blak1,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AStx(
                  'Note : for every dollar you spend here, you get 10 points '
                      'It can be collected and exchanged in one of our products ',
                  colr: ColorsApp.blak1,
                   MLin: 3,
                  isTextCenter: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
