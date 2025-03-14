import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo-project/res/components/custom_text.dart';
import '../../utils/color.dart';

class MainTextField extends StatefulWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? hintText;
  final TextEditingController? controller;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic decoration;
  const MainTextField(
      {super.key,
      this.initialValue,
      this.labelText,
      this.prefixIcon,
      this.maxLines,
      this.suffixIcon,
      this.hintText,
      this.controller,
      this.readOnly,
      this.onTap,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.inputFormatters,
      this.decoration});

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      style: TextStyles.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
      maxLines: widget.maxLines,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChanged,
      //validator: widget.validator,
      cursorColor: AppColors.cursorColor,
      inputFormatters: widget.inputFormatters,
      decoration: widget.decoration ??
          InputDecoration(
            filled: true,
            fillColor: AppColors.whiteColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            prefixIcon: widget.prefixIcon,
            prefixStyle: TextStyles.poppins(color: AppColors.textFieldHintColor),
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            labelStyle: TextStyles.poppins(color: AppColors.mainColor),
            hintText: widget.hintText,
            hintStyle: TextStyles.poppins(
                color: AppColors.textFieldHintColor,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: AppColors.textFieldBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: AppColors.textFieldBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: AppColors.textFieldBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.redColor),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
    );
  }
}
