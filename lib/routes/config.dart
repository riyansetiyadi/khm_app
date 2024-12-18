import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/db/auth_kosmetik_repository.dart';
import 'package:khm_app/db/auth_pasien_repository.dart';
import 'package:khm_app/screen/kosmetik/about_us_screen.dart';
import 'package:khm_app/screen/kosmetik/cart_screen.dart';
import 'package:khm_app/screen/kosmetik/checkout_screen.dart';
import 'package:khm_app/screen/kosmetik/product_screen.dart';
import 'package:khm_app/screen/kosmetik/transaction_screen.dart';
import 'package:khm_app/screen/kosmetik/home_screen.dart';
import 'package:khm_app/screen/kosmetik/login_screen.dart';
import 'package:khm_app/screen/kosmetik/profile_screen.dart';
import 'package:khm_app/screen/kosmetik/register_address_screen.dart';
import 'package:khm_app/screen/kosmetik/register_konsul_screen.dart';
import 'package:khm_app/screen/kosmetik/register_screen.dart';
import 'package:khm_app/screen/kosmetik/transactions_screen.dart';
import 'package:khm_app/screen/kosmetik/setting_screen.dart';
import 'package:khm_app/screen/kosmetik/shop_screen.dart';
import 'package:khm_app/screen/kosmetik/receipt_screen.dart';
import 'package:khm_app/screen/pasien/daftar_pasien_lama_screen.dart';
import 'package:khm_app/screen/pasien/login_screen.dart';
import 'package:khm_app/screen/pasien/menu_pasien.dart';
import 'package:khm_app/screen/pasien/register_screen.dart';
import 'package:khm_app/screen/pasien/riwayat_kunjungan_screen.dart';
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
      path: '/home-kosmetik',
      builder: (context, state) => HomeKosmetikScreen(),
    ),
    GoRoute(
      path: '/shop-kosmetik',
      builder: (context, state) => ShopScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return ProductScreen(
          id: int.parse(id),
        );
      },
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
      builder: (context, state) => TransactionsScreen(),
    ),
    GoRoute(
      path: '/detail-riwayat/:nota',
      builder: (context, state) {
        final nota = state.pathParameters["nota"]!;
        return TransactionScreen(
          nota: nota,
        );
      },
    ),
    GoRoute(
      path: '/receipt-transaction-kosmetik',
      builder: (context, state) => ReceiptScreen(),
    ),
    GoRoute(
      path: '/checkout-kosmetik',
      builder: (context, state) => CheckoutScreen(),
    ),
    GoRoute(
      path: '/login-pasien',
      builder: (context, state) => LoginPasienScreen(),
    ),
    GoRoute(
      path: '/register-pasien',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/menu-pasien',
      builder: (context, state) => MenuPasienScreen(),
    ),
    GoRoute(
      path: '/daftar-pasien-lama',
      builder: (context, state) => DaftarPasienLamaScreen(),
    ),
    GoRoute(
      path: '/riwayat-kunjungan-pasien',
      builder: (context, state) => RiwayatKunjunganScreen(),
    ),
  ],
  redirect: (context, state) async {
    if (state.fullPath == '/webview') {
      String url = state.uri.queryParameters['url'] ?? '';
      String? path = getResponseFromUrl(url);
      if (path != null) return path;
    }

    final authKosmetikRepository = AuthKosmetikRepository();
    bool isLoggedInKosmetik = await authKosmetikRepository.isLoggedInKosmetik();
    if (state.fullPath == '/setting-kosmetik' && !isLoggedInKosmetik)
      return '/login-kosmetik';

    final authPasienRepository = AuthPasienRepository();
    bool isLoggedInPasien = await authPasienRepository.isLoggedInPasien();
    print(isLoggedInPasien);
    if ((state.fullPath == '/login-pasien' ||
            state.fullPath == '/register-pasien') &&
        isLoggedInPasien) return '/menu-pasien';

    return null;
  },
);
