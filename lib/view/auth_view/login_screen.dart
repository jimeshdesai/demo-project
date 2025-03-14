// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/validationcheck.dart';
import 'package:demo-project/view/auth_view/widget/socialbtn.dart';
import 'package:demo-project/view_model/auth/auth_view_model.dart';
import '../../res/components/custom_text.dart';
import '../../utils/color.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/maintextfild.dart';
import '../../utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void _submitForm() async {
    if (_fromKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      final data = {
        "email": emailController.text,
        "password": passwordController.text,
        "remember_me": isChecked,
        'device_token': (prefs.getString(Constants.fcmToken) != null &&
                prefs.getString(Constants.fcmToken) != '')
            ? prefs.getString(Constants.fcmToken) ?? Constants.deviceToken
            : Constants.deviceToken,
        'device_type': Constants.deviceType,
      };
      await authViewModel.loginApi(data, context, false).then((value) {
        setState(() {
          _storeCredentials(emailController.text.toString(),
              passwordController.text.toString());
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFcmToken();
    _autoFillCredentials();
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

  Future<void> _storeCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (isChecked == true) {
      prefs.setString(Constants.username, username);
      prefs.setString(Constants.password, password);
    } else {
      prefs.remove(Constants.username);
      prefs.remove(Constants.password);
    }
  }

  Future<void> _autoFillCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(Constants.username) ?? '';
    String password = prefs.getString(Constants.password) ?? '';
    if (username != '' && password != '') {
      emailController.text = username;
      passwordController.text = password;
      setState(() {
        isChecked = true;
      });
    }
  }

  FocusNode focusNode = FocusNode();

  TextEditingController controller = TextEditingController();
  bool isChecked = false;
  bool isVisible = false;
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Image.asset(
                      Images.demo-projectAppLogo,
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    const Spacer(),
                    CustomText(
                      data: getTranslated('login', context),
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
                              hintText:
                                  getTranslated('enter_password', context),
                              labelText: getTranslated('password', context),
                              maxLines: 1,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: (isVisible == true)
                                      ? const Icon(Icons.visibility,
                                          color: AppColors.textFieldHintColor)
                                      : const Icon(Icons.visibility_off,
                                          color: AppColors.textFieldHintColor)),
                              obscureText: (isVisible == true) ? false : true,
                              validator: (value) =>
                                  ValidationCheck.validateLoginPassword(
                                    value,
                                    getTranslated('password_empty', context),
                                  )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (isChecked == true)
                                  ? const Icon(
                                      Icons.circle,
                                      color: AppColors.mainColor,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.mainColor,
                                      size: 20,
                                    ),
                              const SizedBox(width: 5),
                              NunitoText(
                                data: getTranslated('remember_me', context),
                                fSize: 14,
                                fontColor: AppColors.mainColor,
                                fweight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.forgotPassword);
                          },
                          child: PoppinsText(
                            data:
                                '${getTranslated('forgot_password', context)}?',
                            fSize: 14,
                            fontColor: AppColors.mainColor,
                            fweight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        _submitForm();
                      },
                      child: Center(
                        child: MainButton(
                          loading: authViewModel.getLoginLoad,
                          data: getTranslated('login', context),
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
                        Navigator.pushReplacementNamed(
                            context, RoutesName.register);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PoppinsText(
                            data:
                                '${getTranslated('dont_have_an_account', context)} ',
                            fSize: 16,
                            fontColor: AppColors.secondTextColor,
                            fweight: FontWeight.w500,
                          ),
                          PoppinsText(
                            data: ' ${getTranslated('sign_up', context)}',
                            fSize: 16,
                            fontColor: AppColors.mainColor,
                            fweight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
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
