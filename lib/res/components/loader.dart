// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:demo-project/utils/color.dart';

/// Circular Loader Widget
class Loader extends StatefulWidget {
  final Color? color;

  @Deprecated(
      'accentColor is now deprecated and not being used. use defaultLoaderAccentColorGlobal instead')
  final Color? accentColor;
  final Decoration? decoration;
  final int? size;
  final double? value;
  final Animation<Color?>? valueColor;

  Loader({
    super.key,
    this.color,
    this.decoration,
    this.size,
    this.value,
    this.valueColor,
    this.accentColor,
  });

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 55,
        width: 55,
        decoration: widget.decoration ??
            BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyTextColor.withOpacity(0.6),
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 0.0),
                  ),
                ]),
        //Progress color uses accentColor from ThemeData
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: widget.value,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
