import 'package:userspost/models/comments/comments_model.dart';
import 'package:userspost/repository/comments/comment_ApiService.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';

class General_comment_repository {
  final commApi = Comment_ApiService();

  Future<ApiResponse> getAllComments(int page) => commApi.getAllComments(page);
  Future<ApiResponse> getCommentById(int id) => commApi.getCommentById(id);
  Future<ApiResponse> getAllCommentsByUserId(int idUser) =>
      commApi.getAllCommentsByUserId(idUser);
  Future<ApiResponse> createComment(Comments comm) =>
      commApi.createComment(comm);
  Future<ApiResponse> updateComment(Comments comm) =>
      commApi.updateComment(comm);
  Future<ApiResponse> delCommentById(int id) => commApi.delCommentById(id);
}
