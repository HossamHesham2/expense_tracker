import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:expense_tracker/features/profile/presentation/pages/profile_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TransactionsScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(onTap: () {
        Navigator.pushNamed(context, RoutesName.addTransaction);
      }),
      bottomNavigationBar: _bottomNavigationBar(index: _currentIndex),
    );
  }

  Widget _floatingActionButton({required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.green16A3,
          borderRadius: BorderRadius.circular(200.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.green16A3,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          SvgsName.add,
          color: AppColors.whiteFFFF,
          width: 30.w,
        ),
      ),
    );
  }

  Widget _bottomNavigationBar({required int index}) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.whiteFFFF,
        boxShadow: [
          BoxShadow(
            color: AppColors.dark1118,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(svgName: SvgsName.homeSimpleDoor, text: "Home", index: 0),
          _navItem(svgName: SvgsName.bill, text: "Transactions", index: 1),
          SizedBox(width: 30.w),
          _navItem(
            svgName: SvgsName.googleAnalytics,
            text: "Analytics",
            index: 2,
          ),
          _navItem(svgName: SvgsName.user, text: "Profile", index: 3),
        ],
      ),
    );
  }

  Widget _navItem({
    required String svgName,
    required String text,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            svgName,
            color: isSelected ? AppColors.green16A3 : AppColors.dark1118,
            width: 25.w,
          ),
          SizedBox(height: 5.h),
          Text(
            text,
            style: context.bodyMedium.copyWith(
              color: isSelected ? AppColors.green16A3 : AppColors.dark1118,
            ),
          ),
        ],
      ),
    );
  }
}
