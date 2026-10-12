import 'package:MatchIn/core/widgets/error/app_error.dart';
import 'package:MatchIn/features/profile/domain/entities/candidate_profile_entity.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/edit_profile_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/edit_profile_state.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/edit_profile_patch_mapper.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/edit_profile_actions.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/personal_information_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/professional_information_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/professional_links_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/profile_location_card.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_profile_widgets/profile_photo_editor.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) =>
          current is EditProfileActionFailure || current is EditProfileSuccess,
      listener: (context, state) {
        final locale = S.of(context);
        final messenger = ScaffoldMessenger.of(context);
        switch (state) {
          case EditProfileActionFailure():
            final message = state.message.trim().isEmpty
                ? locale.somethingWentWrong
                : state.message;
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          case EditProfileSuccess():
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(locale.profileSynced)));
            Navigator.of(context).pop(true);
          default:
            break;
        }
      },
      // The form stays mounted for Ready/Saving/ActionFailure/Success:
      // the builder always returns the same _EditProfileForm widget type,
      // so its State (and all controllers) is preserved across transitions.
      // Only initial-load states replace the form with loading/error UI.
      builder: (context, state) {
        switch (state) {
          case EditProfileInitial():
          case EditProfileLoading():
            return const Center(child: CircularProgressIndicator());
          case EditProfileLoadFailure():
            return AppErrorWidget(
              message: state.message,
              onRetry: () => context.read<EditProfileCubit>().loadProfile(),
            );
          case EditProfileReady():
            return _EditProfileForm(
              initialProfile: state.profile,
              isSaving: false,
            );
          case EditProfileSaving():
            return _EditProfileForm(
              initialProfile: state.profile,
              isSaving: true,
            );
          case EditProfileActionFailure():
            final baseline = state.profile;
            if (baseline == null) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<EditProfileCubit>().loadProfile(),
              );
            }
            return _EditProfileForm(initialProfile: baseline, isSaving: false);
          case EditProfileSuccess():
            return _EditProfileForm(
              initialProfile: state.profile,
              isSaving: false,
            );
        }
      },
    );
  }
}

class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm({required this.initialProfile, this.isSaving = false});

  final CandidateProfileEntity initialProfile;
  final bool isSaving;

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _dateOfBirthController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _githubController;
  late final TextEditingController _linkedinController;

  late final ValueNotifier<String?> _gender;
  late final ValueNotifier<String?> _countryCode;
  late final ValueNotifier<String?> _militaryStatus;
  late final ValueNotifier<String?> _country;
  late final ValueNotifier<String?> _state;
  late final ValueNotifier<String?> _city;

  @override
  void initState() {
    super.initState();

    final user = widget.initialProfile.user;
    final details = widget.initialProfile.profile;

    _fullNameController = TextEditingController(text: user.name);

    _dateOfBirthController = TextEditingController(
      text: details?.dateOfBirth ?? '',
    );

    _phoneController = TextEditingController(text: user.phone ?? '');

    _jobTitleController = TextEditingController(text: details?.jobTitle ?? '');

    _githubController = TextEditingController(text: details?.githubUrl ?? '');

    _linkedinController = TextEditingController(
      text: details?.linkedinUrl ?? '',
    );

    _gender = ValueNotifier<String?>(details?.gender);

    _countryCode = ValueNotifier<String?>(null);

    _militaryStatus = ValueNotifier<String?>(details?.militaryStatus);

    _country = ValueNotifier<String?>(details?.country);

    _state = ValueNotifier<String?>(details?.state);

    _city = ValueNotifier<String?>(details?.city);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();

    _gender.dispose();
    _countryCode.dispose();
    _militaryStatus.dispose();
    _country.dispose();
    _state.dispose();
    _city.dispose();

    super.dispose();
  }

  void _handleSave() {
    if (widget.isSaving) return;

    final params = EditProfilePatchMapper.fromDiff(
      baseline: widget.initialProfile,
      dateOfBirth: _dateOfBirthController.text,
      gender: _gender.value,
      jobTitle: _jobTitleController.text,
      country: _country.value,
      state: _state.value,
      city: _city.value,
      githubUrl: _githubController.text,
      linkedinUrl: _linkedinController.text,
      militaryStatus: _militaryStatus.value,
    );

    // No supported field changed: skip the PATCH and return
    // a negative result so Main Profile does not refresh.
    if (!params.hasChanges) {
      Navigator.of(context).pop(false);
      return;
    }

    context.read<EditProfileCubit>().updateProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    final theme = Theme.of(context);

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
      children: [
        // Header
        Row(
          children: [
            IconButton(
              onPressed: widget.isSaving
                  ? null
                  : () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                locale.editProfile,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        if (widget.isSaving) ...[
          SizedBox(height: 12.h),
          const LinearProgressIndicator(),
        ],

        SizedBox(height: 24.h),

        // Profile picture (display-only: no supported update endpoint).
        ProfilePhotoEditor(avatarUrl: widget.initialProfile.user.avatar),

        SizedBox(height: 24.h),

        // Personal Information
        ValueListenableBuilder<String?>(
          valueListenable: _gender,
          builder: (context, gender, child) {
            return ValueListenableBuilder<String?>(
              valueListenable: _countryCode,
              builder: (context, countryCode, child) {
                return PersonalInformationCard(
                  fullNameController: _fullNameController,
                  dateOfBirthController: _dateOfBirthController,
                  phoneController: _phoneController,
                  gender: gender,
                  countryCode: countryCode,

                  // Country calling codes require a verified data source.
                  countryCodes: const {},

                  onGenderChanged: (value) {
                    _gender.value = value;
                  },
                  onCountryCodeChanged: (value) {
                    _countryCode.value = value;
                  },
                );
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        // Professional Information
        ValueListenableBuilder<String?>(
          valueListenable: _militaryStatus,
          builder: (context, militaryStatus, child) {
            return ProfessionalInformationCard(
              jobTitleController: _jobTitleController,
              militaryStatus: militaryStatus,

              // Backend enum values are not confirmed yet.
              militaryStatusItems: const {},

              onMilitaryStatusChanged: (value) {
                _militaryStatus.value = value;
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        // Location
        ValueListenableBuilder<String?>(
          valueListenable: _country,
          builder: (context, country, child) {
            return ValueListenableBuilder<String?>(
              valueListenable: _state,
              builder: (context, state, child) {
                return ValueListenableBuilder<String?>(
                  valueListenable: _city,
                  builder: (context, city, child) {
                    return ProfileLocationCard(
                      country: country,
                      state: state,
                      city: city,

                      // Location options will come from
                      // a verified location data source.
                      countries: const {},
                      states: const {},
                      cities: const {},

                      onCountryChanged: (value) {
                        _country.value = value;
                        _state.value = null;
                        _city.value = null;
                      },
                      onStateChanged: (value) {
                        _state.value = value;
                        _city.value = null;
                      },
                      onCityChanged: (value) {
                        _city.value = value;
                      },
                    );
                  },
                );
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        // Professional Links
        ProfessionalLinksCard(
          githubController: _githubController,
          linkedinController: _linkedinController,
        ),

        SizedBox(height: 28.h),

        // Actions
        EditProfileActions(
          isSaving: widget.isSaving,
          onSave: _handleSave,
          onCancel: () => Navigator.of(context).pop(),
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}
