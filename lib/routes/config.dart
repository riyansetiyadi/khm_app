import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/screen/kosmetik/about_us_screen.dart';
import 'package:khm_app/screen/pasien/login_screen.dart';
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
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
  redirect: (context, state) {
    if (state.fullPath == '/webview') {
      String url = state.uri.queryParameters['url'] ?? '';
      String? path = getResponseFromUrl(url);
      if (path != null) return path;
    }

    return null;
  },
);
