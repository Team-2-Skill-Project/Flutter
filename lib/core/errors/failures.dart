// This file is used to create custom failures for the application
// Start with a generic failure class
// Then create specific failure classes for each type of failure
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const new({required this.message});
}

class OfflineFailure extends Failure {
  const new({super.message = 'You are offline'});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const new({super.message = 'There was a problem with the server'});

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  const new({super.message = 'There was a problem with the cache'});

  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  const new({super.message = 'There was a problem with the cache'});

  @override
  List<Object?> get props => [];
}
