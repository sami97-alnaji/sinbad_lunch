// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:ui';

import 'package:sinbad_lunch/components/Colors/colors.dart';

class HeadLines{

  HeadLines( this.label, this.imagePath, {void Function()? onTap }) ;
  String label;
  String imagePath;
  final void Function()? onTap = () {};


}


class Col{

  static Color f=ColorsApp.white1;
}