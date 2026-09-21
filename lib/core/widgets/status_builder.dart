import 'package:MatchIn/core/widgets/empty/app_empty.dart';
import 'package:MatchIn/core/widgets/error/app_error.dart';
import 'package:MatchIn/core/widgets/loading/app_loading.dart';
import 'package:flutter/material.dart';

// for switch states cubit in views screen
class StatusBuilder<T> extends StatelessWidget {
  const StatusBuilder({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.errorMessage,
    required this.data,
    required this.onSuccess,
  });

  final bool isLoading;
  final bool isEmpty;
  final String? errorMessage;
  final T? data;
  final Widget Function(T data) onSuccess;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppLoadingWidget();
    if (errorMessage != null) {
      return AppErrorWidget(message: errorMessage!);
    }
    if (isEmpty) return const AppEmptyWidget(message: '');
    return onSuccess(data as T);
  }
}
