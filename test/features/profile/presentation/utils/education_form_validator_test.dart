import 'package:MatchIn/features/profile/presentation/utils/education_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EducationFormValidator.formatDate', () {
    test('formats as YYYY-MM-DD with zero padding', () {
      expect(
        EducationFormValidator.formatDate(DateTime(2018, 9, 1)),
        '2018-09-01',
      );
      expect(
        EducationFormValidator.formatDate(DateTime(2023, 12, 31)),
        '2023-12-31',
      );
    });
  });

  group('EducationFormValidator.parseDate', () {
    test('parses YYYY-MM-DD strings', () {
      expect(
        EducationFormValidator.parseDate('2018-09-01'),
        DateTime(2018, 9, 1),
      );
    });

    test('returns null for null, empty, or invalid input', () {
      expect(EducationFormValidator.parseDate(null), isNull);
      expect(EducationFormValidator.parseDate('  '), isNull);
      expect(EducationFormValidator.parseDate('not-a-date'), isNull);
    });
  });

  group('EducationFormValidator.validateInstitution', () {
    test('returns message when blank', () {
      expect(
        EducationFormValidator.validateInstitution(
          '   ',
          requiredMessage: 'Required',
        ),
        'Required',
      );
    });

    test('returns null when provided', () {
      expect(
        EducationFormValidator.validateInstitution(
          'Ain Shams University',
          requiredMessage: 'Required',
        ),
        isNull,
      );
    });
  });

  group('EducationFormValidator.validateDateRange', () {
    test('returns null when either date is missing', () {
      expect(
        EducationFormValidator.validateDateRange(
          start: null,
          end: DateTime(2023, 7, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
      expect(
        EducationFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: null,
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
    });

    test('returns null when end is on or after start', () {
      expect(
        EducationFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: DateTime(2023, 7, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
      expect(
        EducationFormValidator.validateDateRange(
          start: DateTime(2018, 9, 1),
          end: DateTime(2018, 9, 1),
          invalidMessage: 'Invalid',
        ),
        isNull,
      );
    });

    test('returns message when end is before start', () {
      expect(
        EducationFormValidator.validateDateRange(
          start: DateTime(2023, 7, 1),
          end: DateTime(2018, 9, 1),
          invalidMessage: 'Invalid',
        ),
        'Invalid',
      );
    });
  });
}
