import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // 🎨 Main Colors
    scaffoldBackgroundColor: AppColors.whiteFFFF,
    primaryColor: AppColors.green16A3,

    // 🧾 AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteFFFF,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.dark1118),
      titleTextStyle: TextStyle(
        color: AppColors.dark1118,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),

    // 🧩 Card Theme
    cardTheme: CardThemeData(
      color: AppColors.whiteFFFF,
      elevation: 2,
      shadowColor: AppColors.gray6B72,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ✏️ Text Theme
    textTheme: TextTheme(
      // Display (hero text)
      displayLarge: TextStyle(color: AppColors.dark1118, fontSize: 32.sp),
      displayMedium: TextStyle(color: AppColors.dark1118, fontSize: 28.sp),
      displaySmall: TextStyle(color: AppColors.dark1118, fontSize: 24.sp),

      // Headlines
      headlineLarge: TextStyle(color: AppColors.dark1118, fontSize: 22.sp),
      headlineMedium: TextStyle(color: AppColors.dark1118, fontSize: 20.sp),
      headlineSmall: TextStyle(color: AppColors.dark1118, fontSize: 18.sp),

      // Titles
      titleLarge: TextStyle(color: AppColors.dark1118, fontSize: 18.sp),
      titleMedium: TextStyle(color: AppColors.dark1118, fontSize: 16.sp),
      titleSmall: TextStyle(color: AppColors.dark1118, fontSize: 14.sp),

      // Body
      bodyLarge: TextStyle(color: AppColors.dark1118, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.dark1118, fontSize: 14.sp),
      bodySmall: TextStyle(color: AppColors.dark1118, fontSize: 12.sp),

      // Labels (مهمين للأزرار و العناصر الصغيرة)
      labelLarge: TextStyle(color: AppColors.dark1118, fontSize: 14.sp, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: AppColors.dark1118, fontSize: 12.sp, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(color: AppColors.grayE5E7, fontSize: 11.sp),
    ),

    // ✍️ Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteFFFF,

      contentPadding: EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.grayE5E7),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.grayE5E7),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: AppColors.grayE5E7),
      ),
    ),
  );
}
