import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // final String baseUrl = "https://console.enovavpn.com/api/v2/";
  final String baseUrl = "https://mm.getenova.com/api/v2/";
  // final String baseUrl = "https://api.getenova.com/api/v2/";

  final http.Client client;
  final int timeoutSeconds;
  final _cache = <String, dynamic>{};

  ApiService({required this.client, this.timeoutSeconds = 10});


  Future<T> get<T>(
      String endpoint,
      T Function(dynamic) fromJson, {
        bool authToken = false,
        Map<String, String>? queryParams, // Add queryParams parameter
      }) async {
    print("TokenGotdbajdb ${authToken.toString()}");
    final headers = await _buildHeaders(authToken);

    const r = RetryOptions(maxAttempts: 2);

    // Build the full URI with query parameters
    final uri =
    Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

    try {
      final response = await r.retry(
            () => client
            .get(uri, headers: headers)
            .timeout(Duration(seconds: timeoutSeconds)),
        retryIf: (e) => e is http.ClientException || e is TimeoutException,
      );
      logRequest('GET', uri.toString(), headers: headers);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        // FirebaseAnalyticsUtil.logEvent(
        //     eventName: "endPoint_server_error",
        //     message: {
        //       "endpoint": "$endpoint",
        //       "status_code": response.statusCode.toString(),
        //       "response_body": responseBody["message"] ??
        //           "message is not available right now",
        //     });
      }

      return _handleResponse(response, fromJson);
    } catch (e) {
      print("catch error");
      // if (printLogs) {
      //   Get.snackbar("PostError", e.toString(),
      //       duration: const Duration(seconds: 10));
      // }
      print(e);

      // This will navigate back to the previous page
      // Get.back();

      throw _handleError(e);
    }
  }

  Future<T> post<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson,
      {bool authToken = false}) async {
    final headers = await _buildHeaders(authToken);

    const r = RetryOptions(maxAttempts: 2);

    try {
      final response = await r.retry(
            () => client
            .post(Uri.parse('$baseUrl$endpoint'),
            headers: headers, body: jsonEncode(body))
            .timeout(Duration(seconds: timeoutSeconds)),
        retryIf: (e) => e is http.ClientException || e is TimeoutException,
      );
      logRequest('POST', '$baseUrl$endpoint', headers: headers, body: body);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        // FirebaseAnalyticsUtil.logEvent(
        //     eventName: "endPoint_server_error",
        //     message: {
        //       "endpoint": "$endpoint",
        //       "status_code": response.statusCode.toString(),
        //       "response_body": responseBody["message"] ??
        //           "message is not available right now",
        //     });
      }

      return _handleResponse(response, fromJson);
    } catch (e) {
      // if (printLogs) {
      //   Get.snackbar("GetError", e.toString(),
      //       duration: const Duration(seconds: 10));
      // }
      print(e);

      // This will navigate back to the previous page
      // Get.back();

      throw _handleError(e);
    }
  }

  static Future<String> getPrefStr(String key) async {
    // i have token name token in shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> setPrefStr(String key, dynamic value) async {
    print("hitting set string");
    // i have token name token in shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return true;
  }

  Future<Map<String, String>> _buildHeaders(bool authToken) async {
    final headers = {
      'Content-Type': 'application/json',
      'Lang': "en",
      'Os': "android",
      'Device-Id': "11223344",
      'Version': ""
    };
    if (authToken) {
      final token = await _getAuthToken();
      headers['Authorization'] = 'Bearer $token';
    }
    print("printmyheader $headers");
    return headers;
  }

  Future<String> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return '136996|5ImAwooH53BLgG1gHCXTcVrBXEnefqwoWywd8avq5e307991';
  }

  // U S E    A U T H    S E T___A C C E S S T O K E N
  // Future<void> _setAuthToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('ACCESS_TOKEN', token);
  // }

  T _handleResponse<T>(http.Response response, T Function(dynamic) fromJson) {
    logResponse(response);
    final decodedBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
      // return fromJson(decodedBody);
      case 400:
      // return fromJson(decodedBody);
      // throw ApiException('Bad request: ${response.body}');
      case 401:
      case 403:
      case 404:
        return fromJson(jsonDecode(response.body));
    // throw UnauthorizedException('Unauthorized: ${response.body}');
      case 500:
      default:
      // return fromJson(decodedBody);
      // if (decodedBody is Map<String, dynamic>) {
      //   return fromJson(decodedBody);
      // } else {
      //   Get.back();
        print("default");
        throw ApiException('Unexpected error: ${response.body}');
    // }
    }
  }

  Exception _handleError(dynamic error) {
    if (error is http.ClientException) {
      return NetworkException('Network error: ${error.message}');
    } else if (error is TimeoutException) {
      return TimeoutException('Request timeout');
    } else {
      return ApiException('Unexpected error: ${error.toString()}');
    }
  }

  void logRequest(String method, String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) {
    print('Request: $method $url');
    if (headers != null) {
      print('Request Headers: $headers');
    }
    if (body != null) {
      _printLargeString('Body: ${jsonEncode(body)}');
    }
  }

  void logResponse(http.Response response) {
    print('Response: ${response.statusCode}');
    // print('Response: ${response.body}');
    _printLargeString('Response Body: ${response.body}');
  }

  void _printLargeString(String message) {
    const int chunkSize = 800;
    for (int i = 0; i < message.length; i += chunkSize) {
      print(message.substring(
          i, i + chunkSize > message.length ? message.length : i + chunkSize));
    }
  }

  Future<T> put<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson,
      {bool authToken = false}) async {
    final headers = await _buildHeaders(authToken);

    const r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(
            () => client
            .put(Uri.parse('$baseUrl$endpoint'),
            headers: headers, body: jsonEncode(body))
            .timeout(Duration(seconds: timeoutSeconds)),
        retryIf: (e) => e is http.ClientException || e is TimeoutException,
      );
      logRequest('PUT', '$baseUrl$endpoint', headers: headers, body: body);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        // FirebaseAnalyticsUtil.logEvent(
        //     eventName: "endPoint_server_error",
        //     message: {
        //       "endpoint": "$endpoint",
        //       "status_code": response.statusCode.toString(),
        //       "response_body": responseBody["message"] ??
        //           "message is not available right now",
        //     });
      }

      return _handleResponse(response, fromJson);
    } catch (e) {
      // PopUp.showSuccessOrErrorDialog(
      //   context: Get.context!,
      //   image:AppAssets.light.icons.error,
      //   imageHeight: 50,
      //   title: "${LocaleValues.instance.getText(LocaleKey.sorry)}",
      //   subtitle: e.toString(),
      //   isShowButton: false,
      //   onTap: () {},
      //   cancelButton: () {
      //     Get.back();
      //   },
      // );
      throw _handleError(e);
    }
  }

  Future<T> delete<T>(String endpoint, T Function(dynamic) fromJson,
      {bool authToken = false}) async {
    final headers = await _buildHeaders(authToken);

    const r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(
            () => client
            .delete(Uri.parse('$baseUrl$endpoint'), headers: headers)
            .timeout(Duration(seconds: timeoutSeconds)),
        retryIf: (e) => e is http.ClientException || e is TimeoutException,
      );
      logRequest('DELETE', '$baseUrl$endpoint', headers: headers);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        // FirebaseAnalyticsUtil.logEvent(
        //     eventName: "endPoint_server_error",
        //     message: {
        //       "endpoint": "$endpoint",
        //       "status_code": response.statusCode.toString(),
        //       "response_body": responseBody["message"] ??
        //           "message is not available right now",
        //     });
      }

      return _handleResponse(response, fromJson);
    } catch (e) {
      // PopUp.showSuccessOrErrorDialog(
      //   context: Get.context!,
      //   image: AppAssets.light.icons.error,
      //   imageHeight: 50,
      //   title:
      //   "${LocaleValues.instance.getText(LocaleKey.activationUnSuccess)}",
      //   subtitle: e.toString(),
      //   isShowButton: false,
      //   onTap: () {},
      //   cancelButton: () {
      //     Get.back();
      //   },
      // );
      throw _handleError(e);
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class NetworkException extends ApiException {
  NetworkException(String message) : super(message);
}

class TimeoutException extends ApiException {
  TimeoutException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

// import 'package:http/http.dart' as http;
//
// void main() async {
//   final apiService = ApiService(
//     baseUrl: 'https://example.com',
//     client: http.Client(),
//   );
//
//   try {
//     final user = await apiService.get('/users/1', (json) => User.fromJson(json));
//     print('User: $user');
//   } catch (e) {
//     print('Error: $e');
//   }
// }
//
// class User {
//   final int id;
//   final String name;
//   final String email;
//
//   User({required this.id, required this.name, required this.email});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
//
//   @override
//   String toString() => 'User(id: $id, name: $name, email: $email)';
// }
