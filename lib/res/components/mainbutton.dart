import 'package:flutter/material.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../utils/color.dart';

class MainButton extends StatefulWidget {
  final String? data;
  final double? width;
  final bool? loading;

  const MainButton({super.key, this.data, this.loading, this.width});

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width / 1.2,
      height: 48,
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      //clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: ((widget.loading == true)
          ? Center(child: Utils.ButtonLoader(AppColors.whiteColor, 35))
          : Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PoppinsText(
                  data: '${widget.data}',
                  fSize: 18,
                  fontColor: AppColors.whiteColor,
                  fweight: FontWeight.w600,
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: AppColors.whiteColor,
                  weight: 2,
                ),
              ],
            )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? iconWidget;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadiusNo;
  final IconData? icon;
  final Color? borderButtonColor;
  final bool isLoading;
  final Color? disabledBackgroundColor;

  const CustomButton({
    super.key,
    this.disabledBackgroundColor,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.iconWidget,
    this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.borderRadiusNo,
    this.icon,
    this.borderButtonColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? primaryColor,
          foregroundColor: textColor ?? whiteColor,
          splashFactory: NoSplash.splashFactory,
          disabledForegroundColor: primaryColor,
          disabledBackgroundColor: disabledBackgroundColor ?? primaryColor,
          shadowColor: transparent,
          surfaceTintColor: transparent,
          overlayColor: transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusNo ?? 14),
            side: borderButtonColor != null
                ? BorderSide(color: borderButtonColor!)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Utils.ButtonLoader(whiteColor, 30)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white),
              const SizedBox(width: 8),
            ],
            if (iconWidget != null) ...[iconWidget!],
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: fontSize ?? 18,
                  fontWeight: fontWeight ?? FontWeight.bold,
                  color: onPressed == null
                      ? const Color(0xff2D2E2E)
                      : textColor ?? Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

