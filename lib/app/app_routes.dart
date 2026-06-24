import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_screen.dart';
import 'package:expense_tracker/features/auth/presentation/pages/register_screen.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case RoutesName.register:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case RoutesName.home:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      default:
        return CupertinoPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text("No Route defined"))),
        );
    }
  }
}
