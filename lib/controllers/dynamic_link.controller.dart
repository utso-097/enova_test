import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/dynamic_info_response.model.dart';
import '../services/api_service.dart';
import 'base.controller.dart';

class DynamicLinkController extends BaseController {
  final ApiService apiService;  // Inject ApiService

  // This holds the response
  final Rx<DynamicLinkResponse?> dynamicLinkResponse = Rx<DynamicLinkResponse?>(null);

  // Constructor to inject the ApiService
  DynamicLinkController({required this.apiService});

  // Method to fetch dynamic link data
  Future<void> fetchDynamicLinkData() async {
    await executeWithTimeout(() async {
      final String url = 'download-info';

      // Prepare the body data for the POST request
      final Map<String, dynamic> body = {
        "campaign": "download",
        "os": "android",
        "phone": "Samsung",
      };

      try {
        // Call ApiService's post method
        await apiService.post(
          url,
          body,
              (data) => DynamicLinkResponse.fromJson(data), // Map response to DynamicLinkResponse
        ).then((response) {
          // Set the response
          dynamicLinkResponse.value = response;
          status.value = 'Message: ${dynamicLinkResponse.value?.message}';
        });
      } catch (e) {
        print("Error occurred while fetching dynamic link data: $e");
        status.value = 'Error: $e';
      }
    });
  }
}