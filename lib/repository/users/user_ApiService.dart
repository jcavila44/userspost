import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/resources/constants.dart';

class User_ApiService {
  User_ApiService();
  User _user;

//Consultar todos los usuarios
  Future<ApiResponse> getAllUsers(int page) async {
    var listUsers = <User>[];
    var queryParameters = {'page': page.toString()};
    var apiResponse = ApiResponse(statusResponse: 0);

    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetUsers, queryParameters);
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);

    queryParameters = {
      'page': resBody['meta']['pagination']['pages'].toString()
    };
    uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetUsers, queryParameters);
    res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listUsers.add(User.fromJson(i));
        return i;
      });
      apiResponse.object = listUsers;

      // print('prueba ApiService ' + apiResponse.statusResponse.toString());
      print('total páginas ${resBody['meta']['pagination']['pages']}');
      print('página ${resBody['meta']['pagination']['pages']}');
      // print('nombre registro 0 ' + resBody['data'][0]['id'].toString());
      // print('nombre registro 0 ' + resBody['data'][0]['name']);
    }

    return apiResponse;
  }

  //Consultar todos los usuarios filtrando por nombre de usuario
  Future<ApiResponse> getAllUsersSearch(int page, String search) async {
    var listUsers = <User>[];
    var queryParameters = {'page': page.toString(), 'name': search};

    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetUsers, queryParameters);
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

      // print('prueba ApiService ' + apiResponse.statusResponse.toString());
      // print('total registros ${resBody['meta']['pagination']['total']}');
      // print('nombre registro 0 ' + resBody['data'][0]['id'].toString());
      // print('nombre registro 0 ' + resBody['data'][0]['name']);
    }

    return apiResponse;
  }

//Consultar un usuario especifico
  Future<ApiResponse> getUserById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetUsers + '/' + id.toString());

    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody['data']);
      apiResponse.object = _user;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

//Crear un usuario
  Future<ApiResponse> createUser(User user) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJson());
    var uri = Uri.https(Constants.urlAuthority, Constants.urlInsertUser);

    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody['data']);
      apiResponse.object = _user;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modificar un usuario
  Future<ApiResponse> updateUser(User user) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJson());
    var uri = Uri.https(Constants.urlAuthority,
        Constants.urlInsertUser + '/' + user.id.toString());

    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody['data']);
      apiResponse.object = _user;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modulo para eliminar un usuario
  Future<ApiResponse> delUserById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetUsers + '/' + id.toString());

    var res = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    apiResponse.statusResponse = res.statusCode;
    return apiResponse;
  }
}
