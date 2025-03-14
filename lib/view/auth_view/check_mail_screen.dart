import 'package:flutter/material.dart';
import 'package:demo-project/localization/language_constrants.dart';
import 'package:demo-project/utils/imagesandsvg.dart';

import '../../res/components/custom_text.dart';
import '../../utils/color.dart';
import '../../res/components/mainbutton.dart';
import '../../utils/routes/routes_name.dart';

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Spacer(),
                    CustomText(
                      data: getTranslated('check_your_email', context),
                      fSize: 32,
                      fontColor: AppColors.mainColor,
                      fweight: FontWeight.w700,
                    ),
                    const SizedBox(height: 10),
                    PoppinsText(
                      data: getTranslated(
                          'we_have_sent_a_password_recover_instruction_to_your_email',
                          context),
                      textalign: TextAlign.center,
                      fSize: 18,
                      fontColor: AppColors.textColor,
                      fweight: FontWeight.w500,
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.changePasswordScreen);
                      },
                      child: Center(
                        child: MainButton(
                          data: getTranslated('next', context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.login,
                            (route) => false,
                          );
                        },
                        child: PoppinsText(
                          data: getTranslated('skip_confirm_later', context),
                          textalign: TextAlign.center,
                          fSize: 18,
                          fweight: FontWeight.w700,
                          fontColor: AppColors.mainColor,
                        )),
                    const SizedBox(height: 20),
                    PoppinsText(
                      data: getTranslated(
                          'did_not_receive_the_email_check_your_spam_filter_or',
                          context),
                      textalign: TextAlign.center,
                      fSize: 18,
                      fweight: FontWeight.w400,
                      fontColor: AppColors.textColor,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: PoppinsText(
                          data: getTranslated(
                              'try_another_email_address', context),
                          textalign: TextAlign.center,
                          fSize: 18,
                          fweight: FontWeight.w700,
                          fontColor: AppColors.mainColor,
                        )),
                    const SizedBox(height: 20),
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
