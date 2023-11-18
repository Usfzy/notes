import 'package:flutter/material.dart';
import 'package:skeleton_app/features/home/views/pages/home_page.dart';
import 'package:skeleton_app/features/splash/splash_page.dart';

class RouteGenerator {
  const RouteGenerator._();

  static const kTitle = 'Skeleton App';

  static const kSplashPage = 'splash_screen';
  static const kLoginPage = 'login_screen';
  static const kHomePage = 'home_screen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
      case kHomePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      default:
        throw UnimplementedError('Route not found');
    }
  }
}
