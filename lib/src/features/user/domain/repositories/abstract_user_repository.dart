import 'package:dartz/dartz.dart';
import 'package:khm_app/src/core/network/error/failures.dart';
import 'package:khm_app/src/features/articles/domain/models/article_model.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';

abstract class AbstractUserRepository {
  // Gent Ny Times Articles
  Future<Either<Failure, List<ArticleModel>>> getArticles(
      ArticlesParams params);
}
