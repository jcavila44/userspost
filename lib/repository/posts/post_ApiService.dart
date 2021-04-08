import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/resources/constants.dart';

class Post_ApiService {
  Post_ApiService();
  Post _post;

//Consultar todos los posts
  Future<ApiResponse> getAllPosts(int page) async {
    var listPosts = <Post>[];
    var queryParameters = {'page': page.toString()};

    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetPosts, queryParameters);
    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listPosts.add(Post.fromJson(i));
        return i;
      });
      apiResponse.object = listPosts;
    }

    return apiResponse;
  }

//Consultar un post especifico por id del Post
  Future<ApiResponse> getPostById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetPosts + '/' + id.toString());

    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _post = Post.fromJson(resBody['data']);
      apiResponse.object = _post;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

//Consultar los post especifico por id del User
  Future<ApiResponse> getAllPostByUserId(int idUser) async {
    var listPosts = <Post>[];
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority,
        Constants.urlgetUsers +
            '/' +
            idUser.toString() +
            Constants.urlgetPostsByUserId);

    var res = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody['data'].forEach((i) {
        listPosts.add(Post.fromJson(i));
        return i;
      });
      apiResponse.object = listPosts;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

//Crear un post
  Future<ApiResponse> createPost(Post post) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(post.toJson());
    var uri = Uri.https(Constants.urlAuthority, Constants.urlInsertPost);

    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _post = Post.fromJson(resBody['data']);
      apiResponse.object = _post;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modificar un post
  Future<ApiResponse> updatePost(Post post) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(post.toJson());
    var uri = Uri.https(Constants.urlAuthority,
        Constants.urlInsertPost + '/' + post.id.toString());

    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
          HttpHeaders.authorizationHeader: Constants.authorizationheader
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _post = Post.fromJson(resBody['data']);
      apiResponse.object = _post;
    } else {
      throw Exception('Fallo');
    }

    return apiResponse;
  }

  //Modulo para eliminar un post
  Future<ApiResponse> delPostById(int id) async {
    var apiResponse = ApiResponse(statusResponse: 0);
    var uri = Uri.https(
        Constants.urlAuthority, Constants.urlgetPosts + '/' + id.toString());

    var res = await http.delete(uri, headers: {
      HttpHeaders.contentTypeHeader: Constants.contentTypeHeader,
      HttpHeaders.authorizationHeader: Constants.authorizationheader
    });

    apiResponse.statusResponse = res.statusCode;
    return apiResponse;
  }
}
