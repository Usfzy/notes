import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final int? maxLength;
  final bool? enabled;
  final Widget? label;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomTextField({
    Key? key,
    this.label,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.errorText,
    this.maxLength,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.textStyle,
    this.errorTextStyle,
    this.keyboardType,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      textAlign: textAlign,
      validator: validator,
      style: textStyle,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      maxLength: maxLength,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        counter: const Offstage(),
        label: label,
        labelText: labelText,
        hintText: hintText,
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffix: suffix,
        errorText: errorText,
        errorStyle: errorTextStyle,
        errorBorder: const OutlineInputBorder(),
      ),
    );
  }
}
