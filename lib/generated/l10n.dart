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

  /// `Turn your CV into opportunities`
  String get turnCvIntoOpportunities {
    return Intl.message(
      'Turn your CV into opportunities',
      name: 'turnCvIntoOpportunities',
      desc: '',
      args: [],
    );
  }

  /// `See why a job fits you, what you’re missing, and what to do next.`
  String get turnCvIntoOpportunitiesDesc {
    return Intl.message(
      'See why a job fits you, what you’re missing, and what to do next.',
      name: 'turnCvIntoOpportunitiesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get an explainable match`
  String get getExplainableMatch {
    return Intl.message(
      'Get an explainable match',
      name: 'getExplainableMatch',
      desc: '',
      args: [],
    );
  }

  /// `Not just a score — strengths, gaps, and clear next actions.`
  String get getExplainableMatchDesc {
    return Intl.message(
      'Not just a score — strengths, gaps, and clear next actions.',
      name: 'getExplainableMatchDesc',
      desc: '',
      args: [],
    );
  }

  /// `Setup your career profile`
  String get setupCareerProfile {
    return Intl.message(
      'Setup your career profile',
      name: 'setupCareerProfile',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about your skills and goals to get better recommendations.`
  String get setupCareerProfileDesc {
    return Intl.message(
      'Tell us about your skills and goals to get better recommendations.',
      name: 'setupCareerProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Upload your CV for instant AI parsing`
  String get onboardingBullet1 {
    return Intl.message(
      'Upload your CV for instant AI parsing',
      name: 'onboardingBullet1',
      desc: '',
      args: [],
    );
  }

  /// `Select target roles and skills`
  String get onboardingBullet2 {
    return Intl.message(
      'Select target roles and skills',
      name: 'onboardingBullet2',
      desc: '',
      args: [],
    );
  }

  /// `Get matched with high-fit opportunities`
  String get onboardingBullet3 {
    return Intl.message(
      'Get matched with high-fit opportunities',
      name: 'onboardingBullet3',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Not now`
  String get notNow {
    return Intl.message('Not now', name: 'notNow', desc: '', args: []);
  }

  /// `Enter verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `We sent a 6-digit code to your email.`
  String get sentCodeToEmail {
    return Intl.message(
      'We sent a 6-digit code to your email.',
      name: 'sentCodeToEmail',
      desc: '',
      args: [],
    );
  }

  /// `VERIFICATION CODE`
  String get verificationCodeLabel {
    return Intl.message(
      'VERIFICATION CODE',
      name: 'verificationCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Resend code in`
  String get resendCodeIn {
    return Intl.message(
      'Resend code in',
      name: 'resendCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Use a different email`
  String get useDifferentEmail {
    return Intl.message(
      'Use a different email',
      name: 'useDifferentEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code`
  String get invalidVerificationCode {
    return Intl.message(
      'Invalid verification code',
      name: 'invalidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get secondsSuffix {
    return Intl.message('s', name: 'secondsSuffix', desc: '', args: []);
  }

  /// `Create a new password`
  String get createNewPassword {
    return Intl.message(
      'Create a new password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Choose a strong password you haven’t used before.`
  String get chooseStrongPassword {
    return Intl.message(
      'Choose a strong password you haven’t used before.',
      name: 'chooseStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Use at least 8 characters.`
  String get passwordLengthHint {
    return Intl.message(
      'Use at least 8 characters.',
      name: 'passwordLengthHint',
      desc: '',
      args: [],
    );
  }

  /// `Password requirements`
  String get passwordRequirements {
    return Intl.message(
      'Password requirements',
      name: 'passwordRequirements',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get reqMin8Chars {
    return Intl.message(
      'At least 8 characters',
      name: 'reqMin8Chars',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get reqAtLeastOneNumber {
    return Intl.message(
      'At least one number',
      name: 'reqAtLeastOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least one special character`
  String get reqAtLeastOneSpecial {
    return Intl.message(
      'At least one special character',
      name: 'reqAtLeastOneSpecial',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get backToLogin {
    return Intl.message(
      'Back to login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed successfully. You can now log in with your new password.`
  String get passwordChangedSuccessDesc {
    return Intl.message(
      'Your password has been changed successfully. You can now log in with your new password.',
      name: 'passwordChangedSuccessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Hello, {name} 👋`
  String greetingUser(String name) {
    return Intl.message(
      'Hello, $name 👋',
      name: 'greetingUser',
      desc: 'Greeting message displayed on the home screen',
      args: [name],
    );
  }

  /// `Ready to find your next opportunity?`
  String get readyToFindYourNextOpportunity {
    return Intl.message(
      'Ready to find your next opportunity?',
      name: 'readyToFindYourNextOpportunity',
      desc: '',
      args: [],
    );
  }

  /// `Search jobs, companies, or skills`
  String get searchJobs {
    return Intl.message(
      'Search jobs, companies, or skills',
      name: 'searchJobs',
      desc: '',
      args: [],
    );
  }

  /// `We found jobs that match your profile`
  String get jobsMatchYourProfile {
    return Intl.message(
      'We found jobs that match your profile',
      name: 'jobsMatchYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Explore opportunities based on your skills and career preferences.`
  String get jobsMatchDescription {
    return Intl.message(
      'Explore opportunities based on your skills and career preferences.',
      name: 'jobsMatchDescription',
      desc: '',
      args: [],
    );
  }

  /// `View Matches`
  String get viewMatches {
    return Intl.message(
      'View Matches',
      name: 'viewMatches',
      desc: '',
      args: [],
    );
  }

  /// `Recommended for you`
  String get recommendedForYou {
    return Intl.message(
      'Recommended for you',
      name: 'recommendedForYou',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `Apply Now`
  String get applyNow {
    return Intl.message('Apply Now', name: 'applyNow', desc: '', args: []);
  }

  /// `No jobs found`
  String get noJobsFound {
    return Intl.message(
      'No jobs found',
      name: 'noJobsFound',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Strong Match`
  String get strongMatch {
    return Intl.message(
      'Strong Match',
      name: 'strongMatch',
      desc: '',
      args: [],
    );
  }

  /// `Good Match`
  String get goodMatch {
    return Intl.message('Good Match', name: 'goodMatch', desc: '', args: []);
  }

  /// `matches`
  String get matches {
    return Intl.message('matches', name: 'matches', desc: '', args: []);
  }

  /// `Match`
  String get match {
    return Intl.message('Match', name: 'match', desc: '', args: []);
  }

  /// `Search Jobs`
  String get searchJobsTitle {
    return Intl.message(
      'Search Jobs',
      name: 'searchJobsTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Internship`
  String get internship {
    return Intl.message('Internship', name: 'internship', desc: '', args: []);
  }

  /// `Full-time`
  String get fullTime {
    return Intl.message('Full-time', name: 'fullTime', desc: '', args: []);
  }

  /// `Entry Level`
  String get entryLevel {
    return Intl.message('Entry Level', name: 'entryLevel', desc: '', args: []);
  }

  /// `opportunities`
  String get opportunities {
    return Intl.message(
      'opportunities',
      name: 'opportunities',
      desc: '',
      args: [],
    );
  }

  /// `Most relevant`
  String get mostRelevant {
    return Intl.message(
      'Most relevant',
      name: 'mostRelevant',
      desc: '',
      args: [],
    );
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
