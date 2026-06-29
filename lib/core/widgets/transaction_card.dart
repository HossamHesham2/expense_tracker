import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String? title;
  final String? category;
  final double? amount;
  final DateTime? date;
  final TransactionType? type;
  final String? svgIcon;
  final void Function()? onTap;

  const TransactionCard({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
    required this.svgIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = type == TransactionType.expense;
    final amountColor = isExpense ? AppColors.redEF44 : AppColors.green16A3;
    final iconBgColor = isExpense
        ? const Color(0xFFFDECEA)
        : const Color(0xFFE8F5E9);
    final iconColor = isExpense ? AppColors.redEF44 : AppColors.green16A3;
    final amountText =
        '${isExpense ? '-' : '+'}\$${amount!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';
    final formattedDate = DateFormat('dd MMM yyyy').format(date!);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.whiteFFFF,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: isExpense
                    ? SvgPicture.asset(
                        svgIcon ?? "",
                        width: 24.w,
                        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      )
                    : Icon(
                        Icons.arrow_upward_rounded,
                        color: iconColor,
                        size: 24.sp,
                      ),
              ),
            ),
            SizedBox(width: 12.w),

            // Title + Category
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark1118,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    category ?? "",
                    style: context.bodySmall.copyWith(color: AppColors.gray6B72),
                  ),
                ],
              ),
            ),

            // Amount + Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amountText,
                  style: context.bodyMedium.copyWith(
                    color: amountColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  formattedDate,
                  style: context.bodySmall.copyWith(color: AppColors.gray6B72),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
