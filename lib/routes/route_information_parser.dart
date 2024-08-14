import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPage> {
  @override
  Future<AppPage> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.path);
    if (uri.pathSegments.isEmpty) {
      return AppPage.home;
    }
    switch (uri.pathSegments.first) {
      case 'splash':
        return AppPage.splash;
      case 'profile':
        return AppPage.profile;
      // case 'shop':
      //   return AppPage.shop;
      default:
        return AppPage.home;
    }
  }

  @override
  RouteInformation? restoreRouteInformation(AppPage configuration) {
    switch (configuration) {
      case AppPage.splash:
        return RouteInformation(uri: Uri.parse('/splash'));
      case AppPage.home:
        return RouteInformation(uri: Uri.parse('/'));
      case AppPage.shop:
        return RouteInformation(uri: Uri.parse('/shop'));
      case AppPage.profile:
        return RouteInformation(uri: Uri.parse('/profile'));
      case AppPage.login:
        return RouteInformation(uri: Uri.parse('/login'));
      case AppPage.register:
        return RouteInformation(uri: Uri.parse('/register'));
      case AppPage.detailProduct:
        return RouteInformation(uri: Uri.parse('/detailproduct'));
    }
  }
}
