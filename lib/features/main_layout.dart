import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/features/analytics/presentation/pages/analytics_screen.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:expense_tracker/features/profile/presentation/pages/profile_screen.dart';
import 'package:expense_tracker/features/transactions/presentation/pages/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      floatingActionButton: _FabButton(onTap: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) return; // FAB — no page switch

          final pageIndex = index > 2 ? index - 1 : index;
          setState(() => _currentIndex = pageIndex);
        },
      ),
    );
  }
}

// ─── Custom Bottom Nav Bar ────────────────────────────────────────────────────

class _CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Map page index → bar slot index (slot 2 is FAB)
    final barIndex = currentIndex >= 2 ? currentIndex + 1 : currentIndex;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteFFFF,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark1118.withAlpha(25),
            blurRadius: 20.r,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isSelected: barIndex == 0,
                onTap: () => onTap(0),
              ),
              // Transactions
              _NavItem(
                icon: Icons.swap_horiz_rounded,
                label: 'Transactions',
                isSelected: barIndex == 1,
                onTap: () => onTap(1),
              ),
              // Centre FAB
  SizedBox(width: 20.w,),
              // Analytics
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: 'Analytics',
                isSelected: barIndex == 3,
                onTap: () => onTap(3),
              ),
              // Profile
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                isSelected: barIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Single nav item ──────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  static const _green = AppColors.green16A3;
  static const _grey = AppColors.gray6B72;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: isSelected ? _green : _grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? _green : _grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Centre FAB ───────────────────────────────────────────────────────────────

class _FabButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FabButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.green16A3, AppColors.green16A3],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.green16A3,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.add, color: AppColors.whiteFFFF, size: 28.sp),
      ),
    );
  }
}
