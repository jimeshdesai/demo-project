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
