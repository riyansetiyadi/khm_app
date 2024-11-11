import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/screen/kosmetik/about_us_screen.dart';
import 'package:khm_app/screen/kosmetik/cart_screen.dart';
import 'package:khm_app/screen/kosmetik/home_screen.dart';
import 'package:khm_app/screen/kosmetik/login_screen.dart';
import 'package:khm_app/screen/kosmetik/profile_screen.dart';
import 'package:khm_app/screen/kosmetik/register_address_screen.dart';
import 'package:khm_app/screen/kosmetik/register_konsul_screen.dart';
import 'package:khm_app/screen/kosmetik/register_screen.dart';
import 'package:khm_app/screen/kosmetik/riwayat_screen.dart';
import 'package:khm_app/screen/kosmetik/setting_screen.dart';
import 'package:khm_app/screen/kosmetik/shop_screen.dart';
import 'package:khm_app/screen/pasien/daftar_pasien_lama_screen.dart';
import 'package:khm_app/screen/pasien/login_screen.dart';
import 'package:khm_app/screen/pasien/menu_pasien.dart';
import 'package:khm_app/screen/pasien/register2_screen.dart';
import 'package:khm_app/screen/pasien/register_screen.dart';
import 'package:khm_app/screen/pasien/riwayat_registrasi_screen.dart';
import 'package:khm_app/screen/simkhm/home_screen.dart';
import 'package:khm_app/screen/simkhm/layanan_screen.dart';
import 'package:khm_app/screen/simkhm/pendaftaran_poli_screen.dart';
import 'package:khm_app/screen/webview_screen.dart';
import 'package:khm_app/utils/response_from_urls.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeSimkhmScreen(),
    ),
    GoRoute(
      path: '/layanan',
      builder: (context, state) => const LayananScreen(),
    ),
    GoRoute(
      path: '/pendaftaran',
      builder: (context, state) => const PendaftaranPoliScreen(),
    ),
    GoRoute(
      path: '/kosmetik_about_us',
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: '/webview',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? '';
        return WebviewScreen(url: url);
      },
    ),
    GoRoute(
      path: '/login-pasien',
      builder: (context, state) => LoginPasienScreen(),
    ),
    GoRoute(
      path: '/home-kosmetik',
      builder: (context, state) => HomeKosmetikScreen(),
    ),
    GoRoute(
      path: '/shop-kosmetik',
      builder: (context, state) => ShopScreen(),
    ),
    GoRoute(
      path: '/profile-kosmetik',
      builder: (context, state) => ProfileKosmetikScreen(),
    ),
    GoRoute(
      path: '/login-kosmetik',
      builder: (context, state) => LoginKosmetikScreen(),
    ),
    GoRoute(
      path: '/register-kosmetik',
      builder: (context, state) => RegisterKosmetikScreen(),
    ),
    GoRoute(
      path: '/setting-kosmetik',
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: '/register-konsul-kosmetik',
      builder: (context, state) => RegisterKonsulScreen(),
    ),
    GoRoute(
      path: '/register-address-kosmetik',
      builder: (context, state) => RegisterAddressScreen(),
    ),
    GoRoute(
      path: '/cart-kosmetik',
      builder: (context, state) => CartScreen(),
    ),
    GoRoute(
      path: '/riwayat-shop-kosmetik',
      builder: (context, state) => RiwayatScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/register2',
      builder: (context, state) => Register2Screen(),
    ),
    GoRoute(
      path: '/menu_pasien',
      builder: (context, state) => MenuPasienScreen(),
    ),
    GoRoute(
      path: '/daftar_pasien_lama',
      builder: (context, state) => DaftarPasienLamaScreen(),
    ),
    GoRoute(
      path: '/riwayat_registrasi',
      builder: (context, state) => RiwayatRegistrasiScreen(),
    ),
  ],
  redirect: (context, state) async {
    if (state.fullPath == '/webview') {
      String url = state.uri.queryParameters['url'] ?? '';
      String? path = getResponseFromUrl(url);
      if (path != null) return path;
    }

    final authRepository = AuthRepository();
    bool isLoggedInKosmetik = await authRepository.isLoggedInKosmetik();
    if (state.fullPath == '/setting-kosmetik' && !isLoggedInKosmetik)
      return '/login-kosmetik';

    return null;
  },
);
