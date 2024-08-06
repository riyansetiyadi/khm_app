import 'package:get_it/get_it.dart';
import 'package:khm_app/src/core/network/dio_network.dart';
import 'package:khm_app/src/features/user/user_injections.dart';
import 'package:khm_app/src/shared/app_injections.dart';
import 'package:khm_app/src/core/utils/log/app_logger.dart';
import 'package:khm_app/src/features/articles/articles_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  // await initArticlesInjections();
  await initUserInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
