// ignore: file_names
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';

class Page_Checkout extends StatefulWidget {
  const Page_Checkout({Key? key}) : super(key: key);

  @override
  State<Page_Checkout> createState() => _Page_CheckoutState();
}

class _Page_CheckoutState extends State<Page_Checkout> {
  @override
  Widget build(BuildContext context) {
    return AStx(
      'My Cart',
      size: 20,
      isBold: true,
      colr: ColorsApp.red1,
    );
  }
}
