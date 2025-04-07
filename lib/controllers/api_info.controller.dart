import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/api_info.model.dart';
import '../services/api_service.dart';
import 'base.controller.dart';

class ApiInfoController extends BaseController {
  final ApiService apiService;

  final Rx<ApiInfo?> apiInfo = Rx<ApiInfo?>(null);

  // Constructor to inject the ApiService
  ApiInfoController({required this.apiService});

  // Method to fetch API info
  Future<void> fetchApiInfo() async {
    await executeWithTimeout(() async {
      final String url = 'app-info';  // Use relative URL since it's handled in ApiService

      try {
        // Call ApiService's get method
        await apiService.get(
          url,
              (data) => ApiInfo.fromJson(data), // Map response to ApiInfo
          authToken: true, // Assuming token-based authentication is required
        ).then((response) {
          // Set the response
          apiInfo.value = response;
          status.value = 'API Info: IP: ${apiInfo.value?.ip}';
        });
      } catch (e) {
        print("Error occurred while fetching API info: $e");
        status.value = 'Error: $e';
      }
    });
  }
}
