import 'package:currency_converter/ui/page/currency_selector_page.dart';
import 'package:currency_converter/ui/page/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/selector':
        return MaterialPageRoute(builder: (_) => CurrencySelectorPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}