import 'package:capacious/features/presentation/pages/main_page.dart';
import 'package:capacious/features/presentation/pages/signin_page.dart';
import 'package:capacious/features/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return pageRoute(page: const MainPage());
      case SignInPage.routeName:
        return pageRoute(page: const SignInPage());
      case SignUpPage.routeName:
        return pageRoute(page: const SignUpPage());
      default:
        return pageRoute(page: const SignUpPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
