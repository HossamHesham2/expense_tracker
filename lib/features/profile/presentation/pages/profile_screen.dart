import 'package:expense_tracker/core/constants/app_constant.dart';
import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/helpers/prefs_helper.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.logoutRequest == AuthRequest.success) {
          await PrefsHelper.instance.setBool(AppConstant.loginKey, false);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (_) => false,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  //   App bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        textAlign: TextAlign.center,
                        style: context.headlineLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SvgPicture.asset(SvgsName.settings, width: 25.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CircleAvatar(
                    maxRadius: 60.r,
                    backgroundImage: AssetImage("assets/images/profile.PNG"),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    user?.displayName ?? "Guest",
                    style: context.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    user?.email ?? "ex@gm.com",
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray6B72,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.user,
                    onTap: () {},
                    title: "Personal Information",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.users,
                    onTap: () {},
                    title: "Accounts",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.layoutGrid,
                    onTap: () {},
                    title: "Categories",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.moneySquare,
                    onTap: () {},
                    title: "Budget",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.notificationsOutline,
                    onTap: () {},
                    title: "Notifications",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.lock,
                    onTap: () {},
                    title: "Security",
                  ),
                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.question,
                    onTap: () {},
                    title: "Help & Support",
                  ),

                  SizedBox(height: 20.h),
                  profileCard(
                    context: context,
                    imageName: SvgsName.info,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.aboutUs);
                    },
                    title: "About Us",
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(LogOutEvent());
                        },
                        child: Container(
                          width: 150.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.redEF44.withAlpha(80),
                            border: Border.all(color: AppColors.redEF44),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgsName.logout,
                                color: AppColors.redEF44,
                              ),
                              SizedBox(width: 20.w),

                              Text(
                                "Log Out",
                                style: context.titleLarge.copyWith(
                                  color: AppColors.redEF44,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileCard({
    required BuildContext context,
    required void Function()? onTap,
    required String title,
    required String imageName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.dark1118),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(imageName, width: 25.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SvgPicture.asset(SvgsName.chevronRight, width: 25.w),
          ],
        ),
      ),
    );
  }
}
