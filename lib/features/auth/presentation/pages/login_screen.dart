import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/widgets/custom_icon.dart';
import 'package:expense_tracker/core/widgets/custom_text_field.dart';
import 'package:expense_tracker/core/widgets/primary_button.dart';
import 'package:expense_tracker/features/auth/presentation/widget/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  CustomIcon(
                    containerColor: AppColors.green16A3,
                    svgsName: SvgsName.barChart,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Welcome back 👋",
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Login to your account",
                    style: context.titleLarge.copyWith(
                      color: AppColors.gray6B72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: "Email",
                    hintText: "Enter your email",
                    prefix: Padding(
                      padding: EdgeInsetsGeometry.all(14),
                      child: SvgPicture.asset(SvgsName.mail),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: "Password",
                    hintText: "Enter your password",
                    obscureText: obscureText,
                    prefix: Padding(
                      padding: EdgeInsetsGeometry.all(14),
                      child: SvgPicture.asset(SvgsName.lock),
                    ),
                    suffix: GestureDetector(
                      onTap: () => setState(() {
                        obscureText = !obscureText;
                      }),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(14),
                        child: SvgPicture.asset(
                          obscureText ? SvgsName.eye : SvgsName.eyeClosed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget password ?",
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.green16A3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  PrimaryButton(text: "Login", onTap: () {}),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.gray6B72,
                          thickness: 1.h,
                          endIndent: 16.w,
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: context.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray6B72,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.gray6B72,
                          thickness: 1.h,
                          indent: 16.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(svgName: SvgsName.google, name: 'Google'),
                      SizedBox(width: 20.h),
                      SocialButton(svgName: SvgsName.apple, name: 'Apple'),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray6B72,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.register,
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Register",
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.green16A3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
