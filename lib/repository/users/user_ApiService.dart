import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/resource/constants.dart';

class User_ApiService {
  User _user;
  int _statusResponse;
  //ErrorApiResponse _error; se debe crear en models/utils/errorapi_model.dart

  User_ApiService();

  Future<ApiResponse> getUserById(User user) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlgetUsers);
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    _statusResponse = res.statusCode;

    if (_statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    }

    return apiResponse;
  }

  Future<ApiResponse> getAllUsers() async {
    //return _user;
  }

  Future<ApiResponse> createUser(User user) async {
    //return _user;
  }
}
