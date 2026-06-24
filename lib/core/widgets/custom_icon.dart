import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String svgsName;

  final Color containerColor;

  final double iconSize;

  const CustomIcon({
    super.key,
    required this.svgsName,
    required this.containerColor,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SvgPicture.asset(
        svgsName,
        alignment: AlignmentGeometry.center,
        width: iconSize,
        color: AppColors.whiteFFFF,
      ),
    );
  }
}
