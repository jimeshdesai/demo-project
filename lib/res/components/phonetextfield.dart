import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:demo-project/res/components/custom_text.dart';

import '../../localization/language_constrants.dart';
import '../../utils/color.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(PhoneNumber)? inputChanged;
  final PhoneNumber? number;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.inputChanged,
    required this.number,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      initialValue: widget.number,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        showFlags: true,
        useEmoji: false,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 8.0,
        trailingSpace: false,
      ),
      validator: (p0) {
        final message = ValidationCheck.validatePhoneNumber(
            widget.controller!.text,
            _regionCode,
            context
        );
        setState(() {
          _errorMessage = message;
        });
        return _errorMessage;
        //if (widget.onChanged != null) widget.onChanged!(p0.toString());
      },
      onInputChanged: widget.inputChanged,
      textStyle: TextStyles.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
      hintText: getTranslated('enter_mobile_number', context),
      textFieldController: widget.controller,
      inputDecoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 10),
        prefixStyle: TextStyles.poppins(
            color: AppColors.textFieldHintColor),
        labelText: getTranslated('telephone', context),
        labelStyle: TextStyles.poppins(
            color: AppColors.mainColor),
        hintText: getTranslated(
            'hint_telephone', context),
        hintStyle: TextStyles.poppins(
            color: AppColors.textFieldHintColor,
            fontSize: 15,
            fontWeight: FontWeight.w400),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.textFieldBorderColor),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.textFieldBorderColor),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.textFieldBorderColor),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.redColor),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 1, color: AppColors.redColor),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
