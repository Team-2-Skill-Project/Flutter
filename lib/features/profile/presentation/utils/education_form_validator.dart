class EducationFormValidator {
  const EducationFormValidator._();

  /// Formats a picked date as `YYYY-MM-DD` for the backend.
  static String formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  static DateTime? parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value.trim());
  }

  /// Returns [requiredMessage] when [value] is blank, otherwise null.
  static String? validateInstitution(
    String value, {
    required String requiredMessage,
  }) {
    if (value.trim().isEmpty) return requiredMessage;
    return null;
  }

  /// Returns [invalidMessage] when both dates are set and
  /// [end] is before [start], otherwise null.
  static String? validateDateRange({
    DateTime? start,
    DateTime? end,
    required String invalidMessage,
  }) {
    if (start == null || end == null) return null;
    if (end.isBefore(start)) return invalidMessage;
    return null;
  }
}
