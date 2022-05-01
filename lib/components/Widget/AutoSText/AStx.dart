import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';

class AStx extends StatefulWidget {
  AStx(this.label, {this.size = 18, this.isBold = false,this.colr ,this.MLin=2, Key? key})
      : super(key: key);
  String label;
  bool? isBold;
  double? size;
  Color? colr;
  int? MLin;

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
        color:widget.colr ?? ColorsApp.blak1 ,

          ),
      maxLines: widget.MLin,
        softWrap:false,
      // overflow: TextOverflow.fade,
      overflow: TextOverflow.ellipsis,

    );
  }
}
