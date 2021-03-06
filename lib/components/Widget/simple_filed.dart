
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';


class TFiled extends StatelessWidget {


    TFiled(
      {Key? key,
      TextEditingController? controller,
      String? initValue,
      TextInputType? keyboardType,
      bool? isObscureText,
      void Function(String)? onChanged,
      String? Function(String?)? onValidator,
      void Function(String?)? onSaved,
      String? hint,
      Widget? pIcon,
      Widget? sIcon,
      bool? readOnly=false,
      void Function()? onSIcon,
        TextInputAction? textAction,
        Color? colorPorder,
        double sSize=65,
        double sBorder=2,
        List<TextInputFormatter>? inputFormatter})
      : _initValue = initValue,
        _keyboardType = keyboardType,
        _isObscureText = isObscureText,
        _onChanged = onChanged,
        _onValidator = onValidator,
        _onSaved = onSaved,
  _textAction = textAction,
        _hint = hint,
        _pIcon = pIcon,
        _sIcon = sIcon,
        _onSIcon = onSIcon,
        _controler = controller,
        _readOnly= readOnly,
    _sSize = sSize,
    _sBorder = sBorder,
        _inputFormatter = inputFormatter,
        _colorPorder = colorPorder,
        super(key: key);

  final String? _initValue;
  final TextInputType? _keyboardType;
  final bool? _isObscureText;
  final void Function(String)? _onChanged;
  final String? Function(String?)? _onValidator;
  final List<TextInputFormatter>? _inputFormatter;
  final  TextInputAction? _textAction;
  // decoration
  final String? _hint;
  final Widget? _pIcon;
  final Widget? _sIcon;
  final void Function()? _onSIcon;
  final void Function(String?)? _onSaved;
  final TextEditingController? _controler;
  final bool? _readOnly;
  final double _sSize;
  final double _sBorder;
   Color? _colorPorder;

  @override
  Widget build(BuildContext context) {
   _colorPorder= _colorPorder ?? ColorsApp.primColr;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
            height: _sSize,
            child: TextFormField(
              textInputAction: _textAction??TextInputAction.next,
              controller: _controler,
              initialValue: _initValue,
              cursorColor: _colorPorder!,
              keyboardType: _keyboardType,
              obscureText: _isObscureText ?? false,
              onChanged: _onChanged,
              validator: _onValidator,
              onSaved: _onSaved,
              readOnly:_readOnly!,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _hint??"1",
                prefixIcon: _pIcon,
                suffixIcon: _sIcon != null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: _onSIcon,
                        child: _sIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                //*Border normal
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: _colorPorder!, width: _sBorder),
                ),
                //* focuse border normal
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: _colorPorder!, width: _sBorder),
                ),
                //*border error
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: _colorPorder!,
                    width: _sBorder,
                  ),
                ),
                //*focuse border error
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: _colorPorder!, width: _sBorder),
                ),
              ),
              style: GoogleFonts.openSans(
                fontSize: 10,
              ),
              inputFormatters:_inputFormatter,
            ),
          ),
        ),
        const SizedBox(height:  7,),
      ],
    );
  }
}
