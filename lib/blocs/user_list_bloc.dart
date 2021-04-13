import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';

class UserListBase {
  final String search;
  UserListBase({this.search});
}

class GetListEvent extends UserListBase {}

class GetListEventSearch extends UserListBase {
  GetListEventSearch({@required String search}) : super(search: search);
}

class UserListBloc {
  final StreamController<UserListBase> _input = StreamController();
  final StreamController<List<User>> _output = StreamController();

  Stream<List<User>> get listStream => _output.stream;
  StreamSink<UserListBase> get sendEvent => _input.sink;

  var listUsers = <User>[];

  UserListBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    _input.close();
    _output.close();
  }

  Future<void> _onEvent(UserListBase event) async {
    if (event is GetListEvent) {
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.getAllUsers(1);
      listUsers = _api.object;
      _output.add(listUsers);
    } else {
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.getAllUsersSearch(1, event.search);
      listUsers = _api.object;
      _output.add(listUsers);
    }
  }
}
