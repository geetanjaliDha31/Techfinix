// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

// ignore: must_be_immutable
class TextBox extends StatefulWidget {
  final TextEditingController? controller;
  final String? hinttext;
  final String? labelText;
  final String? Function(String?)? validator;
  bool obscureText;
  final String? label;
  final double width;
  Function(String)? onChanged;
  final double height;
  final String? counterText;
  final FocusNode? node;
  final IconData? icon;
  final TextStyle? style;
  final TextInputType? inputType;
  final bool enabled;
  final bool isPassword;
  final bool isNumber;
  final bool readOnly;
  final String? value;
  final Widget? counter;
  final VoidCallback? onTap;
  final int maxLines;
  final int? maxLength;
  final bool showCounter;
  final double? labelFontsize;
  final bool? isDense;
  final MaxLengthEnforcement? maxLengthEnforcement;
  TextBox(
      {Key? key,
      this.controller,
      this.onChanged,
      this.hinttext,
      this.style,
      this.inputType,
      this.validator,
      this.labelText,
      this.counterText,
      this.counter = const SizedBox(),
      this.maxLength,
      this.showCounter = false,
      this.enabled = true,
      this.isDense,
      this.maxLengthEnforcement,
      this.obscureText = false,
      this.label,
      this.node,
      this.width = 0,
      this.height = 55,
      this.icon,
      this.isPassword = false,
      this.isNumber = false,
      this.readOnly = false,
      this.value,
      this.onTap,
      this.maxLines = 1,
      this.labelFontsize})
      : super(key: key);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late bool focused;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    focused = false;
    _focusNode = widget.node ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        focused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != "")
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 2),
            child: Text(
              widget.label!,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Container(
          constraints: const BoxConstraints(minHeight: 55),
          width: widget.width == 0 ? double.infinity : widget.width,
          height: widget.height == 55 ? 60 : widget.height,
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: widget.style == null
                ? TextStyle(color: Colors.black, fontSize: 13)
                : widget.style,
            readOnly: widget.readOnly,
            initialValue: widget.value,
            enabled: widget.enabled,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            keyboardType:
                widget.isNumber ? TextInputType.number : widget.inputType,
            maxLength: widget.isNumber ? 10 : widget.maxLength,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            decoration: InputDecoration(
              isDense: widget.isDense,
              counterText: widget.showCounter ? widget.counterText : null,
              labelText: widget.hinttext,
              hintText: widget.labelText,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              counter: widget.showCounter ? null : widget.counter,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: grey1, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              // error: SizedBox.shrink(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.readOnly ? grey1 : color1, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              suffixIcon: widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                      child: Icon(
                        widget.obscureText
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: focused || !widget.obscureText ? color1 : grey1,
                      ),
                    )
                  : Icon(
                      widget.icon,
                      color: focused ? color1 : grey1,
                    ),
              labelStyle: GoogleFonts.inter(
                  color: focused && !widget.readOnly ? color1 : grey1,
                  fontSize: widget.labelFontsize),
            ),
            obscureText: widget.obscureText,
            // validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
