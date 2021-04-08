import 'dart:async';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';

class UserListBase {}

class GetListEvent extends UserListBase {}

class UserListBloc {
  final StreamController<UserListBase> _input = StreamController();
  // final StreamController<List<User>> _output = StreamController();
  final StreamController<List<User>> _output = StreamController();

  Stream<List<User>> get counterStream => _output.stream;
  StreamSink<UserListBase> get sendEvent => _input.sink;
  var listUsers = <User>[];

  UserListBloc() {
    _input.stream.listen(_onEvent);
  }

  void dispose() {
    // _input.close();
    _output.close();
  }

  Future<void> _onEvent(UserListBase event) async {
    // if (event is RegisterEvent) {}
    // final _rep = General_user_repository();

    // print(_rep);

    ApiResponse _api;
    final _rep = General_user_repository();
    _api = await _rep.getAllUsers(1);

    listUsers = _api.object;

    print(listUsers.length.toString());
    // _api = await _rep.getAllUsers(74);
    _output.add(listUsers);
  }
}
