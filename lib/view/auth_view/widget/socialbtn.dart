import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/utils/color.dart';
import 'package:demo-project/utils/imagesandsvg.dart';
import 'package:demo-project/utils/utils.dart';

import '../../../localization/language_constrants.dart';

class SocialBtn extends StatelessWidget {
  const SocialBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Utils.signGoogle(context);
          },
          child: Container(
            decoration: BoxDecoration(
                //color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.dividerColor)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Svgs.googleSvg,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PoppinsText(
                    data: getTranslated('sign_in_google', context),
                    fSize: 20,
                    fontColor: AppColors.blackColor,
                    fweight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Utils.signFacebook(context);
          },
          child: Container(
            decoration: BoxDecoration(
                //color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.dividerColor)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Svgs.facebookSvg,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PoppinsText(
                    data: getTranslated('sign_in_facebook', context),
                    fSize: 20,
                    fontColor: AppColors.blackColor,
                    fweight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (Platform.isIOS)
          const SizedBox(
            height: 10,
          ),
        if (Platform.isIOS)
          InkWell(
            onTap: () async {
              Utils.signApple(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  //color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.dividerColor)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Svgs.appleSvg,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PoppinsText(
                      data: getTranslated('sign_in_apple', context),
                      fSize: 20,
                      fontColor: AppColors.blackColor,
                      fweight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
