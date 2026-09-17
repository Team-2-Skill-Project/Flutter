// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again`
  String get pleaseCheckYourInternetConnection {
    return Intl.message(
      'Please check your internet connection and try again',
      name: 'pleaseCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message('Create Account', name: 'createAccount', desc: '', args: []);
  }

  /// `Smart Career Discovery Platform`
  String get smartCareerDiscoveryPlatform {
    return Intl.message(
      'Smart Career Discovery Platform',
      name: 'smartCareerDiscoveryPlatform',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `example@email.com`
  String get emailHint {
    return Intl.message('example@email.com', name: 'emailHint', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message('Phone Number', name: 'phoneNumber', desc: '', args: []);
  }

  /// `01xxxxxxxxx`
  String get phoneHint {
    return Intl.message('01xxxxxxxxx', name: 'phoneHint', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `8 characters or more`
  String get passwordHint {
    return Intl.message('8 characters or more', name: 'passwordHint', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message('Confirm Password', name: 'confirmPassword', desc: '', args: []);
  }

  /// `Re-enter your password`
  String get confirmPasswordHint {
    return Intl.message('Re-enter your password', name: 'confirmPasswordHint', desc: '', args: []);
  }

  /// `I agree to the Terms and Conditions and Privacy Policy`
  String get termsAndConditions {
    return Intl.message(
      'I agree to the Terms and Conditions and Privacy Policy',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Complete Registration`
  String get completeRegistration {
    return Intl.message('Complete Registration', name: 'completeRegistration', desc: '', args: []);
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Continue with Google`
  String get registerWithGoogle {
    return Intl.message('Continue with Google', name: 'registerWithGoogle', desc: '', args: []);
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message('Already have an account? ', name: 'alreadyHaveAccount', desc: '', args: []);
  }

  /// `Log in`
  String get login {
    return Intl.message('Log in', name: 'login', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message('Welcome back', name: 'welcomeBack', desc: '', args: []);
  }

  /// `Keep me signed in`
  String get keepMeSignedIn {
    return Intl.message('Keep me signed in', name: 'keepMeSignedIn', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message('Forgot password?', name: 'forgotPassword', desc: '', args: []);
  }

  /// `New here? `
  String get newHere {
    return Intl.message('New here? ', name: 'newHere', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
