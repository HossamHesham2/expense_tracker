import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:expense_tracker/core/constants/app_constant.dart';
import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/helpers/prefs_helper.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/utils/app_validators.dart';
import 'package:expense_tracker/core/widgets/custom_icon.dart';
import 'package:expense_tracker/core/widgets/custom_snack_bar.dart';
import 'package:expense_tracker/core/widgets/custom_text_field.dart';
import 'package:expense_tracker/core/widgets/primary_button.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/widget/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var autoValidateMode = AutovalidateMode.disabled;
  final prefs = PrefsHelper.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.loginRequest == AuthRequest.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              title: 'Success',
              message: 'Login successfully',
              contentType: ContentType.success,
            ).snackBar,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.mainLayout,
            (route) => false,
          );
        }
        if (state.loginWithGoogleRequest == AuthRequest.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              title: 'Success',
              message: 'Login Google successfully',
              contentType: ContentType.success,
            ).snackBar,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.mainLayout,
            (route) => false,
          );
        }
        if (state.loginRequest == AuthRequest.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              title: 'Error',
              message: state.loginFailure!.errMessage,
              contentType: ContentType.failure,
            ).snackBar,
          );
        }
        if (state.loginWithGoogleRequest == AuthRequest.error) {
          print("Google Error : ${state.loginWithGoogleFailure!.errMessage}");
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              title: 'Error',
              message: state.loginWithGoogleFailure!.errMessage,
              contentType: ContentType.failure,
            ).snackBar,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.all(24),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        CustomIcon(
                          containerColor: AppColors.green16A3,
                          svgsName: SvgsName.barChart,
                          label: "",
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) =>
                              AppValidators.email(value?.trim()),
                          prefix: Padding(
                            padding: EdgeInsetsGeometry.all(14),
                            child: SvgPicture.asset(SvgsName.mail),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          label: "Password",
                          hintText: "Enter your password",
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) =>
                              AppValidators.password(value?.trim()),
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
                        state.loginRequest == AuthRequest.loading
                            ? CircularProgressIndicator(
                                color: AppColors.green16A3,
                              )
                            : PrimaryButton(
                                text: "Login",
                                onTap: () {
                                  final isValid = formKey.currentState!
                                      .validate();

                                  if (!isValid) {
                                    setState(() {
                                      autoValidateMode =
                                          AutovalidateMode.onUserInteraction;
                                    });
                                    return;
                                  }
                                  prefs.setBool(AppConstant.loginKey, true);
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                },
                              ),
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
                            state.loginWithGoogleRequest == AuthRequest.loading
                                ? CircularProgressIndicator(
                                    color: AppColors.green16A3,
                                  )
                                : SocialButton(
                                    svgName: SvgsName.google,
                                    name: 'Google',
                                    onTap: () {
                                      prefs.setBool(AppConstant.loginKey, true);
                                      context.read<AuthBloc>().add(
                                        LoginWithGoogleEvent(),
                                      );
                                    },
                                  ),
                            SizedBox(width: 25.h),
                            SocialButton(
                              svgName: SvgsName.apple,
                              name: 'Apple',
                            ),
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
          ),
        );
      },
    );
  }
}
