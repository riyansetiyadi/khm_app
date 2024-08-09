import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/screens/home_screen.dart';
import 'package:khm_app/screens/login_screen.dart';
import 'package:khm_app/screens/profil_screen.dart';
import 'package:khm_app/screens/register_screen.dart';
import 'package:khm_app/screens/shop_screen.dart';
import 'package:khm_app/screens/splash_screen.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/list_auth_page.dart';
import 'package:khm_app/utils/list_auth_required_page.dart';
import 'package:khm_app/utils/list_bottom_nav_page.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _init() async {
    var result = await Future.wait([
      Future.delayed(const Duration(seconds: 5)),
      authRepository.isLoggedIn(),
    ]);
    isLoggedIn = result[1];
    _pageStack = [AppPage.home];
    notifyListeners();
  }

  List<AppPage> _pageStack = [AppPage.splash];

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  AppPage get currentConfiguration => _pageStack.last;

  bool isLoggedIn = false;
  int currentBottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        pages: _pageStack.map((page) {
          switch (page) {
            case AppPage.home:
              return MaterialPage(
                key: ValueKey(AppPage.home),
                child: HomeScreen(onTapped: _handleTapped),
              );
            case AppPage.splash:
              return MaterialPage(
                key: ValueKey(AppPage.splash),
                child: SplashScreen(),
              );
            case AppPage.shop:
              return MaterialPage(
                key: ValueKey(AppPage.shop),
                child: ShopScreen(onTapped: _handleTapped),
              );
            case AppPage.profile:
              return MaterialPage(
                key: ValueKey(AppPage.profile),
                child: ProfilScreen(onTapped: _handleTapped),
              );
            case AppPage.login:
              return MaterialPage(
                key: ValueKey(AppPage.login),
                child: LoginScreen(onTapped: _handleTapped),
              );
            case AppPage.register:
              return MaterialPage(
                key: ValueKey(AppPage.register),
                child: RegisterScreen(onTapped: _handleTapped),
              );
          }
        }).toList(),
        onPopPage: (route, result) {
          final didPop = route.didPop(result);

          if (!didPop) {
            return false;
          }

          _pageStack.removeLast();
          currentBottomNavigationIndex = 0;
          notifyListeners();

          return true;
        },
      ),
      bottomNavigationBar: bottomNavPages.contains(_pageStack.last)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 0,
              currentIndex: currentBottomNavigationIndex,
              backgroundColor: Colors.green,
              selectedItemColor: Color(0xFF198754),
              unselectedItemColor: Colors.white,
              onTap: (index) {
                if (index == 0) {
                  Future.microtask(
                      () async => productProvider.getNewProductsHome());
                  _handleTapped(AppPage.home);
                } else if (index == 1) {
                  _handleTapped(AppPage.home);
                } else if (index == 2) {
                  _handleTapped(AppPage.shop);
                  Future.microtask(() async => productProvider.getProducts());
                } else if (index == 3) {
                  _handleTapped(AppPage.home);
                } else if (index == 4) {
                  _handleTapped(AppPage.profile);
                }
                notifyListeners();
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_rounded), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store_rounded), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_rounded), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
              ],
            )
          : null,
    );
  }

  void _handleTapped(AppPage page) async {
    if (page == AppPage.home) {
      currentBottomNavigationIndex = 0;
      // } else if (page == AppPage.shop) {
      //   currentBottomNavigationIndex = 1;
    } else if (page == AppPage.profile) {
      currentBottomNavigationIndex = 4;
    }

    isLoggedIn = await authRepository.isLoggedIn();
    if (authRequiredPages.contains(page) && !isLoggedIn) {
      // Jika mengunjungi halaman yang perlu login dan belum login
      _pageStack.removeWhere((page) => !authPages.contains(page));
      _pageStack.add(_handleDuplicatePage(AppPage.login));
    } else if (authPages.contains(page) && isLoggedIn) {
      // Jika mengunjungi halaman untuk login atau register dan sudah login
      _pageStack.removeWhere((page) => authPages.contains(page));
      _pageStack.add(_handleDuplicatePage(AppPage.home));
    } else {
      _pageStack.add(_handleDuplicatePage(page));
    }

    notifyListeners();
  }

  AppPage _handleDuplicatePage(AppPage page) {
    if (!_pageStack.contains(page)) {
      return page;
    } else {
      _pageStack.remove(page);
      return page;
    }
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (_pageStack.isEmpty || _pageStack.last != configuration) {
      _pageStack.add(configuration);
    }
  }
}
