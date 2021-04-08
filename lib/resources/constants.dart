class Constants {
  static const String urlAuthority = 'gorest.co.in';
  static const String pathBase = '/public-api';
  static const String contentTypeHeader = 'application/json';
  static const String authorizationheader =
      'Bearer 3b44bb1b11b0cc1e577b461e47545ffd119b99c08b0f10a6617929091c2b7b51';

  //API Users
  static const String urlgetUsers = pathBase + '/users';
  static const String urlInsertUser = pathBase + '/users';

  //API Post
  static const String urlgetPosts = pathBase + '/posts';
  static const String urlgetPostsByUserId = '/posts';
  static const String urlInsertPost = pathBase + '/posts';

  //API Comment
  static const String urlgetComments = pathBase + '/comments';
  static const String urlgetCommentsByUserId = '/comments';
  static const String urlInsertComment = pathBase + '/comments';
}
