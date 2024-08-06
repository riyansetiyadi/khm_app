import 'package:dartz/dartz.dart';
import 'package:khm_app/src/core/network/error/exceptions.dart';
import 'package:khm_app/src/core/network/error/failures.dart';
import 'package:khm_app/src/features/articles/data/data_sources/remote/articles_impl_api.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:khm_app/src/features/user/domain/models/user_model.dart';

class UserRepositoryImpl extends AbstractArticlesRepository {
  final ArticlesImplApi articlesApi;

  UserRepositoryImpl(
    this.articlesApi,
  );

  // Gent Ny Times Articles
  @override
  Future<Either<Failure, List<UserModel>>> getArticles(
      ArticlesParams params) async {
    try {
      final result = await articlesApi.getArticles(params);
      return Right(result.results ?? []);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
