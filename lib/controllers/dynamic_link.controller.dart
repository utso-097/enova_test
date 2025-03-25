import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/dynamic_info_response.model.dart';
import 'base.controller.dart';

class DynamicLinkController extends BaseController {
  final Rx<DynamicLinkResponse?> dynamicLinkResponse = Rx<DynamicLinkResponse?>(null);

  // Method to fetch dynamic link data
  Future<void> fetchDynamicLinkData() async {
    await executeWithTimeout(() async {
      final String url = 'https://mm.getenova.com/api/v2/download-info';
        // Prepare the body data for the POST request
        final Map<String, dynamic> body = {
          "campaign": "download",
          "os": "android",
          "phone": "Samsung",
        };

        // Make the POST request
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          dynamicLinkResponse.value = DynamicLinkResponse.fromJson(data);
          status.value = 'Message: ${dynamicLinkResponse.value?.message}';
        } else {
          throw Exception('Failed to fetch API info');
        }
    });
  }
}
