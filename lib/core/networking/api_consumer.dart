///* API consumer is an abstract class used to consume the api requests
/// has four methods: get, post, put, delete
/// each method takes a path, query parameters, data, and isFormData
abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  });
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  });
}
