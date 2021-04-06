import 'dart:async';
import 'package:userspost/models/user/user_model.dart';

class RegisterUserBase {}

class RegisterEvent extends RegisterUserBase {}

class RegisterUserBloc {
  final StreamController<RegisterUserBase> _input = StreamController();
  final StreamController<User> _output = StreamController();

  Stream<User> get counterStream => _output.stream;
  StreamSink<RegisterUserBase> get sendEvent => _input.sink;

  RegisterUserBloc() {
    _input.stream.listen(_onEvent);
  }

  void _onEvent(RegisterUserBase event) {
    if (event is RegisterEvent) {}
    _output.add(User());
  }
}
