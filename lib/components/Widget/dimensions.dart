import 'package:flutter/material.dart';

class DimenApp{
  static double hightSc(BuildContext context,{double hightPy=1})=>MediaQuery.of(context).size.height*hightPy;
  static double widthSc(BuildContext context,{double widthPy=1})=>MediaQuery.of(context).size.width*widthPy;
}