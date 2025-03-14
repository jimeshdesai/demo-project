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

  FindBookingModel? findBookingData;

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
        print(value['data']['data']['booking']);
        print(value['data']['data']['booking'].isEmpty &&
            value['data']['data']['property'].isEmpty &&
            value['data']['data']['property_manager'].isEmpty);
        if (value['data']['data']['booking'].isEmpty &&
            value['data']['data']['property'].isEmpty &&
            value['data']['data']['property_manager'].isEmpty) {
          print('inif');
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.findMyBookingScreen, (route) => false,
              arguments: {'isexpired': false});
        } else {
          print('inelse');
          findBookingData = FindBookingModel.fromJson(value['data']);
          Provider.of<BookingViewModel>(context, listen: false)
              .storeBookingData(findBookingData);
          if (isBackButton == false) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.navigation,
              (route) => false,
            );
          }
        }
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

  bool get getForgetLoad => forgetLoad;

  bool forgetLoad = false;

  void addForgetLoad(bool isLoading) {
    forgetLoad = isLoading;
    notifyListeners();
  }

  // forget api
  void forgetPassApi(
      Map<String, Object> data, String email, BuildContext context) {
    if (forgetLoad) {
      return;
    }
    addForgetLoad(true);
    if (kDebugMode) {
      print(data);
    }
    _api.forgetPassApi(data).then((value) async {
      addForgetLoad(false);
      if (kDebugMode) {
        print(value);
      }
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(Constants.email, email);
        Utils.toastMessage(value['message'], false);
        Navigator.pushNamed(context, RoutesName.checkMailScreen);
      }
    }).onError((error, stackTrace) {
      addForgetLoad(false);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }

  bool get getChangeLoad => changeLoad;

  bool changeLoad = false;

  void addChangeLoad(bool isLoading) {
    changeLoad = isLoading;
    notifyListeners();
  }

  // change password api
  void changePassApi(String password, String confirmPassword,
      String tempPassword, BuildContext context) async {
    if (changeLoad) {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    final data = {
      "email": sp.getString(Constants.email),
      "password": password,
      "confirm_password": confirmPassword,
      "temp_password": tempPassword
    };
    addChangeLoad(true);
    if (kDebugMode) {
      print(data);
    }
    _api.changePassApi(data).then((value) {
      addChangeLoad(false);
      if (kDebugMode) {
        print(value);
      }
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
        Utils.toastMessage(value['message'], false);
        Navigator.pushNamed(context, RoutesName.login);
        sp.remove(Constants.email);
      }
    }).onError((error, stackTrace) {
      addChangeLoad(false);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }

  bool get getUpdateLoad => updateLoad;

  bool updateLoad = false;

  void addUpdateLoad(bool isLoading) {
    updateLoad = isLoading;
    notifyListeners();
  }

  // update password api
  void updatePassApi(
      String password, String confirmPassword, BuildContext context) async {
    if (updateLoad) {
      return;
    }
    final data = {
      "password": password,
      "confirm_password": confirmPassword,
    };
    addUpdateLoad(true);
    if (kDebugMode) {
      print(data);
    }
    _api.updatePassApi(data).then((value) async {
      addUpdateLoad(false);
      if (kDebugMode) {
        print(value);
      }
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString(Constants.password, confirmPassword);
        Utils.toastMessage(value['message'], false);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      addUpdateLoad(false);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }

  // social login api
  Future<void> socialLoginApi(
      Map<String, dynamic> data, BuildContext context) async {
    Utils.dialog(context);
    if (kDebugMode) {
      print(data);
    }
    _api.socialLoginApi(data).then((value) async {
      Navigator.pop(context);
      if (kDebugMode) {
        print(value);
      }
      if (value['success'] == false) {
        Utils.toastMessage(value['message'], true);
      } else {
        if (value['data']['data']['booking'].isEmpty &&
            value['data']['data']['property'].isEmpty &&
            value['data']['data']['property_manager'].isEmpty) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.findMyBookingScreen, (route) => false,
              arguments: {'isexpired': false});
        } else {
          findBookingData = FindBookingModel.fromJson(value['data']);
          Provider.of<BookingViewModel>(context, listen: false)
              .storeBookingData(findBookingData);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.navigation,
            (route) => false,
          );
        }
        UserModel userModel = UserModel(token: value['token'], isLogin: true);
        userPreference
            .saveUser(userModel, value)
            .then((value) {})
            .onError((error, stackTrace) {});
        SharedPreferences sp = await SharedPreferences.getInstance();
        if (value['user']['first_name'] != null &&
            value['user']['last_name'] != null) {
          sp.setString(Constants.firstname, value['user']['first_name']);
          sp.setString(Constants.lastname, value['user']['last_name']);
          sp.setString(Constants.userEmail, value['user']['email']);
        }
      }
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      Utils.toastMessage(error.toString(), true);
    });
    notifyListeners();
  }
}
