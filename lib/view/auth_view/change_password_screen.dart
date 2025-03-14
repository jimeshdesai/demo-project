// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/validationcheck.dart';
import 'package:demo-project/view_model/auth/auth_view_model.dart';

import '../../res/components/custom_text.dart';
import '../../utils/color.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/maintextfild.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key, required this.isForget});

  bool isForget;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isTempPasswordVisible = false;

  void _submitForm() {
    if (_fromKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      if (widget.isForget == true) {
        authViewModel.updatePassApi(newPasswordController.text,
            confirmPasswordController.text, context);
      } else {
        authViewModel.changePassApi(
            newPasswordController.text,
            confirmPasswordController.text,
            oldPasswordController.text,
            context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.isForget == false) const SizedBox(height: 15),
                    if (widget.isForget == true) const SizedBox(height: 10),
                    if (widget.isForget == true)
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 25,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Image.asset(
                      Images.demo-projectAppLogo,
                      height: 150,
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height / 4),
                    const Spacer(),
                    CustomText(
                      data: getTranslated('change_password', context),
                      fSize: 32,
                      fontColor: AppColors.mainColor,
                      fweight: FontWeight.w700,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          if (widget.isForget != true)
                            MainTextField(
                              controller: oldPasswordController,
                              hintText: getTranslated(
                                  'enter_temporary_password', context),
                              labelText:
                                  getTranslated('temporary_password', context),
                              maxLines: 1,
                              validator: (value) =>
                                  ValidationCheck.validateTemporaryPassword(
                                      value,
                                      getTranslated(
                                          'temporary_password_empty', context),
                                      getTranslated(
                                          'validate_temp_password', context)),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isTempPasswordVisible =
                                          !isTempPasswordVisible;
                                    });
                                  },
                                  child: (isTempPasswordVisible == true)
                                      ? const Icon(Icons.visibility,
                                          color: AppColors.textFieldHintColor)
                                      : const Icon(Icons.visibility_off,
                                          color: AppColors.textFieldHintColor)),
                              obscureText: (isTempPasswordVisible == true)
                                  ? false
                                  : true,
                            ),
                          const SizedBox(height: 20),
                          MainTextField(
                            controller: newPasswordController,
                            hintText:
                                getTranslated('enter_new_password', context),
                            labelText: getTranslated('new_password', context),
                            maxLines: 1,
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isNewPasswordVisible =
                                        !isNewPasswordVisible;
                                  });
                                },
                                child: (isNewPasswordVisible == true)
                                    ? const Icon(Icons.visibility,
                                        color: AppColors.textFieldHintColor)
                                    : const Icon(Icons.visibility_off,
                                        color: AppColors.textFieldHintColor)),
                            obscureText:
                                (isNewPasswordVisible == true) ? false : true,
                            validator: (value) =>
                                ValidationCheck.validatePassword(
                                    value,
                                    getTranslated(
                                        'new_password_empty', context),
                                    getTranslated(
                                        'validate_new_password', context)),
                          ),
                          const SizedBox(height: 20),
                          MainTextField(
                            controller: confirmPasswordController,
                            hintText: getTranslated(
                                'enter_confirm_password', context),
                            labelText:
                                getTranslated('confirm_password', context),
                            maxLines: 1,
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                                child: (isConfirmPasswordVisible == true)
                                    ? const Icon(Icons.visibility,
                                        color: AppColors.textFieldHintColor)
                                    : const Icon(Icons.visibility_off,
                                        color: AppColors.textFieldHintColor)),
                            obscureText: (isConfirmPasswordVisible == true)
                                ? false
                                : true,
                            validator: (value) =>
                                ValidationCheck.validateConfirmPassword(
                                    value,
                                    newPasswordController.text,
                                    getTranslated(
                                        'confirm_password_empty', context),
                                    getTranslated(
                                        'validate_confirm_password', context),
                                    getTranslated(
                                        'validate_password_match', context)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        _submitForm();
                      },
                      child: Center(
                        child: MainButton(
                          loading: (widget.isForget == true)
                              ? authViewModel.updateLoad
                              : authViewModel.changeLoad,
                          data: getTranslated('complete', context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
