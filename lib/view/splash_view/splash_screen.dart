import 'package:flutter/material.dart';
import '../../localization/language_constrants.dart';
import '../../res/components/custom_text.dart';
import '../../utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: CustomText(
                data: 'Demo',
                fSize: 30,
                fontColor: AppColors.splashTextColor,
                fweight: FontWeight.w700,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
