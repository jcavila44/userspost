import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/posts/repository/general_post_repository.dart';

class RegisterPostBase {
  final Post posts;
  RegisterPostBase({this.posts});
}

var posts = Post();

class RegisterEvent extends RegisterPostBase {
  RegisterEvent({@required Post posts}) : super(posts: posts);
}

class RegisterPostBloc {
  final StreamController<RegisterPostBase> _input = StreamController();
  final StreamController<Post> _output = StreamController();

  Stream<Post> get registerStream => _output.stream;
  StreamSink<RegisterPostBase> get sendEvent => _input.sink;

  RegisterPostBloc() {
    _input.stream.listen(_onEvent);
  }

  Future<void> _onEvent(RegisterPostBase event) async {
    if (event is RegisterEvent) {
      // event.posts.status = 'Active';
      ApiResponse _api;
      final _rep = General_post_repository();
      _api = await _rep.createPost(event.posts);
      _output.add(_api.object);
    }
  }
}
