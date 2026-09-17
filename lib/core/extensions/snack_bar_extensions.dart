import 'package:flutter/material.dart';
import 'package:MatchIn/core/widgets/custom_snack_bar.dart';

/// Extension on [BuildContext] to show standardized snackbars conveniently.
extension SnackBarExtensions on BuildContext {
  /// Shows a success snackbar.
  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    CustomSnackBar.showSuccess(
      this,
      message: message,
      duration: duration,
      action: action,
    );
  }

  /// Shows an error snackbar.
  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    CustomSnackBar.showError(
      this,
      message: message,
      duration: duration,
      action: action,
    );
  }

  /// Shows an info snackbar.
  void showInfoSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    CustomSnackBar.showInfo(
      this,
      message: message,
      duration: duration,
      action: action,
    );
  }

  /// Shows a warning snackbar.
  void showWarningSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    CustomSnackBar.showWarning(
      this,
      message: message,
      duration: duration,
      action: action,
    );
  }
}
