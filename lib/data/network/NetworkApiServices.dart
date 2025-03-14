// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../utils/utils.dart';
import '../app_exception.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiAServices {
  @override
  Future getGetApiResponse(String url, String token, context) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    var headers = {
      "Authorization": 'Bearer $token',
    };
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> patchApiResponse(String url, String token, context) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    var headers = {
      "Authorization": 'Bearer $token',
      "Content-Type": "application/json",
    };

    try {
      final response = await http
          .patch(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getGetApiResponseWithCount(String url, String token, context) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    var headers = {
      "Authorization": 'Bearer $token',
    };
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));
      responseJson = jsonDecode(response.body);
    } on SocketException {
      Utils.toastMessage('No Internet Connection', true);
    }
    return responseJson;
  }

  @override
  Future getSearchGetApiResponse(String url, String token) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    var headers = {
      "Authorization": 'Bearer $token',
      'Accept': 'application/json',
    };
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));
      responseJson = jsonDecode(response.body);
    } on SocketException {
      Utils.toastMessage('No Internet Connection', true);
    }

    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url, String token) async {
    dynamic responseJson;
    var headers = {"Authorization": 'Bearer $token'};
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getHtmlApiResponse(String url) async {
    //dynamic responseJson;
    try {
      final response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(const Duration(seconds: 20));
      dynamic responseJson = response.body;
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    //return responseJson;
  }

  @override
  Future getPostApiResponse(String url, Map<dynamic, dynamic> data) async {
    if (kDebugMode) {
      print(data);
    }
    dynamic responseJson;
    try {
      var headers = {'Content-Type': 'application/json'};
      //try {
      if (kDebugMode) {
        print(url);
      }
      final jsonData = json.encode(data);
      final response =
          await http.post(Uri.parse(url), body: jsonData, headers: headers);
      responseJson = returnResponse(response);
      // } catch (e) {
      //   print(e);
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future profilePostApiResponse(
      String url, token, Map<String, String> data, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(
      String url, String token, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print(url);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postImageApiResponse(
      String url, token, Map<String, String> data, dynamic image) async {
    dynamic responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (image != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('passport_image', image.path);
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(data);
      var response = await request.send();
      responseJson = await http.Response.fromStream(response).then((value) {
        return returnResponse(value);
      });
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future deletePostApiResponse(String url, String token) async {
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print(url);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future socialLoginApiResponse(
      String url, String token, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'x-header-auth-token': token,
                //'Authorization': 'Bearer $token',
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      if (kDebugMode) {
        print(url);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(final response) {
    if (kDebugMode) {
      print(response.statusCode);
      print('Response =>${response.body}');
    }
    switch (response.statusCode) {
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic errorJson = jsonDecode(response.body);
        if (errorJson['message'] is List) {
          List<String> errorMessages = [];
          for (int i = 0; i < errorJson['message'].length; i++) {
            errorMessages.add(errorJson['message'][i]);
          }
          String combinedErrorMessage = errorMessages.join('\n');
          throw BadRequestException(combinedErrorMessage);
        } else {
          String errorMessage = errorJson['message'];
          throw BadRequestException(errorMessage);
        }
      //return errorJson;
      case 401:
        dynamic errorJson = jsonDecode(response.body);
        if (errorJson['message'] is List) {
          List<String> errorMessages = [];
          for (int i = 0; i < errorJson['message'].length; i++) {
            errorMessages.add(errorJson['message'][i]);
          }
          String combinedErrorMessage = errorMessages.join('\n');
          throw BadRequestException(combinedErrorMessage);
        } else {
          String errorMessage = errorJson['message'];
          throw BadRequestException(errorMessage);
        }
      case 404:
        Map<String, dynamic> errorJson = jsonDecode(response.body);
        String errorMessage = errorJson['message'];
        throw UnauthorisedException(errorMessage);
      default:
        Map<String, dynamic> errorJson = jsonDecode(response.body);
        if (errorJson['message'] is List) {
          List<String> errorMessages = [];
          for (int i = 0; i < errorJson['message'].length; i++) {
            errorMessages.add(errorJson['message'][i]);
          }
          String combinedErrorMessage = errorMessages.join('\n');
          throw FetchDataException(combinedErrorMessage);
        } else {
          String errorMessage = errorJson['message'];
          throw FetchDataException(
            errorMessage,
          );
        }
    }
  }
}
