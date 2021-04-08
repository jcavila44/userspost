import 'package:flutter_test/flutter_test.dart';
import 'package:userspost/repository/comments/repository/general_comment_repository.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/models/comments/comments_model.dart';

void main() {
  final _rep = General_comment_repository();
  ApiResponse _api;
  Comments _comm;

  var listComms = <Comments>[];

  group('Test ApiServices Comments', () {
    test('Test getAllComments', () async {
      _api = await _rep.getAllComments(1);

      expect(_api.statusResponse, 200);
      listComms = _api.object;
      print(listComms.length);

      for (var i = 0; i < listComms.length; i++) {
        print(listComms[i].name);
      }
    });

    test('test getCommentById', () async {
      _api = await _rep.getCommentById(1);

      _comm = _api.object;
      print('id ' + _comm.id.toString());
      print('nombre ' + _comm.name);
      expect(_api.statusResponse, 200);
    });

    test('test getAllCommentsByUserId', () async {
      _api = await _rep.getAllCommentsByUserId(1);

      listComms = _api.object;
      print(listComms.length);

      for (var i = 0; i < listComms.length; i++) {
        print(listComms[i].name);
      }
      expect(_api.statusResponse, 200);
    });

    test('test createComment', () async {
      var comm = Comments(
          post_id: 1,
          name: 'Juanito Alimaña',
          email: 'hlavo@salsa.io',
          body: 'Yo, soy el cantante.');

      _api = await _rep.createComment(comm);

      _comm = _api.object;
      print(_api.statusResponse);
      expect(_api.statusResponse, 200);
    });

    test('test updateComment', () async {
      var comm = Comments(
          id: 1,
          post_id: 1,
          name: 'Juanito Alimaña',
          email: 'hlavo@salsa.io',
          body: 'Yo, soy el cantante.');

      _api = await _rep.updateComment(comm);

      _comm = _api.object;
      print(_api.statusResponse);
      expect(_api.statusResponse, 200);
    });

    test('test delPostById', () async {
      _api = await _rep.delCommentById(1385);
      expect(_api.statusResponse, 200);
    });
  });
}
