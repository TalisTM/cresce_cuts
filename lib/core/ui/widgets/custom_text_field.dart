import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Color? fillColor;
  final EdgeInsets? padding;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final InputDecoration? inputDecoration;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    required this.label,
    this.maxLines,
    this.hintText,
    this.labelStyle,
    this.style,
    this.controller,
    this.fillColor,
    this.obscureText = false,
    this.validator,
    this.padding,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.inputDecoration,
    this.maxLength,
    this.enabled,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.focusNode,
    super.key,
    this.hintStyle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(label),
          ),
          TextFormField(
            maxLines: maxLines,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: onFieldSubmitted,
            focusNode: focusNode,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
