import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';

class UpdateUserBase {
  final User user;
  UpdateUserBase({this.user});
}

var user = User();

class UpdateEvent extends UpdateUserBase {
  UpdateEvent({@required User user}) : super(user: user);
}

class DeleteEvent extends UpdateUserBase {
  DeleteEvent({@required User user}) : super(user: user);
}

class UpdateUserBloc {
  final StreamController<UpdateUserBase> _input = StreamController();
  final StreamController<User> _output = StreamController();
  int respinseApi = 0;

  Stream<User> get registerStream => _output.stream;
  StreamSink<UpdateUserBase> get sendEvent => _input.sink;

  UpdateUserBloc() {
    _input.stream.listen(_onEvent);
  }

  Future<void> _onEvent(UpdateUserBase event) async {
    //Cuando se quiere actualizar el usuario
    if (event is UpdateEvent) {
      event.user.status = 'Active';
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.updateUser(event.user);
      respinseApi = _api.statusResponse;
      _output.add(_api.object);

      //Cuando se quiere eliminar el usuario
    } else if (event is DeleteEvent) {
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.delUserById(event.user.id);
      respinseApi = _api.statusResponse;
      _output.add(_api.object);
    }
  }
}
