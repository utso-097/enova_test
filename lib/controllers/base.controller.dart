import 'dart:async';

import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final RxString status = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  final String baseUrl = "https://mm.getenova.com/api/v2/";


  void reset() {
    status.value = '';
    isLoading.value = false;
    hasError.value = false;
  }

  Future<void> executeWithTimeout(Future<void> Function() task) async {
    isLoading.value = true;
    hasError.value = false;
    try {
      await task().timeout(const Duration(seconds: 5));
      hasError.value = false;
    } on TimeoutException {
      status.value = 'Request timed out';
      hasError.value = true;
    } catch (e) {
      status.value = 'Error: ${e.toString()}';
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
