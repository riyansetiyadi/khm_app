import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/screens/chat_screen.dart';
import 'package:khm_app/screens/home_screen.dart';
import 'package:khm_app/screens/profil_screen.dart';
import 'package:khm_app/screens/addroom_screen.dart';
import 'package:khm_app/screens/cart_screen.dart';
import 'package:khm_app/screens/checkout_screen.dart';
import 'package:khm_app/screens/detail_history_screen.dart';
import 'package:khm_app/screens/detail_product_screen.dart';
import 'package:khm_app/screens/login_screen.dart';
import 'package:khm_app/screens/register_screen.dart';
import 'package:khm_app/screens/registeraddress_screen.dart';
import 'package:khm_app/screens/registerkonsul_screen.dart';
import 'package:khm_app/screens/setting_screen.dart';
import 'package:khm_app/screens/shop_screen.dart';
import 'package:khm_app/screens/splash_screen.dart';
import 'package:khm_app/screens/upload_bukti_pembayaran_screen.dart';
import 'package:khm_app/screens/riwayat_screen.dart';
import 'package:khm_app/screens/upload_file_chat_screen.dart';
import 'package:khm_app/utils/list_auth_page.dart';
import 'package:khm_app/utils/list_auth_required_page.dart';
import 'package:khm_app/utils/list_bottom_nav_page.dart';
import 'package:khm_app/widgets/scaffold_with_bottom_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

//tabs kesy
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _chatTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, GoRouterState state) {
                return getPage(
                  child: const HomeScreen(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _chatTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/addroom',
              pageBuilder: (context, GoRouterState state) {
                return getPage(
                  child: const AddRoomScreen(),
                  state: state,
                );
              },
              routes: [
                GoRoute(
                  path: 'chat',
                  builder: (context, state) => ChatScreen(),
                  routes: [
                    GoRoute(
                      path: 'filechat',
                      builder: (context, state) => UploadFileChatScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/setting',
              pageBuilder: (context, state) {
                return getPage(
                  child: const SettingScreen(),
                  state: state,
                );
              },
              routes: [
                GoRoute(
                  path: 'profile',
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const ProfilScreen(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/login',
              pageBuilder: (context, state) {
                return getPage(
                  child: const LoginScreen(),
                  state: state,
                );
              },
            ),
            GoRoute(
              path: '/register',
              pageBuilder: (context, state) {
                return getPage(
                  child: const RegisterScreen(),
                  state: state,
                );
              },
            ),
          ],
        ),
      ],
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return getPage(
          child: (bottomNavPages.contains(state.fullPath))
              ? ScaffoldWithBottomBar(
                  child: navigationShell,
                  location: state.fullPath ?? '/',
                )
              : navigationShell,
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, GoRouterState state) {
        return getPage(
          child: const CartScreen(),
          state: state,
        );
      },
      routes: [
        GoRoute(
          path: 'checkout',
          pageBuilder: (context, GoRouterState state) {
            return getPage(
              child: const Checkout(),
              state: state,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/shop',
      pageBuilder: (context, GoRouterState state) {
        return getPage(
          child: const ShopScreen(),
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/detailproduct/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters["id"]!;
        return getPage(
          child: DetailProduct(
            id: int.parse(id),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/riwayat',
      builder: (context, state) => RiwayatScreen(),
    ),
    GoRoute(
      path: '/registerkonsul',
      builder: (context, state) => RegisterKonsulScreen(),
    ),
    GoRoute(
      path: '/registeraddress',
      builder: (context, state) => RegisterAddress(),
    ),
    GoRoute(
      path: '/detailhistory/:nota',
      pageBuilder: (context, state) {
        final nota = state.pathParameters["nota"]!;
        return getPage(
          child: DetailHistory(
            nota: nota,
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: '/buktipembayaran',
      builder: (context, state) => UploadBuktiPembayaranScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    print(state.fullPath);
    final authRepository = AuthRepository();
    bool isLoggedIn = await authRepository.isLoggedIn();
    if (authRequiredPages.contains(state.fullPath) && !isLoggedIn)
      return '/login';
    if (authPages.contains(state.fullPath) && isLoggedIn) return '/';
    if (state.fullPath == '/checkout' &&
        await authRepository.isChekoutDataComplete()) return '/registeraddress';

    return null;
  },
);

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}
