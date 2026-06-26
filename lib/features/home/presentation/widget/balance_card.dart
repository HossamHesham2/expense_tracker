import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expense;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expense,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.green16A3,
            AppColors.emerald10B9,
            AppColors.green16A3,
            AppColors.emerald10B9,

          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Balance',
                style: TextStyle(
                  color: AppColors.whiteFFFF.withOpacity(0.85),
                  fontSize: 14.sp,
                ),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: SvgPicture.asset(
                  isVisible ? SvgsName.eyeClosed : SvgsName.eye,
                  color: AppColors.whiteFFFF,
                  width: 24.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            isVisible ? '${_format(balance)} EG' : '••••••',
            style: context.displayLarge.copyWith(
              color: AppColors.whiteFFFF,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: 18.h),
          Divider(color: AppColors.whiteFFFF.withOpacity(0.25), thickness: 1),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(
                label: 'Income',
                amount: '${_format(income)} EG',
                labelColor: AppColors.whiteFFFF.withOpacity(0.8),
                amountColor: AppColors.whiteFFFF,
                isVisible: isVisible,
              ),
              _StatItem(
                label: 'Expense',
                amount: '${_format(expense)} EG',
                labelColor: AppColors.orangeF59E,
                amountColor: AppColors.orangeF59E,
                isVisible: isVisible,
                align: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _format(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String amount;
  final Color labelColor;
  final Color amountColor;
  final bool isVisible;
  final CrossAxisAlignment align;

  const _StatItem({
    required this.label,
    required this.amount,
    required this.labelColor,
    required this.amountColor,
    required this.isVisible,
    this.align = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(label, style: context.bodySmall.copyWith(color: labelColor)),
        SizedBox(height: 4.h),
        Text(
          isVisible ? amount : '•••••',
          style: context.titleLarge.copyWith(
            color: amountColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
