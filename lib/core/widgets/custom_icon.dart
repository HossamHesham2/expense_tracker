import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String svgsName;
  final String label;

  final Color containerColor;
  final Color? iconColor;
  final void Function()? onTap;

  final double iconSize;

  const CustomIcon({
    super.key,
    required this.svgsName,
    required this.label,
    required this.containerColor,
    this.iconColor,
    this.onTap,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SvgPicture.asset(
              svgsName,
              alignment: AlignmentGeometry.center,
              width: iconSize,
              color: iconColor ?? AppColors.whiteFFFF,
            ),
          ),
          SizedBox(height: 5.h),

          Text(
            label,
            style: context.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.gray6B72,
            ),
          ),
        ],
      ),
    );
  }
}
