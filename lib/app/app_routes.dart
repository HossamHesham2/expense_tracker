import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/edit_transaction_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transaction_details_screen.dart';
import 'package:expense_tracker/features/add_transactions/presentation/pages/add_transaction_screen.dart';
import 'package:expense_tracker/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_screen.dart';
import 'package:expense_tracker/features/auth/presentation/pages/register_screen.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:expense_tracker/features/main_layout.dart';
import 'package:expense_tracker/features/profile/presentation/pages/profile_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case RoutesName.register:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case RoutesName.mainLayout:
        return CupertinoPageRoute(builder: (context) => MainLayout());
      case RoutesName.home:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case RoutesName.transactions:
        return CupertinoPageRoute(builder: (context) => TransactionsScreen());
      case RoutesName.transactionDetails:
        return CupertinoPageRoute(
          builder: (context) => TransactionDetailsScreen(),
          settings: settings,
        );
      case RoutesName.addTransaction:
        return CupertinoPageRoute(builder: (context) => AddTransactionScreen());
      case RoutesName.editTransaction:
        return CupertinoPageRoute(
          builder: (context) => EditTransactionScreen(),
          settings: settings,
        );
      case RoutesName.analytics:
        return CupertinoPageRoute(builder: (context) => AnalyticsScreen());
      case RoutesName.profile:
        return CupertinoPageRoute(builder: (context) => ProfileScreen());

      default:
        return CupertinoPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text("No Route defined"))),
        );
    }
  }
}
