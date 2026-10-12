import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/profile_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileFormValidator.formatDate', () {
    test('formats as YYYY-MM-DD with zero padding', () {
      expect(
        ProfileFormValidator.formatDate(DateTime(2018, 9, 1)),
        '2018-09-01',
      );
      expect(
        ProfileFormValidator.formatDate(DateTime(2023, 12, 31)),
        '2023-12-31',
      );
    });
  });

  group('ProfileFormValidator.parseDate', () {
    test('parses YYYY-MM-DD strings', () {
      expect(
        ProfileFormValidator.parseDate('2018-09-01'),
        DateTime(2018, 9, 1),
      );
    });

    test('returns null for null, empty, or invalid input', () {
      expect(ProfileFormValidator.parseDate(null), isNull);
      expect(ProfileFormValidator.parseDate('  '), isNull);
      expect(ProfileFormValidator.parseDate('not-a-date'), isNull);
    });
  });

  group('ProfileFormValidator.validateInstitution', () {
    test('returns message when blank', () {
      expect(
        ProfileFormValidator.validateInstitution(
          '   ',
          requiredMessage: 'Required',
        ),
        'Required',
      );
    });

    test('returns null when provided', () {
      expect(
        ProfileFormValidator.validateInstitution(
          'Ain Shams University',
          requiredMessage: 'Required',
        ),
        isNull,
      );
    });
  });

  group('ProfileFormValidator.validateDateRange', () {
    test('returns null when either date is missing', () {
      expect(
        ProfileFormValidator.validateDateRange(
          start: null,
          end: DateTime(2023, 7, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
      expect(
        ProfileFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: null,
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
    });

    test('returns null when end is on or after start', () {
      expect(
        ProfileFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: DateTime(2023, 7, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
      expect(
        ProfileFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: DateTime(2018, 9, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
    });

    test('returns message when end is before start', () {
      expect(
        ProfileFormValidator.validateDateRange(
          start: DateTime(2023, 7, 1),
          end: DateTime(2018, 9, 1),
          invalidMessage: 'Invalid',
        ),
        'Invalid',
      );
    });
  });
}
