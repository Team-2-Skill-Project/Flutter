// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Hello, ${name} 👋";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "applyNow": MessageLookupByLibrary.simpleMessage("Apply Now"),
    "goodMatch": MessageLookupByLibrary.simpleMessage("Good Match"),
    "greetingUser": m0,
    "jobsMatchDescription": MessageLookupByLibrary.simpleMessage(
      "Explore opportunities based on your skills and career preferences.",
    ),
    "jobsMatchYourProfile": MessageLookupByLibrary.simpleMessage(
      "We found jobs that match your profile",
    ),
    "matches": MessageLookupByLibrary.simpleMessage("matches"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noJobsFound": MessageLookupByLibrary.simpleMessage("No jobs found"),
    "pleaseCheckYourInternetConnection": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection and try again",
    ),
    "readyToFindYourNextOpportunity": MessageLookupByLibrary.simpleMessage(
      "Ready to find your next opportunity?",
    ),
    "recommendedForYou": MessageLookupByLibrary.simpleMessage(
      "Recommended for you",
    ),
    "searchJobs": MessageLookupByLibrary.simpleMessage(
      "Search jobs, companies, or skills",
    ),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "strongMatch": MessageLookupByLibrary.simpleMessage("Strong Match"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "viewMatches": MessageLookupByLibrary.simpleMessage("View Matches"),
  };
}
