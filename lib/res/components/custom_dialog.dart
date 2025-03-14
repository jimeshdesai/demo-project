// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:demo-project/res/components/custom_text.dart';
import 'package:demo-project/utils/color.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog(
      {super.key,
      required this.text,
      required this.negBtn,
      required this.negBtnOnTap,
      required this.posBtnOnTap,
      required this.posBtn,
      this.negDecoration,
      this.posDecoration,
      this.negBtnColor,
      this.posBtnColor,
      this.posFontSize,
      this.textFontSize,
      this.posBtnWidget,
      this.negFontSize});

  String text = '';

  String negBtn = '';

  String posBtn = '';

  void Function()? negBtnOnTap;

  void Function()? posBtnOnTap;

  final double? textFontSize;

  final double? posFontSize;

  final double? negFontSize;

  dynamic posDecoration;

  dynamic negDecoration;

  dynamic negBtnColor;

  dynamic posBtnColor;

  final Widget? posBtnWidget;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PoppinsText(
          data: widget.text,
          fSize: widget.textFontSize ?? 22,
          fontColor: AppColors.blackColor,
          fweight: FontWeight.w600,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: widget.negBtnOnTap,
                child: Container(
                  //height: 50,
                  decoration: widget.negDecoration ??
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 9.0, bottom: 9.0, left: 5, right: 5),
                    child: Center(
                      child: PoppinsText(
                        data: widget.negBtn,
                        fSize: widget.negFontSize ?? 20,
                        fontColor: widget.negBtnColor ?? AppColors.blackColor,
                        fweight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                //height: 50,
                decoration: widget.posDecoration ??
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.mainColor),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 9.0, bottom: 9.0, left: 5, right: 5),
                  child: Center(
                    child: InkWell(
                      onTap: widget.posBtnOnTap,
                      child: widget.posBtnWidget ??
                          PoppinsText(
                            data: widget.posBtn,
                            fSize: widget.posFontSize ?? 20,
                            fontColor:
                                widget.posBtnColor ?? AppColors.whiteColor,
                            fweight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
