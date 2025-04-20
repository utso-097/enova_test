import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class NewApiController extends GetxController {
  final countryCode1 = ''.obs;
  final countryCode2 = ''.obs;
  final countryCode3 = ''.obs;
  final countryCode4 = ''.obs;
  final countryCode5 = ''.obs;

  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;
  var isLoading4 = false.obs;
  var isLoading5 = false.obs;

  var hasError1 = false.obs;
  var hasError2 = false.obs;
  var hasError3 = false.obs;
  var hasError4 = false.obs;
  var hasError5 = false.obs;

  // List of APIs
  final List<String> apiList = [
    "https://ipapi.co/json/",
    "https://api.ipgeolocation.io/ipgeo?apiKey=0ee2790e0fa3414e8de3165df54dd3cb",
    "https://api.ipdata.co?api-key=753de6301326e7c820c99f56a0312a732be4ce52fa35df4f24b4c353",
    "http://ip-api.com/json",
    "https://ipinfo.io/json"
  ];

  // Method to fetch country code for each API
  Future<void> fetchCountryCode(int index) async {
    RxString countryCode;
    RxBool isLoading;
    RxBool hasError;

    // Assign the specific variables based on the index
    switch (index) {
      case 1:
        countryCode = countryCode1;
        isLoading = isLoading1;
        hasError = hasError1;
        break;
      case 2:
        countryCode = countryCode2;
        isLoading = isLoading2;
        hasError = hasError2;
        break;
      case 3:
        countryCode = countryCode3;
        isLoading = isLoading3;
        hasError = hasError3;
        break;
      case 4:
        countryCode = countryCode4;
        isLoading = isLoading4;
        hasError = hasError4;
        break;
      case 5:
        countryCode = countryCode5;
        isLoading = isLoading5;
        hasError = hasError5;
        break;
      default:
        return;
    }

    // Reset the country code, loading, and error state
    isLoading.value = true;
    hasError.value = false;
    countryCode.value = ''; // Reset country code to empty string

    try {
      final response = await http.get(Uri.parse(apiList[index - 1])).timeout(Duration(seconds: 10));;
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var code = data['country_code'] ?? data['countryCode'] ?? data['country'] ?? data['country_code2'] ?? data['country'];
        if (code != null) {
          countryCode.value = code;
        }
      } else {
        hasError.value = true;
        developer.log("Error: ${response.statusCode}");
      }
    } catch (e) {
      developer.log("The error is : ${e.toString()}");
      hasError.value = true;
    }

    isLoading.value = false;
  }

  // Reset all country codes
  void reset() {
    countryCode1.value = '';
    countryCode2.value = '';
    countryCode3.value = '';
    countryCode4.value = '';
    countryCode5.value = '';

    isLoading1.value = false;
    isLoading2.value = false;
    isLoading3.value = false;
    isLoading4.value = false;
    isLoading5.value = false;

    hasError1.value = false;
    hasError2.value = false;
    hasError3.value = false;
    hasError4.value = false;
    hasError5.value = false;
  }
}
