import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/repository/users/user_ApiService.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';

class General_user_repository {
  final userApi = User_ApiService();

  Future<ApiResponse> getAllUsers() => userApi.getAllUsers();
  Future<ApiResponse> getUserById(int id) => userApi.getUserById(id);

  Future<ApiResponse> createUser(User user) => userApi.createUser(user);
}
