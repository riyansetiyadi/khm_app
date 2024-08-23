import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/screens/home_screen.dart';
import 'package:khm_app/utils/list_auth_page.dart';
import 'package:khm_app/utils/list_auth_required_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    if (state.path == '/splash') {
      Future.delayed(const Duration(seconds: 5), () {
        return '/';
      });
    }

    final authRepository = AuthRepository();
    bool isLoggedIn = await authRepository.isLoggedIn();
    if (authRequiredPages.contains(state.path) && !isLoggedIn) return '/login';
    if (authPages.contains(state.path) && isLoggedIn) return '/';

    return null;
  },
);
