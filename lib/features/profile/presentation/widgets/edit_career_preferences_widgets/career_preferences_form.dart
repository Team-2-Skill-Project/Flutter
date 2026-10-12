import 'package:MatchIn/features/profile/domain/entities/career_preference_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/save_career_preferences_params.dart';
import 'package:MatchIn/features/profile/presentation/cubits/career_cubit/career_preferences_cubit.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/career_goal_section.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/career_preferences_actions.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/experience_level_section.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/job_type_section.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/preferred_location_section.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/target_role_section.dart';
import 'package:MatchIn/features/profile/presentation/widgets/edit_career_preferences_widgets/work_mode_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CareerPreferencesForm extends StatefulWidget {
  const CareerPreferencesForm({
    required this.preferences,
    this.isSaving = false,
    super.key,
  });

  final CareerPreferenceEntity? preferences;
  final bool isSaving;

  @override
  State<CareerPreferencesForm> createState() => _CareerPreferencesFormState();
}

class _CareerPreferencesFormState extends State<CareerPreferencesForm> {
  late final TextEditingController _targetRoleController;
  late final TextEditingController _careerGoalController;

  late final ValueNotifier<String?> _experienceLevel;
  late final ValueNotifier<String?> _jobType;
  late final ValueNotifier<String?> _workMode;

  late final ValueNotifier<String> _country;
  late final ValueNotifier<String> _state;
  late final ValueNotifier<String> _city;

  late final ValueNotifier<bool> _openToRelocation;

  @override
  void initState() {
    super.initState();

    final preferences = widget.preferences;

    _targetRoleController = TextEditingController(
      text: preferences?.targetRole ?? '',
    );

    _careerGoalController = TextEditingController(
      text: preferences?.careerGoal ?? '',
    );

    _experienceLevel = ValueNotifier(preferences?.experienceLevel);

    _jobType = ValueNotifier(preferences?.jobType);

    _workMode = ValueNotifier(preferences?.workMode);

    _country = ValueNotifier(preferences?.preferredCountry ?? '');

    _state = ValueNotifier('');

    _city = ValueNotifier(preferences?.preferredCity ?? '');

    _openToRelocation = ValueNotifier(preferences?.openToRelocation ?? false);
  }

  @override
  void dispose() {
    _targetRoleController.dispose();
    _careerGoalController.dispose();

    _experienceLevel.dispose();
    _jobType.dispose();
    _workMode.dispose();

    _country.dispose();
    _state.dispose();
    _city.dispose();

    _openToRelocation.dispose();

    super.dispose();
  }

  void _save() {
    if (widget.isSaving) return;
    final baseline = widget.preferences;

    var params = const SaveCareerPreferencesParams();

    final targetRole = _nullableText(_targetRoleController.text);
    if (targetRole != baseline?.targetRole) {
      params = params.copyWith(targetRole: targetRole);
    }

    if (_jobType.value != baseline?.jobType) {
      params = params.copyWith(jobType: _jobType.value);
    }

    if (_workMode.value != baseline?.workMode) {
      params = params.copyWith(workMode: _workMode.value);
    }

    final country = _nullableText(_country.value);
    if (country != baseline?.preferredCountry) {
      params = params.copyWith(preferredCountry: country);
    }

    final city = _nullableText(_city.value);
    if (city != baseline?.preferredCity) {
      params = params.copyWith(preferredCity: city);
    }

    if (_experienceLevel.value != baseline?.experienceLevel) {
      params = params.copyWith(experienceLevel: _experienceLevel.value);
    }

    final careerGoal = _nullableText(_careerGoalController.text);
    if (careerGoal != baseline?.careerGoal) {
      params = params.copyWith(careerGoal: careerGoal);
    }

    if (_openToRelocation.value != (baseline?.openToRelocation ?? false)) {
      params = params.copyWith(openToRelocation: _openToRelocation.value);
    }

    // No PATCH when nothing changed: avoids an empty request body
    // and keeps the form exactly as the user left it.
    if (!params.hasChanges) return;

    context.read<CareerPreferencesCubit>().saveCareerPreferences(params);
  }

  String? _nullableText(String value) {
    final trimmed = value.trim();

    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TargetRoleSection(
          controller: _targetRoleController,

          // No roles suggestion endpoint confirmed yet.
          suggestedRoles: const [],
          selectedSuggestedRole: null,

          onRoleChanged: (_) {},
          onClear: _targetRoleController.clear,
          onSuggestedRolePressed: (role) {
            _targetRoleController.text = role;
          },
        ),

        SizedBox(height: 16.h),

        ValueListenableBuilder<String?>(
          valueListenable: _experienceLevel,
          builder: (context, value, _) {
            return ExperienceLevelSection(
              selectedLevel: value,
              onSelected: (level) {
                _experienceLevel.value = level;
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        ValueListenableBuilder<String?>(
          valueListenable: _jobType,
          builder: (context, value, _) {
            return JobTypeSection(
              selectedType: value,
              onSelected: (type) {
                _jobType.value = type;
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        ValueListenableBuilder<String?>(
          valueListenable: _workMode,
          builder: (context, value, _) {
            return WorkModeSection(
              selectedMode: value,
              onSelected: (mode) {
                _workMode.value = mode;
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        ListenableBuilder(
          listenable: Listenable.merge([
            _country,
            _state,
            _city,
            _openToRelocation,
          ]),
          builder: (context, _) {
            return PreferredLocationSection(
              country: _country.value,
              state: _state.value,
              city: _city.value,
              openToRelocation: _openToRelocation.value,

              // TODO(career-preferences): Before production, connect
              // these fields to the confirmed backend contract and data
              // source, then enable interaction. Location pickers stay
              // disabled so no unpersisted values can be entered.
              onCountryPressed: null,
              onStatePressed: null,
              onCityPressed: null,

              onOpenToRelocationChanged: (value) {
                if (value == null) return;

                _openToRelocation.value = value;
              },
            );
          },
        ),

        SizedBox(height: 16.h),

        CareerGoalSection(controller: _careerGoalController),

        SizedBox(height: 28.h),

        CareerPreferencesActions(
          isSaving: widget.isSaving,
          onSavePressed: _save,
          onCancelPressed: () =>
              Navigator.of(context)
                  .pop(context.read<CareerPreferencesCubit>().hasChanges),
        ),
      ],
    );
  }
}
