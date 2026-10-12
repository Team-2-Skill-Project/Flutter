import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/edit_profile_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/edit_profile_field.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/gender_selector.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/profile_phone_field.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInformationCard extends StatelessWidget {
  const PersonalInformationCard({
    required this.fullNameController,
    required this.dateOfBirthController,
    required this.phoneController,
    required this.gender,
    required this.countryCode,
    required this.countryCodes,
    required this.onGenderChanged,
    required this.onCountryCodeChanged,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController dateOfBirthController;
  final TextEditingController phoneController;
  final String? gender;
  final String? countryCode;
  final Map<String, String> countryCodes;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String?> onCountryCodeChanged;

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return EditProfileCard(
      title: locale.personalInformation,
      child: Column(
        children: [
          // User resource field: no supported update endpoint yet.
          // Visible but read-only until the contract is confirmed.
          EditProfileField(
            label: locale.fullName,
            controller: fullNameController,
            readOnly: true,
          ),
          SizedBox(height: 16.h),
          EditProfileField(
            label: locale.dateOfBirth,
            controller: dateOfBirthController,
            readOnly: true,
            onTap: () {},
          ),
          SizedBox(height: 16.h),
          GenderSelector(value: gender, onChanged: onGenderChanged),
          SizedBox(height: 16.h),
          // User resource field: no supported update endpoint yet.
          // Visible but disabled until the contract is confirmed.
          ProfilePhoneField(
            controller: phoneController,
            countryCode: countryCode,
            countryCodes: countryCodes,
            onCountryCodeChanged: onCountryCodeChanged,
            enabled: false,
          ),
        ],
      ),
    );
  }
}
