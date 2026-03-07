// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo-project/model/auth_model/usermodel.dart';
import 'package:demo-project/model/booking_model/find_booking_model.dart';
import 'package:demo-project/repository/auth_repository/auth_repository.dart';
import 'package:demo-project/utils/routes/routes_name.dart';
import 'package:demo-project/utils/constants.dart';
import 'package:demo-project/utils/utils.dart';
import 'package:demo-project/view_model/booking/booking_view_model.dart';
import 'package:demo-project/view_model/user_preference/user_prefrence_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _api = AuthRepository();

  UserPreference userPreference = UserPreference();

  bool get getRegisterLoad => registerLoader;

  bool registerLoader = false;

  void addRegisterLoad(bool isLoading) {
    registerLoader = isLoading;
    notifyListeners();
  }

  // register api
  void registerApi(Map<String, String?> data, BuildContext context) {
    if (registerLoader) {
      return;
    }
    addRegisterLoad(true);
    if (kDebugMode) {
      print(data);
    }
    _api.registerApi(data).then((value) {
      addRegisterLoad(false);
      if (Platform.isIOS) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
      if (kDebugMode) {
        print(value);
      }
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
        Utils.toastMessage(value['message'], false);
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    }).onError((error, stackTrace) {
      addRegisterLoad(false);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }

  bool get getLoginLoad => loginLoader;

  bool loginLoader = false;

  void addLoginLoad(bool isLoading) {
    loginLoader = isLoading;
    notifyListeners();
  }

  // login api
  Future<void> loginApi(
      Map<String, Object> data, BuildContext context, bool isBackButton) async {
    if (loginLoader) {
      return;
    }
    //Utils.dialog(context);
    addLoginLoad(true);
    if (kDebugMode) {
      print(data);
    }
    _api.loginApi(data).then((value) async {
      addLoginLoad(false);
      if (kDebugMode) {
        print(value);
      }
      print(value['message']);
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.findMyBookingScreen, (route) => false,
              arguments: {'isexpired': false});
        UserModel userModel = UserModel(token: value['token'], isLogin: true);
        userPreference
            .saveUser(userModel, value)
            .then((value) {})
            .onError((error, stackTrace) {});
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(Constants.firstname, value['user']['first_name']);
        sp.setString(Constants.lastname, value['user']['last_name']);
        sp.setString(Constants.userEmail, value['user']['email']);
        sp.setString(Constants.userPassword, data['password'].toString());
      }
    }).onError((error, stackTrace) {
      addLoginLoad(false);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }
}
