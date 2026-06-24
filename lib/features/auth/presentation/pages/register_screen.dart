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
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    "Create account",
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Sign up to get started",
                    style: context.titleLarge.copyWith(
                      color: AppColors.gray6B72.withAlpha(120),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    label: "Full name",
                    hintText: "Enter your full name",
                    prefix: Padding(
                      padding: EdgeInsetsGeometry.all(14),
                      child: SvgPicture.asset(SvgsName.user),
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
                  SizedBox(height: 20.h),

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
                        "Already have an account ? ",
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray6B72,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.login,
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Login",
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
