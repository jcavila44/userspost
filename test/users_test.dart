import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';
import 'package:userspost/models/user/user_model.dart';

void main() {
  group('Test ApiService', () {
    test('Test getAllUsers', () async {
      List<User> listUsers = [];
      ApiResponse _api;
      final _rep = General_user_repository();
      _api = await _rep.getAllUsers();

      expect(_api.statusResponse, 200);
      print('======================');

      listUsers = _api.object;

      print(listUsers.length);

      for (var i = 0; i < listUsers.length; i++) {
        print(listUsers[i].name);
      }
    });
  });
}
