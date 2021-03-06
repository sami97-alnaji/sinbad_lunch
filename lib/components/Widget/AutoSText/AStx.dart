// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';

// ignore: must_be_immutable
class AStx extends StatefulWidget {
  // ignore: non_constant_identifier_names
  AStx(this.label,
      {this.size = 11, this.isBold = false, isTextCenter = false,this.oFlow=false, this.colr, this.MLin = 2, Key? key})
      : super(key: key);
  String label;
  bool? isBold ;
  bool  isTextCenter = false ;
  double? size;
  Color? colr;
  // ignore: non_constant_identifier_names
  int? MLin;
  bool oFlow;
  @override
  State<AStx> createState() => _AStxState();
}

/// it is
///  Auto Size text
///  use font from google Open Sans
///  label is compulsory
///
///  optional
///  size : fontSize (number)
///  weight : fontWeight (boolean) default => false
///

class _AStxState extends State<AStx> {


  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.label,
      style: GoogleFonts.openSans(
        fontSize: widget.size,
        fontWeight: widget.isBold! ? FontWeight.bold : null,
        color: widget.colr ?? ColorsApp.blak1,

      ),
      maxLines: widget.MLin,

      minFontSize: widget.size??5 ,
      softWrap: false,
      textAlign: widget.isTextCenter ?TextAlign.center:null,
      // overflow: TextOverflow.fade,
      overflow: !widget.oFlow? TextOverflow.ellipsis:TextOverflow.visible,
    );
  }
}
