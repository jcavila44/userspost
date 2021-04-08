import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/repository/posts/post_ApiService.dart';
import 'package:userspost/models/utils/apiresponse_model.dart';

class General_post_repository {
  final postApi = Post_ApiService();

  Future<ApiResponse> getAllPosts(int page) => postApi.getAllPosts(page);
  Future<ApiResponse> getPostById(int id) => postApi.getPostById(id);
  Future<ApiResponse> getAllPostByUserId(int idUser) =>
      postApi.getAllPostByUserId(idUser);
  Future<ApiResponse> createPost(Post post) => postApi.createPost(post);
  Future<ApiResponse> updatePost(Post post) => postApi.updatePost(post);
  Future<ApiResponse> delPostById(int id) => postApi.delPostById(id);
}
