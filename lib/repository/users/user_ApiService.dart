import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/resource/constants.dart';

class User_ApiService {
  User_ApiService();

  Future<ApiResponse> getAllUsers() async {
    List<User> listUsers = [];
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.http(Constants.urlAuthority, Constants.urlgetUsers);
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listUsers.add(User.fromJson(i));
        return i;
      });
      apiResponse.object = listUsers;

      /*print('prueba ApiService ' + apiResponse.statusResponse.toString());
      print('total registros ${resBody['meta']['pagination']['total']}');
      print('nombre registro 0 ' + resBody['data'][0]['name']);*/
    }

    return apiResponse;
  }

  Future<User> getUserById(User user) async {
    var uri = Uri.http(Constants.urlAuthority, Constants.urlgetUsers + '/8');
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);

    if (resBody.statusCode == 200) {
      return User.fromJson(resBody);
    } else {
      print('no hay datos');
      throw Exception('Fallo');
    }
  }

  Future<ApiResponse> createUser(User user) async {
    //return _user;
  }
}
