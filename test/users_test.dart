import 'package:flutter_test/flutter_test.dart';
import 'package:userspost/repository/users/repository/general_user_repository.dart';
import 'package:userspost/models/user/user_model.dart';

void main() {
  group('Users', () {
    test('Test getUserById but All', () {
      final user = General_user_repository();
      final usr = User();

      print(user.getUserById(usr));
    });
  });
}
