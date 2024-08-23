import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/screens/home_screen.dart';
import 'package:khm_app/screens/profil_screen.dart';
import 'package:khm_app/screens/addroom_screen.dart';
import 'package:khm_app/screens/cart_screen.dart';
import 'package:khm_app/screens/chat_screen.dart';
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
    GoRoute(
      path: '/shop',
      builder: (context, state) => ShopScreen(),
    ),
    GoRoute(
      path: '/profil',
      builder: (context, state) => ProfilScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/detailproduct',
      builder: (context, state) => DetailProduct(),
    ),
    GoRoute(
      path: '/addroom',
      builder: (context, state) => AddRoomScreen(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => CartScreen(),
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
      path: '/checkout',
      builder: (context, state) => Checkout(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: '/detailHistory',
      builder: (context, state) => DetailHistory(),
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
