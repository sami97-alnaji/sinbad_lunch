
import 'package:flutter/material.dart';
//TextFormField
class TextFF extends StatelessWidget {
  TextFF(this.label, {this.typeKey=1,Key? key}) : super(key: key);
  String label;
  int typeKey;

  @override
  Widget build(BuildContext context) {
    /*
    typeKeybord  function

    is 1 a text
    is 2 a number
    is 3 a phone
    is 4 a datetime
    is 5 a emailAddress


     */
    return TextFormField(
      keyboardType:typeKeybord(typeKey),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: label,
      ),
    );
  }

  typeKeybord(int type) {
    if (typeKey == 1) {
      return TextInputType.text;
    } else if (typeKey == 2) {
      return TextInputType.number;
    } else if (typeKey == 3) {
      return TextInputType.phone;
    } else if (typeKey == 4) {
      return TextInputType.datetime;
    }else if (typeKey == 5) {
      return TextInputType.emailAddress;
    }
  }
}
