import 'package:flutter/material.dart';
import 'package:skeleton_app/features/home/views/pages/cart_page.dart';
import 'package:skeleton_app/features/home/views/pages/products_page.dart';
import 'package:skeleton_app/features/home/views/pages/orders_page.dart';
import 'package:skeleton_app/features/splash/splash_page.dart';

class RouteGenerator {
  const RouteGenerator._();

  static const kTitle = 'Skeleton App';

  static const kSplashPage = 'splash_page';
  static const kLoginPage = 'login_page';
  static const kProductsPage = 'products_page';
  static const kOrdersPage = 'orders_page';
  static const kCartPage = 'cart_page';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
      case kProductsPage:
        return MaterialPageRoute(
          builder: (context) => const ProductsPage(),
        );
      case kCartPage:
        return MaterialPageRoute(
          builder: (context) => const CartPage(),
        );
      case kOrdersPage:
        return MaterialPageRoute(
          builder: (context) => const OrdersPage(),
        );

      default:
        throw UnimplementedError('Route not found');
    }
  }
}
