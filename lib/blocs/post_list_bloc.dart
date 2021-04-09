import 'dart:async';
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/posts/repository/general_post_repository.dart';

class PostListBase {}

class GetListEvent extends PostListBase {}

class PostListBloc {
  final StreamController<PostListBase> _input = StreamController();
  final StreamController<List<Post>> _output = StreamController();

  Stream<List<Post>> get listStream => _output.stream;
  StreamSink<PostListBase> get sendEvent => _input.sink;

  var listPosts = <Post>[];

  PostListBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    _input.close();
    _output.close();
  }

  Future<void> _onEvent(PostListBase event) async {
    ApiResponse _api;
    final _rep = General_post_repository();
    _api = await _rep.getAllPosts(1);
    listPosts = _api.object;
    _output.add(listPosts);
  }
}
