import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/check_token_response.model.dart';  // Replace with actual path to CheckTokenResponse model
import 'base.controller.dart';
import '../services/api_service.dart';

class CheckTokenController extends BaseController {
  final ApiService apiService;  // Inject ApiService

  // This holds the response
  final Rx<CheckTokenResponse?> checkTokenResponse = Rx<CheckTokenResponse?>(null);

  // Constructor to inject the ApiService
  CheckTokenController({required this.apiService});

  // Method to check the token
  Future<void> checkAuthToken() async {
    await executeWithTimeout(() async {
      final String url = 'client/check-auth-token';

      // Define query parameters
      final Map<String, String> queryParams = {
        'device_id': '12345',
        'os': 'android',
      };

      try {
        // Call ApiService's get method
        await apiService.get(
          url,
              (data) => CheckTokenResponse.fromJson(data), // Map response to CheckTokenResponse
          queryParams: queryParams,
          authToken: true, // Assuming token-based authentication is required
        ).then((response) {
          // Set the response
          checkTokenResponse.value = response;
          status.value = 'Token Check Status: ${checkTokenResponse.value?.message}';
        });
      } catch (e) {
        print("Error occurred while checking auth token: $e");
        status.value = 'Error: $e';
      }
    });
  }
}