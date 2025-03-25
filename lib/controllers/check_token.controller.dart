import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/check_token_response.model.dart';  // Replace with actual path to CheckTokenResponse model
import 'base.controller.dart';

class CheckTokenController extends BaseController {
  final Rx<CheckTokenResponse?> checkTokenResponse = Rx<CheckTokenResponse?>(null);

  // Method to check the token
  Future<void> checkAuthToken() async {
    await executeWithTimeout(() async {
      final String url = 'https://mm.getenova.com/api/v2/client/check-auth-token';

      // Define query parameters
      final Map<String, String> queryParams = {
        'device_id': '12345',
        'os': 'android',
      };

      // Prepare headers with the authorization token
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 136951|KmQ2RcKoZ8hXYfRpzjpqGXNo7cZhkmUsBPIjdbgf1b23d6c5',  // Adding the Authorization token in the headers
      };

      try {
        // Make the GET request with query parameters
        final uri = Uri.parse(url).replace(queryParameters: queryParams);
        final response = await http.get(uri, headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          checkTokenResponse.value = CheckTokenResponse.fromJson(data);
          status.value = 'Token Check Status: ${checkTokenResponse.value?.message}';
        } else {
          throw Exception('Failed to fetch data');
        }
      } catch (e) {
        print("Error occurred while checking auth token: $e");
        status.value = 'Error: $e';
      }
    });
  }
}
