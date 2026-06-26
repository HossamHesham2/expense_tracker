import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/widgets/custom_icon.dart';
import 'package:expense_tracker/features/home/presentation/widget/balance_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        actions: [
          SvgPicture.asset(SvgsName.notificationsOutline),
          SizedBox(width: 20.w),
        ],
        leadingWidth: 60.w,
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Good morning 👋",
                        style: context.headlineLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray6B72,
                        ),
                      ),
                      subtitle: Text(
                        user?.displayName ?? "Guest",
                        style: context.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.emerald10B9,
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    child: SvgPicture.asset(
                      SvgsName.user,
                      width: 30.w,
                      color: AppColors.whiteFFFF,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20.h),
              BalanceCard(
                balance: 2000,
                income: 122222,
                expense: 20000,
                isVisible: isVisible,
                onToggleVisibility: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "Quick Actions",
                style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcon(
                    svgsName: SvgsName.arrowUp,
                    containerColor: AppColors.green16A3,
                    label: "Income",
                  ),
                  CustomIcon(
                    svgsName: SvgsName.arrowDown,
                    containerColor: AppColors.redEF44,
                    label: "Expense",
                  ),
                  CustomIcon(
                    svgsName: SvgsName.menuOutline,
                    containerColor: AppColors.grayE5E7,
                    iconColor: AppColors.dark1118,
                    label: "View all",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
