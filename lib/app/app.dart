import 'package:expense_tracker/app/app_routes.dart';
import 'package:expense_tracker/core/constants/app_constant.dart';
import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/di/dependency_injection.dart';
import 'package:expense_tracker/core/helpers/helpers.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/features/add_transactions/presentation/bloc/add_transaction_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLogIn =
        PrefsHelper.instance.getBool(AppConstant.loginKey) ?? false;
    final String route = isLogIn ? RoutesName.mainLayout : RoutesName.login;
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthBloc>()),
          BlocProvider(create: (context) => getIt<AddTransactionBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRoutes.getRoute,
          initialRoute: route,
        ),
      ),
    );
  }
}
