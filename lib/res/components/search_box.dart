import 'package:flutter/material.dart';
import 'package:demo-project/res/components/custom_text.dart';

import '../../utils/color.dart';

class SearchBox extends StatefulWidget {
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
  final ValueChanged<String>? onSubmitted;
  final String? initialValue;
  const SearchBox(
      {super.key,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines,
      this.hintText,
      this.controller,
      this.readOnly,
      this.onTap,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.initialValue});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: TextField(
        //initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        onTap: widget.onTap,
        controller: widget.controller,
        cursorColor: AppColors.cursorColor,
        style: TextStyles.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
        maxLines: widget.maxLines,
        readOnly: widget.readOnly ?? false,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 3),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 75, maxWidth: 90),
          prefixStyle: const TextStyle(color: AppColors.textFieldHintColor),
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyles.poppins(color: AppColors.textFieldHintColor),
          hintText: widget.hintText,
          hintStyle: TextStyles.poppins(
            color: AppColors.textFieldHintColor,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: AppColors.textFieldBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: AppColors.textFieldBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: AppColors.textFieldBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
    );
  }
}
