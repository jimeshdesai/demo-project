// ignore_for_file: file_names

import 'package:flutter/material.dart';

abstract class BaseApiAServices {
  Future<dynamic> getGetApiResponse(
      String url, String token, BuildContext context);
  Future<dynamic> patchApiResponse(
      String url, String token, BuildContext context);
  Future<dynamic> getGetApiResponseWithCount(
      String url, String token, BuildContext context);
  Future<dynamic> getSearchGetApiResponse(String url, String token);
  Future<dynamic> getDeleteApiResponse(String url, String token);

  Future<dynamic> getApiResponse(String url);

  Future<dynamic> getHtmlApiResponse(String url);

  Future<dynamic> getPostApiResponse(
    String url,
    Map<String, String> data,
  );
  Future<dynamic> deletePostApiResponse(String url, String token);
  Future<dynamic> profilePostApiResponse(
    String url,
    dynamic token,
    Map<String, String> data,
    dynamic image,
  );
  Future<dynamic> postImageApiResponse(
    String url,
    dynamic token,
    Map<String, String> data,
    dynamic image,
  );
  Future<dynamic> postApiResponse(
    String url,
    String token,
    Map<String, String> data,
  );

  Future<dynamic> socialLoginApiResponse(
    String url,
    String token,
    Map<String, String> data,
  );
}
