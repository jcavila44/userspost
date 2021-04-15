import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:userspost/models/comments/comments_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/resources/constants.dart';

class Comment_ApiService {
  Comment_ApiService();
  Comments _comm;

//Consultar todos los comments
  Future<ApiResponse> getAllComments(int page) async {
    var listComms = <Comments>[];
    var queryParameters = {'page': page.toString()};

    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetComments, queryParameters);
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listComms.add(Comments.fromJson(i));
        return i;
      });
      apiResponse.object = listComms;
    }

    return apiResponse;
  }

//Consultar un comments especifico por id del Comment
  Future<ApiResponse> getCommentById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetComments + '/' + id.toString());

    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _comm = Comments.fromJson(resBody['data']);
      apiResponse.object = _comm;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

//Consultar los comments especificos por id del User
  Future<ApiResponse> getAllCommentsByUserId(int idUser) async {
    var listComms = <Comments>[];
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority,
        Constants.urlgetPosts +
            '/' +
            idUser.toString() +
            Constants.urlgetCommentsByUserId);

    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listComms.add(Comments.fromJson(i));
        return i;
      });
      apiResponse.object = listComms;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

//Crear un commet
  Future<ApiResponse> createComment(Comments post) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(post.toJson());
    var uri = Uri.https(Constants.urlAuthority, Constants.urlInsertComment);

    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _comm = Comments.fromJson(resBody['data']);
      apiResponse.object = _comm;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modificar un comment
  Future<ApiResponse> updateComment(Comments comm) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(comm.toJson());
    var uri = Uri.https(Constants.urlAuthority,
        Constants.urlInsertComment + '/' + comm.id.toString());

    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _comm = Comments.fromJson(resBody['data']);
      apiResponse.object = _comm;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modulo para eliminar un comment
  Future<ApiResponse> delCommentById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetComments + '/' + id.toString());

    var res = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    apiResponse.statusResponse = res.statusCode;
    return apiResponse;
  }
}
