import 'package:dio/dio.dart';
import 'package:khm_app/src/core/network/error/dio_error_handler.dart';
import 'package:khm_app/src/core/network/error/exceptions.dart';
import 'package:khm_app/src/core/utils/constant/network_constant.dart';
import 'package:khm_app/src/features/articles/data/data_sources/remote/abstract_article_api.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/articles/domain/models/article_response_model.dart';
import 'package:khm_app/src/features/articles/domain/models/article_model.dart';
import 'package:khm_app/src/features/articles/domain/usecases/articles_usecase.dart';
import 'package:khm_app/src/features/user/domain/models/user_model.dart';

class ArticlesImplApi extends AbstractArticleApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  ArticlesImplApi(this.dio);

  // Articles Method
  @override
  Future<ApiResponse<List<UserModel>>> getArticles(
      ArticlesParams params) async {
    try {
      final result = (await dio.get(
        getArticlePath(params.period),
      ));
      if (result.data == null)
        throw ServerException("Unknown Error", result.statusCode);

      return ApiResponse.fromJson<List<UserModel>>(
          result.data, UserModel.fromJsonList);
    } on DioError catch (e) {
      if (e.type == DioErrorType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
