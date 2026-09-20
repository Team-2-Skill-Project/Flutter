

part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginModel loginModel;
  LoginSuccess({required this.loginModel});
}

class LoginFailure extends AuthState {
  final String message;
  LoginFailure({required this.message});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String message;
  RegisterFailure({required this.message});
}