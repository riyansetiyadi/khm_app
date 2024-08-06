import 'package:bloc/bloc.dart';
import 'package:khm_app/src/core/network/error/failures.dart';
import 'package:khm_app/src/core/utils/constant/app_constants.dart';
import 'package:khm_app/src/features/articles/domain/models/article_model.dart';
import 'package:khm_app/src/features/articles/domain/models/articles_params.dart';
import 'package:khm_app/src/features/articles/domain/usecases/articles_usecase.dart';
import 'package:khm_app/src/features/user/domain/models/user_model.dart';
import 'package:khm_app/src/features/user/presentation/bloc/user_event.dart';

part 'articles_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, ArticlesState> {
  final ArticlesUseCase articlesUseCase;

  // List of articles
  List<UserModel> allArticles = [];

  UserBloc({required this.articlesUseCase}) : super(LoadingGetUserState()) {
    on<OnGettingArticlesEvent>(_onGettingArticlesEvent);
    on<OnSearchingArticlesEvent>(_onSearchingEvent);
  }

// Getting articles event
  _onGettingArticlesEvent(
      OnGettingArticlesEvent event, Emitter<ArticlesState> emitter) async {
    if (event.withLoading) {
      emitter(LoadingGetUserState());
    }

    final result = await articlesUseCase.call(
      ArticlesParams(
        period: event.period,
      ),
    );
    result.fold((l) {
      if (l is CancelTokenFailure) {
        emitter(LoadingGetUserState());
      } else {
        emitter(ErrorGetArticlesState(l.errorMessage));
      }
    }, (r) {
      // Return list of articles with filtered by search text
      allArticles = r;
      emitter(SuccessGetArticlesState(_runFilter(event.text)));
    });
  }

  // Searching event
  _onSearchingEvent(
      OnSearchingArticlesEvent event, Emitter<ArticlesState> emitter) async {
    emitter(
      SearchingState(
        _runFilter(event.text),
      ),
    );
  }

  // This function is called whenever the text field changes
  List<UserModel> _runFilter(
    String text,
  ) {
    List<UserModel> results = [];
    if (text.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = List.from(allArticles);
    } else {
      results = allArticles.where((user) {
        return (user.title ?? defaultStr)
            .toLowerCase()
            .contains(text.toLowerCase());
      }).toList();
    }
    return results;
  }
}
