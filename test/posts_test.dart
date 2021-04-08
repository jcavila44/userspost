import 'package:flutter_test/flutter_test.dart';
import 'package:userspost/repository/posts/repository/general_post_repository.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/models/post/post_model.dart';

void main() {
  group('Test ApiServices Post', () {
    test('Test getAllPosts', () async {
      var listPosts = <Post>[];
      ApiResponse _api;
      final _rep = General_post_repository();
      _api = await _rep.getAllPosts(1);

      expect(_api.statusResponse, 200);
      listPosts = _api.object;
      print(listPosts.length);

      for (var i = 0; i < listPosts.length; i++) {
        print(listPosts[i].title);
      }
    });

    test('test getPostById', () async {
      ApiResponse _api;
      Post post;

      final _rep = General_post_repository();
      _api = await _rep.getPostById(1);

      post = _api.object;
      print('id ' + post.id.toString());
      print('titulo ' + post.title);
      expect(_api.statusResponse, 200);
    });

    test('test getAllPostByUserId', () async {
      var listPosts = <Post>[];
      ApiResponse _api;

      final _rep = General_post_repository();
      _api = await _rep.getAllPostByUserId(1);

      listPosts = _api.object;
      print(listPosts.length);

      for (var i = 0; i < listPosts.length; i++) {
        print(listPosts[i].title);
      }
      expect(_api.statusResponse, 200);
    });

    test('test createPost', () async {
      ApiResponse _api;

      var post = Post(
          user_id: 1,
          title: 'post de prueba',
          body:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.');

      final _rep = General_post_repository();
      _api = await _rep.createPost(post);

      post = _api.object;
      print(_api.statusResponse);
      expect(_api.statusResponse, 200);
    });

    test('test updatePost', () async {
      ApiResponse _api;

      var post = Post(
          id: 1379,
          user_id: 1,
          title: 'post de prueba actualizado',
          body: 'abcdefghijklmnopqrstuvwxyz');

      final _rep = General_post_repository();
      _api = await _rep.updatePost(post);

      post = _api.object;
      print(_api.statusResponse);
      expect(_api.statusResponse, 200);
    });

    test('test delPostById', () async {
      ApiResponse _api;

      final _rep = General_post_repository();
      _api = await _rep.delPostById(1385);
      expect(_api.statusResponse, 200);
    });
  });
}
