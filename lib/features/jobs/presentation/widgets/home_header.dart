import 'package:MatchIn/core/functions/show_image.dart';
import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  showImage(image: Assets.imagesTextLogo),
                  const Spacer(),
                  SvgPicture.asset(
                    Assets.iconsNotificationBellNewIcon,
                  ),
                  SizedBox(width: 8.0.w),
                  SvgPicture.asset(
                    Assets.iconsSettingsIcon,
                  ),
                ],
              ),
              SizedBox(height: 24.0.w),
              Text(
                'Hello, Name 👋',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge,
              ),
              SizedBox(height: 4.0.w),
              Text(
                'Ready to find your next opportunity?',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
