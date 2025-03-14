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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  void _submitForm() {
    if (formKey.currentState!.validate()) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final data = {
        "email": emailController.text,
      };
      authViewModel.forgetPassApi(
          data, emailController.text.toString(), context);
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
                    const SizedBox(height: 15),
                    Image.asset(
                      Images.demo-projectAppLogo,
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height / 4),
                    const Spacer(),
                    CustomText(
                      data: getTranslated('forgot_password', context),
                      fSize: 32,
                      fontColor: AppColors.mainColor,
                      fweight: FontWeight.w700,
                    ),
                    const SizedBox(height: 25),
                    PoppinsText(
                      data: getTranslated(
                          'enter_your_email_below_to_receive_the_instructions_to_reset_your_password',
                          context),
                      textalign: TextAlign.center,
                      fSize: 18,
                      fontColor: AppColors.blackColor,
                      fweight: FontWeight.w500,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: formKey,
                      child: MainTextField(
                        controller: emailController,
                        hintText: getTranslated('enter_email', context),
                        labelText: getTranslated('email', context),
                        maxLines: 1,
                        validator: (value) => ValidationCheck.validateEmail(
                            value,
                            getTranslated('email_empty', context),
                            getTranslated('validate_email', context)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        _submitForm();
                      },
                      child: Center(
                        child: MainButton(
                          loading: authViewModel.forgetLoad,
                          data: getTranslated('reset_password', context),
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
