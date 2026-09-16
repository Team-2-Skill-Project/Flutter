import 'package:MatchIn/core/functions/show_image.dart';
import 'package:MatchIn/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:MatchIn/core/routing/app_routes.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:go_router/go_router.dart';

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
                  InkWell(
                    onTap: () {
                      context.push(AppRoutes.notifications);
                    },
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: SvgPicture.asset(
                        Assets.iconsNotificationBellNewIcon,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0.w),
                  InkWell(
                    onTap: () {
                      context.push(AppRoutes.settings);
                    },
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: SvgPicture.asset(
                        Assets.iconsSettingsIcon,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0.w),
              Text(
                S.of(context).greetingUser('Name'),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge,
              ),
              SizedBox(height: 4.0.w),
              Text(
                S
                    .of(context)
                    .readyToFindYourNextOpportunity,
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
