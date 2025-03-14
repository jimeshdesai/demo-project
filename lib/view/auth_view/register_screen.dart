// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/validationcheck.dart';
import 'package:demo-project/view/auth_view/widget/socialbtn.dart';
import 'package:demo-project/view_model/auth/auth_view_model.dart';
// import 'package:google_fonts/google_fonts.dart';
import '../../utils/color.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/maintextfild.dart';
import '../../utils/routes/routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fromKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    getFcmToken();
  }

  void _submitForm() async {
    if (_fromKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      final data = {
        'email': emailController.text,
        'first_name': nameController.text,
        'last_name': lastnameController.text,
        'password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
        'device_token': (prefs.getString(Constants.fcmToken) != null &&
                prefs.getString(Constants.fcmToken) != '')
            ? prefs.getString(Constants.fcmToken) ?? Constants.deviceToken
            : Constants.deviceToken,
        'device_type': Constants.deviceType,
      };
      authViewModel.registerApi(data, context);
    }
  }

  Future<void> getFcmToken() async {
    // storing fcm token
    try {
      await FirebaseMessaging.instance.requestPermission();
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        await FirebaseMessaging.instance.setAutoInitEnabled(true);
        // if (kDebugMode) {
        print("FCM Token: $fcmToken");
        //}
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.fcmToken, fcmToken);
      } else {
        if (kDebugMode) {
          print("FCM Token is not available yet.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in FCM handling: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Image.asset(
                  Images.demo-projectAppLogo,
                  height: MediaQuery.of(context).size.height / 9,
                ),
                const SizedBox(height: 20),
                CustomText(
                  data: getTranslated('register', context),
                  fSize: 35,
                  fontColor: AppColors.mainColor,
                  fweight: FontWeight.w700,
                ),
                const SizedBox(height: 20),
                Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        MainTextField(
                          controller: nameController,
                          labelText: getTranslated('first_name', context),
                          hintText: getTranslated('enter_first_name', context),
                          maxLines: 1,
                          validator: (value) =>
                              ValidationCheck.validateFirstName(
                                  value,
                                  getTranslated(
                                      "validate_first_name", context)),
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          controller: lastnameController,
                          labelText: getTranslated('last_name', context),
                          hintText: getTranslated('enter_last_name', context),
                          maxLines: 1,
                          validator: (value) =>
                              ValidationCheck.validateFirstName(value,
                                  getTranslated("validate_last_name", context)),
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          controller: emailController,
                          hintText: getTranslated('enter_email', context),
                          labelText: getTranslated('email', context),
                          maxLines: 1,
                          validator: (value) => ValidationCheck.validateEmail(
                              value,
                              getTranslated('email_empty', context),
                              getTranslated('validate_email', context)),
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          controller: passwordController,
                          labelText: getTranslated('password', context),
                          hintText: getTranslated('enter_password', context),
                          maxLines: 1,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              child: (isPasswordVisible == true)
                                  ? const Icon(Icons.visibility,
                                      color: AppColors.textFieldHintColor)
                                  : const Icon(Icons.visibility_off,
                                      color: AppColors.textFieldHintColor)),
                          obscureText:
                              (isPasswordVisible == true) ? false : true,
                          validator: (value) =>
                              ValidationCheck.validatePassword(
                                  value,
                                  getTranslated('new_password_empty', context),
                                  getTranslated(
                                      'validate_new_password', context)),
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          controller: confirmPasswordController,
                          labelText: getTranslated('confirm_password', context),
                          hintText:
                              getTranslated('enter_confirm_password', context),
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
                          obscureText:
                              (isConfirmPasswordVisible == true) ? false : true,
                          validator: (value) =>
                              ValidationCheck.validateConfirmPassword(
                                  value,
                                  passwordController.text,
                                  getTranslated(
                                      'confirm_password_empty', context),
                                  getTranslated(
                                      'validate_confirm_password', context),
                                  getTranslated(
                                      'validate_password_match', context)),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _submitForm();
                  },
                  child: Center(
                    child: MainButton(
                      loading: authViewModel.registerLoader,
                      data: getTranslated('register', context)!,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.mainColor,
                        height: 1,
                        //width: MediaQuery.of(context).size.width / 3.7,
                      ),
                    ),
                    const SizedBox(width: 10),
                    PoppinsText(
                      data: getTranslated('social_login', context),
                      fSize: 16,
                      fontColor: AppColors.mainColor,
                      fweight: FontWeight.w700,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        color: AppColors.mainColor,
                        height: 1,
                        //width: MediaQuery.of(context).size.width / 3.7,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SocialBtn(),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PoppinsText(
                          data:
                              '${getTranslated('already_have_an_account', context)} ',
                          fSize: 16,
                          fontColor: AppColors.secondTextColor,
                          fweight: FontWeight.w500),
                      PoppinsText(
                          data: ' ${getTranslated('login', context)}',
                          fSize: 16,
                          fontColor: AppColors.mainColor,
                          fweight: FontWeight.w700),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
