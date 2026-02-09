// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_if_null_operators, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'color.dart';

class Utils {
  // manage field focus
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // manage toast message
  static toastMessage(String message, bool isError) {
    print('message:$message');
    if (Platform.isIOS) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    if (!message.contains('Looking') && !message.contains('Null')) {
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: isError ? AppColors.redColor : AppColors.greenColor,
          timeInSecForIosWeb: 2,
          fontSize: 18);
    }
  }

  // manage flush error message
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          duration: const Duration(seconds: 2),
          icon: const Icon(
            Icons.error,
            color: AppColors.whiteColor,
          ),
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(7),
        )..show(context));
  }

  // manage google sign-in
  static Future<void> signGoogle(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    if (userCredential.user != null) {
      if (kDebugMode) {
        print(userCredential.user);
      }
    }
  }

  // manage facebook sign-in
  static Future<void> signFacebook(context) async {
    try {
      FacebookAuthProvider();
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        if (kDebugMode) {
          print(userData);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  // manage apple sign-in
  static Future<void> signApple(context) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    if (kDebugMode) {
      print('credentials:$credential');
    }
  }

  // manage social logout
  static Future<void> socialLogout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await FacebookAuth.instance.logOut();
    await googleSign.signOut();
  }

  // this to show loader
  static void dialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: AppColors.transparent,
        builder: (context) {
          return Loader();
        });
  }

  // loader used in button
  static Widget ButtonLoader(color, double size) {
    return LoadingAnimationWidget.horizontalRotatingDots(
      color: color,
      size: size,
    );
  }

  // manage image from api
  static Widget cacheImage(String img, double? h, double? w, BoxFit fit) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => Image.asset(Images.placeHolder,
          height: h, width: w, fit: fit, alignment: Alignment.center),
      imageUrl: img,
      fit: fit,
      height: h,
      width: w,
      placeholder: (context, url) {
        return placeHolder(h, w, fit);
      },
    );
  }

  // manage placeholder
  static Widget placeHolder(double? h, double? w, BoxFit fit) {
    return Image.asset(Images.placeHolder,
        height: h, width: w, fit: fit, alignment: Alignment.center);
  }

  // this is to pick image for profile
  static Future<File> pickImage(selectedImage) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //setState(() {
    //if (image == null) return;
    selectedImage = File(image!.path);
    return selectedImage;
    //});
  }

  // handle notification in notification list, push notification
  static void handleNotification(status, id, context, notificationId) async {
    print(status);
  }
}
