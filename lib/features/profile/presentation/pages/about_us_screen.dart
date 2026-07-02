import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static final Uri linkedInUrl = Uri.parse(
    'https://www.linkedin.com/in/hossam-hesham-b5283b254',
  );

  static final Uri twitterUrl = Uri.parse('https://x.com/hossamhesham119?s=11');

  static final Uri instagramUrl = Uri.parse(
    'https://www.instagram.com/hossam_hesham_0_0?utm_source=qr',
  );

  static final Uri facebookUrl = Uri.parse(
    'https://www.facebook.com/share/1DwDP2fy1d/?mibextid=wwXIfr',
  );

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('About Us', style: context.titleMedium),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h, width: double.infinity),
          CircleAvatar(
            maxRadius: 50.r,
            backgroundColor: Colors.transparent,
            child: Image.asset("assets/images/logo.png"),
          ),
          SizedBox(height: 16.h),
          Text('Expense Tracker', style: context.titleLarge),
          SizedBox(height: 8.h),
          Text(
            'Version 1.0.0',
            style: context.bodyMedium.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              "Expense Tracker is a simple and intuitive application designed to help users manage their personal finances efficiently. Track your income, monitor your expenses, and gain valuable insights into your spending habits through clear analytics and reports",
              textAlign: TextAlign.center,
              style: context.bodyLarge,
            ),
          ),
          const Spacer(),
          Text('Connect with us', style: context.titleSmall),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _launchUrl(linkedInUrl),
                icon: SvgPicture.asset(
                  SvgsName.linkedin,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF0A66C2),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _launchUrl(twitterUrl),
                icon: SvgPicture.asset(
                  SvgsName.twitter,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF1DA1F2),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _launchUrl(instagramUrl),
                icon: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFFFEDA75),
                        Color(0xFFFA7E1E),
                        Color(0xFFD62976),
                        Color(0xFF962FBF),
                        Color(0xFF4F5BD5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: SvgPicture.asset(SvgsName.instagram, width: 24.w),
                ),
              ),
              IconButton(
                onPressed: () => _launchUrl(facebookUrl),
                icon: SvgPicture.asset(
                  SvgsName.facebook,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF1877F2),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '© 2026 Expense Tracker. All rights reserved.',
            style: context.bodySmall.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
