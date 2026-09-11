import 'package:MatchIn/core/networking/api_end_points.dart';

class ErrorModel {
  ErrorModel({required this.statusCode, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json[ApiKey.statusCode],
      errorMessage: json[ApiKey.errorMessage],
    );
  }
  int statusCode;
  String errorMessage;
}
