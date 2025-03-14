
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/auth_model/usermodel.dart';
import '../../utils/routes/routes_name.dart';
import '../user_preference/user_prefrence_view_model.dart';

class SplashServices {
  // getting user token
  Future<UserModel> getUserToken() => UserPreference.getUser();

  void checkAuthentication(context) async {
    // managing user login
    getUserToken().then(
      (value) async {
        if (kDebugMode) {
          print('userDetails:${value.token}');
        }
        // if user does not have token then it should move to onboard screen
        if (value.token == null) {
          await Future.delayed(const Duration(seconds: 2));
          SharedPreferences sp = await SharedPreferences.getInstance();
        } else {
            await Future.delayed(const Duration(seconds: 2));
        }
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      },
    );
  }
}
