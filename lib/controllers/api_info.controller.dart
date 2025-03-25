import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/api_info.model.dart';
import 'base.controller.dart';

class ApiInfoController extends BaseController {
  final Rx<ApiInfo?> apiInfo = Rx<ApiInfo?>(null);

  // Method to fetch API info
  Future<void> fetchApiInfo() async {
    await executeWithTimeout(() async {
      final response = await http.get(Uri.parse('https://mm.getenova.com/api/v2/app-info'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        apiInfo.value = ApiInfo.fromJson(data);
        status.value = 'API Info: IP: ${apiInfo.value?.ip}';
      } else {
        throw Exception('Failed to fetch API info');
      }
    });
  }
}
