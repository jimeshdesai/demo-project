// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle poppins({
    final color,
    final double? fontSize,
    final fontWeight,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle roboto({
    final color,
    final double? fontSize,
    final fontWeight,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle nunito({
    final color,
    final double? fontSize,
    final fontWeight,
  }) {
    return GoogleFonts.nunito(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle cabin({
    final color,
    final double? fontSize,
    final fontWeight,
  }) {
    return GoogleFonts.cabin(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0.5,
    );
  }

  static TextStyle inter({
    final color,
    final double? fontSize,
    final fontWeight,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}

class CustomText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;
  final textalign;

  final fontColor;
  const CustomText(
      {super.key,
      this.data,
      this.fSize,
      this.fweight,
      this.fontColor,
      this.textalign});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.data}',
      textAlign: widget.textalign ?? TextAlign.left,
      style: TextStyles.cabin(
        color: widget.fontColor,
        fontSize: widget.fSize,
        fontWeight: widget.fweight,
      ),
    );
  }
}

class PoppinsText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;
  final dynamic textalign;
  final overflow;

  final fontColor;
  const PoppinsText(
      {super.key,
      this.data,
      this.fSize,
      this.fweight,
      this.fontColor,
      this.overflow,
      this.textalign});

  @override
  State<PoppinsText> createState() => _PoppinsTextState();
}

class _PoppinsTextState extends State<PoppinsText> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.data}',
        textAlign: widget.textalign ?? TextAlign.left,
        overflow: widget.overflow ?? TextOverflow.visible,
        style: TextStyles.poppins(
          color: widget.fontColor,
          fontSize: widget.fSize!,
          fontWeight: widget.fweight,
        ));
  }
}

class PoppinsTextSingleLine extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;
  final dynamic textalign;
  final overflow;

  final fontColor;
  const PoppinsTextSingleLine(
      {super.key,
      this.data,
      this.fSize,
      this.fweight,
      this.fontColor,
      this.overflow,
      this.textalign});

  @override
  State<PoppinsTextSingleLine> createState() => _PoppinsTextSingleLineState();
}

class _PoppinsTextSingleLineState extends State<PoppinsTextSingleLine> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.data}',
        textAlign: widget.textalign ?? TextAlign.left,
        overflow: widget.overflow ?? TextOverflow.visible,
        maxLines: 1,
        style: TextStyles.poppins(
          color: widget.fontColor,
          fontSize: widget.fSize!,
          fontWeight: widget.fweight,
        ));
  }
}

class NunitoText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;
  final dynamic textalign;

  final fontColor;
  const NunitoText(
      {super.key,
      this.data,
      this.fSize,
      this.fweight,
      this.fontColor,
      this.textalign});

  @override
  State<NunitoText> createState() => _NunitoTextState();
}

class _NunitoTextState extends State<NunitoText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.data}',
      textAlign: widget.textalign ?? TextAlign.left,
      style: TextStyles.nunito(
        color: widget.fontColor,
        fontSize: widget.fSize,
        fontWeight: widget.fweight,
      ),
    );
  }
}

class RobotoText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;
  final dynamic textalign;

  final fontColor;
  const RobotoText(
      {super.key,
      this.data,
      this.fSize,
      this.fweight,
      this.fontColor,
      this.textalign});

  @override
  State<RobotoText> createState() => _RobotoTextState();
}

class _RobotoTextState extends State<RobotoText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.data}',
      textAlign: widget.textalign ?? TextAlign.left,
      style: TextStyles.roboto(
        color: widget.fontColor,
        fontSize: widget.fSize!,
        fontWeight: widget.fweight,
      ),
    );
  }
}
