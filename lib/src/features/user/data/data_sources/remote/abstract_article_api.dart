import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/articles/domain/models/article_response_model.dart';
import 'package:khm_app/src/features/articles/domain/models/article_model.dart';
import 'package:khm_app/src/features/user/domain/models/user_model.dart';
import 'package:khm_app/src/features/user/domain/usecases/articles_usecase.dart';

abstract class AbstractArticleApi {
  // Get all article
  Future<ApiResponse<List<UserModel>>> getArticles(ArticlesParams params);
}
