import 'package:dartz/dartz.dart';
import 'package:khm_app/src/core/network/error/failures.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/user/domain/models/user_model.dart';

abstract class AbstractArticlesRepository {
  // Gent Ny Times Articles
  Future<Either<Failure, List<UserModel>>> getArticles(ArticlesParams params);
}
