import 'package:dartz/dartz.dart';
import 'package:khm_app/src/core/network/error/failures.dart';
import 'package:khm_app/src/core/utils/usecases/usecase.dart';
import 'package:khm_app/src/features/articles/domain/models/article_model.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/articles/domain/repositories/abstract_articles_repository.dart';

class ArticlesUseCase extends UseCase<List<UserModel>, ArticlesParams> {
  final AbstractArticlesRepository repository;

  ArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserModel>>> call(ArticlesParams params) async {
    final result = await repository.getArticles(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
