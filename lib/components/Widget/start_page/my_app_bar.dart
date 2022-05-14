// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({required this.titel, Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  String titel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsApp.primColr,
      centerTitle: true,
      titleTextStyle: TextStyle(color: ColorsApp.white1, fontSize: 18),
      title: Text(titel),
      actions: [
        titel == 'Home'
            ? Container()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
      ],
    );
  }
}
