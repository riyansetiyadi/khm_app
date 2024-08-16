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
      case 'addroom':
        return AppPage.addroom;
      case 'chat':
        return AppPage.chat;
      case 'cart':
        return AppPage.cart;
      case 'riwayat':
        return AppPage.riwayat;
      case 'shop':
        return AppPage.shop;
      case 'registerkonsul':
        return AppPage.registerkonsul;
      case 'registeraddress':
        return AppPage.registeraddress;
      case 'checkout':
        return AppPage.checkout;
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
      case AppPage.addroom:
        return RouteInformation(uri: Uri.parse('/addroom'));
      case AppPage.chat:
        return RouteInformation(uri: Uri.parse('/chat'));
      case AppPage.cart:
        return RouteInformation(uri: Uri.parse('/cart'));
      case AppPage.riwayat:
        return RouteInformation(uri: Uri.parse('/riwayat'));
      case AppPage.registerkonsul:
        return RouteInformation(uri: Uri.parse('/registerkonsul'));
      case AppPage.registeraddress:
        return RouteInformation(uri: Uri.parse('/registeraddress'));
      case AppPage.checkout:
        return RouteInformation(uri: Uri.parse('/checkout'));
    }
  }
}
