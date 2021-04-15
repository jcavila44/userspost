import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:userspost/models/comments/comments_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/comments/repository/general_comment_repository.dart';

class CommentsPostBase {
  int id_user;
  CommentsPostBase({this.id_user});
}

class GetListEvent extends CommentsPostBase {
  GetListEvent({@required int id_user}) : super(id_user: id_user);
}

class CommentsPostBloc {
  final StreamController<CommentsPostBase> _input = StreamController();
  final StreamController<List<Comments>> _output = StreamController();

  Stream<List<Comments>> get listStream => _output.stream;
  StreamSink<CommentsPostBase> get sendEvent => _input.sink;

  var listComments = <Comments>[];

  CommentsPostBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    _input.close();
    _output.close();
  }

  Future<void> _onEvent(CommentsPostBase event) async {
    ApiResponse _api;
    final _rep = General_comment_repository();
    _api = await _rep.getAllCommentsByUserId(event.id_user);
    listComments = _api.object;
    _output.add(listComments);
  }
}
