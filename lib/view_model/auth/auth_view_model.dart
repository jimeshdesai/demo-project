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

  //Login api

  // User1 for Login user
  AuthLoginModel? user1;

  // getting register user data
  AuthLoginModel? get getuser1 => user1;

  void loginapi(String email, String pass, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String fcmtoken = prefs.getString('fcmtoken') ?? '';
    final body = {
      'email': email,
      'password': pass,
      'device_token': fcmtoken,
    };
    print(body);
    dialog(context);
    final response = await http.post(
      Uri.parse('${Constant.apicall}api/v1/user/login'),
      body: body,
    );
    print(response.request);
    print(response.statusCode);
    Navigator.pop(context);
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(body);
        print('Login: ${data}');
        print('Response Body: ${data['success']}');
        if (data['success'] == true) {
          token = data['access_token'];
          user1 = AuthLoginModel.fromJson(data);
          Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EntryPoint(
                        currentIndex: 0,
                      )),
                      (route) => false);
          notifyListeners();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Input Error')));
          notifyListeners();
        }
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        notifyListeners();
      } else if (response.statusCode == 500) {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        notifyListeners();
      } else {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went Wrong')));
      notifyListeners();
    }
  }

  GetChatModel? detail;

  //getting notigication detail page
  GetChatModel? get getdetail => detail;

  bool get getload => _isLoading;

  bool _isLoading = true;

  void addLoad(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<GetChatModel?> getchatapi(BuildContext context) async {
    addLoad(true);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    var header = {'authorization': 'Bearer $token'};
    final response = await http.get(
        Uri.parse('${Constant.apicall}api/v1/chat/users'),
        headers: header);
    print(response.request);
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
       if (data['success'] == true) {
          try {
            detail = GetChatModel.fromJson(data);
          } catch (e) {
            print('error:$e');
          }
          addLoad(false);
          notifyListeners();
          return detail;
        } else {
          addLoad(false);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Input Error')));
          notifyListeners();
        }
      } else if (response.statusCode == 409) {
        addLoad(false);
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        notifyListeners();
      } else {
        addLoad(false);
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        notifyListeners();
      }
    } catch (e) {
      addLoad(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went Wrong')));
      notifyListeners();
    }
  }

  // post images

  Future<void> postimage(BuildContext context, File? url, String loc,
      String date, String name) async {
    dialog(context);
    // StreamController<String?> streamController = StreamController<String?>();
    // Stream<String?> myStream = streamController.stream;
    try {
      var stream =
      http.ByteStream(url != null ? url.openRead() : const Stream.empty());
      //print('f: $f');
      if (url != null) {
        stream = http.ByteStream(url.openRead());
        // Rest of the code...
        notifyListeners();
      }
      stream.cast();
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.apicall}api/v1/add/image'),
      );
      request.fields.addAll({"location": loc, "date": date});
      //var length = await url?.length();
      notifyListeners();
      if (url != null) {
        request.files.add(
          await http.MultipartFile.fromBytes(
            'image',
            File(url.path).readAsBytesSync(),
            filename: url.path,
          ),
        );
        notifyListeners();
      }
      var header = {'authorization': 'Bearer $token'};
      request.headers.addAll(header);
      // Send the request
      var response = await request.send();

      // Read and parse the response
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);
      var jsonData = json.decode(responseString);

      if (response.statusCode == 200) {
        print('Profile: $jsonData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonData['message'])),
        );
        notifyListeners();
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonData['message'])),
        );
        notifyListeners();
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
      print(e.toString());
      notifyListeners();
    }
    notifyListeners();
  }
}
