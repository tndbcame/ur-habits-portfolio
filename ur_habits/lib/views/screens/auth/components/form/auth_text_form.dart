import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';

class AuthTextForm extends StatefulWidget {
  const AuthTextForm({
    super.key,
    required this.initialValue,
    required this.inputType,
    required this.validator,
    required this.onSaved,
    this.obscureText = false,
    this.isConfirmPass = false,
    this.maxLength,
    this.formatter,
  });
  final String? initialValue;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final bool isConfirmPass;
  final int? maxLength;
  final List<TextInputFormatter>? formatter;

  @override
  State<AuthTextForm> createState() => _AuthTextFormState();
}

class _AuthTextFormState extends State<AuthTextForm> {
  bool _isPassObscure = true;
  bool _isConfPassObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.inputType,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      inputFormatters: widget.formatter,
      obscureText: widget.obscureText
          ? widget.isConfirmPass
              ? _isConfPassObscure
              : _isPassObscure
          : false,
      validator: widget.validator,
      onSaved: widget.onSaved,
      style: const TextStyle(fontSize: 14, color: kTextThirdBaseColor),
      cursorColor: kTextThirdBaseColor,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: kTextBaseColor,
        suffixIconColor: kTextBaseColorBlack,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kLightGray4)),
        suffixIcon: !widget.obscureText
            ? null
            : !widget.isConfirmPass
                ? IconButton(
                    icon: Icon(_isPassObscure
                        ? HugeIcons.strokeRoundedView
                        : HugeIcons.strokeRoundedViewOffSlash),
                    onPressed: () {
                      setState(() {
                        _isPassObscure = !_isPassObscure;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(_isConfPassObscure
                        ? HugeIcons.strokeRoundedView
                        : HugeIcons.strokeRoundedViewOffSlash),
                    onPressed: () {
                      setState(() {
                        _isConfPassObscure = !_isConfPassObscure;
                      });
                    },
                  ),
      ),
    );
  }
}
