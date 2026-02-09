import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:taxley/res/components/loader.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;
  final double? value;
  final String? text;
  final Color textColor;

  ProgressWidget({
    Key? key,
    required this.child,
    required this.isShow,
    this.opacity = 0.1,
    this.color = Colors.black,
    this.valueColor,
    this.value,
    this.text,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isShow) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Loader()
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.all(8.0),
          //         decoration: BoxDecoration(
          //           color: MyColors.white,
          //           shape: BoxShape.circle,
          //         ),
          //         child: CircularProgressIndicator(
          //           // backgroundColor: MyColors.blue,
          //           valueColor: AlwaysStoppedAnimation<Color>(MyColors.bgColor),
          //           value: value,
          //         ),
          //       ),
          //       if (text != null) ...[
          //         SizedBox(height: 20),
          //         MyWidgets.getText(
          //           text!,
          //           color: textColor,
          //         ),
          //       ]
          //     ],
          //   ),
          //   // Platform.isAndroid
          //   //     ? CircularProgressIndicator(backgroundColor: MyColors.black)
          //   //     : CupertinoActivityIndicator(animating: true),
          // ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
