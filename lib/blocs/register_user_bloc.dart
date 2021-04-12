import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';

class RegisterUserBase {
  final User user;
  RegisterUserBase({this.user});
}

var user = User();

class RegisterEvent extends RegisterUserBase {
  RegisterEvent({@required User user}) : super(user: user);
}

class RegisterUserBloc {
  final StreamController<RegisterUserBase> _input = StreamController();
  final StreamController<User> _output = StreamController();

  Stream<User> get registerStream => _output.stream;
  StreamSink<RegisterUserBase> get sendEvent => _input.sink;

  RegisterUserBloc() {
    _input.stream.listen(_onEvent);
  }

  Future<void> _onEvent(RegisterUserBase event) async {
    if (event is RegisterEvent) {
      event.user.status = 'Active';
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.createUser(event.user);
      _output.add(_api.object);
    }
  }
}
