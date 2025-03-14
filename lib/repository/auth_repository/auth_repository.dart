import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo-project/data/network/NetworkApiServices.dart';
import 'package:demo-project/res/app_url.dart';
import 'package:demo-project/utils/constants.dart';

class AuthRepository {
  NetworkApiService networkApi = NetworkApiService();

  Future<dynamic> registerApi(Map<String, String?> data) async {
    //try {
    dynamic response =
        await networkApi.getPostApiResponse(AppUrl.registerUrl, data);
    if (kDebugMode) {
      print('response: $response');
    }
    return response;
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<dynamic> loginApi(Map<String, Object> data) async {
    //try {
    dynamic response =
        await networkApi.getPostApiResponse(AppUrl.loginUrl, data);
    return response;
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<dynamic> forgetPassApi(Map<String, Object> data) async {
    //try {
    dynamic response =
        await networkApi.getPostApiResponse(AppUrl.forgetPassUrl, data);
    return response;
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<dynamic> changePassApi(Map<String, String?> data) async {
    //try {
    dynamic response =
        await networkApi.getPostApiResponse(AppUrl.changePassUrl, data);
    return response;
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<dynamic> updatePassApi(Map<String, String?> data) async {
    //try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dynamic response = await networkApi.postApiResponse(
      AppUrl.updatePassUrl,
      sp.getString(Constants.token)!,
      data,
    );
    return response;
    // } catch (e) {
    //   print(e);
    //   return e;
    // }
  }

  Future<dynamic> socialLoginApi(Map<String, dynamic> data) async {
    //try {
    dynamic response = await networkApi.socialLoginApiResponse(
        AppUrl.socialLoginUrl, Constants.staticHeaderAuth, data);
    return response;
    // } catch (e) {
    //   print(e);
    // }
  }
}
