import 'package:enova_test/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'controllers/api_info.controller.dart';
import 'controllers/check_token.controller.dart';
import 'controllers/dynamic_link.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApiService(client: http.Client()));
  Get.put(ApiInfoController(apiService: Get.find()));
  Get.put(DynamicLinkController(apiService: Get.find()));
  Get.put(CheckTokenController(apiService: Get.find()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enova API Test',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Enova API Test'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enova API Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Get.find<CountryController>().reset();
              Get.find<ApiInfoController>().reset();
              Get.find<DynamicLinkController>().reset();
              Get.find<CheckTokenController>().reset();
              // Get.find<LocalInfoController>().reset();
              // Get.find<CloudflareController>().reset();
            },
          ),
        ],
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          // InfoCardSection(title: 'Location Info', child: CountrySection()),
          InfoCardSection(title: 'API Info', child: ApiInfoSection(title: "API Info",)),
          InfoCardSection(title: 'Dynamic Link Data', child: DynamicLinkSection(title: "Dynamic Link Info")),
          InfoCardSection(title: "Check Token Data", child: CheckTokenSection(title: "Check Token Info")),
          // InfoCardSection(title: 'Local Info', child: LocalInfoSection()),
          // InfoCardSection(title: 'Cloudflare Check', child: CloudflareSection()),
        ],
      ),
    );
  }
}

class InfoCardSection extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoCardSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// class CountryController extends BaseController {
//   final Rx<LocationInfo?> locationInfo = Rx<LocationInfo?>(null);
//
//   Future<void> fetchLocationInfo() async {
//     await executeWithTimeout(() async {
//       final response = await http.get(Uri.parse('https://mm.enova.workers.dev/'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         locationInfo.value = LocationInfo.fromJson(data);
//         status.value = 'Country: ${locationInfo.value?.country}, IP: ${locationInfo.value?.ip}';
//       } else {
//         throw Exception('Failed to fetch location info');
//       }
//     });
//   }
// }

// class LocalInfoController extends BaseController {
//   final Rx<LocalInfo?> localInfo = Rx<LocalInfo?>(null);
//
//   Future<void> fetchLocalInfo() async {
//     await executeWithTimeout(() async {
//       final response = await http.get(Uri.parse('https://mm.getenova.com/mm-info'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         localInfo.value = LocalInfo.fromJson(data);
//         status.value = 'Local Info: ${localInfo.value?.message}, IP: ${localInfo.value?.ip}';
//       } else {
//         throw Exception('Failed to fetch local info');
//       }
//     });
//   }
// }


// class CloudflareController extends BaseController {
//   final Rx<CloudflareInfo?> cloudflareInfo = Rx<CloudflareInfo?>(null);
//
//   Future<void> fetchCloudflareInfo() async {
//     await executeWithTimeout(() async {
//       final response = await http.get(Uri.parse('https://secure-mm.enova.workers.dev/'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         cloudflareInfo.value = CloudflareInfo.fromJson(data);
//         status.value = 'Cloudflare: ${cloudflareInfo.value?.message}';
//       } else {
//         throw Exception('Failed to fetch Cloudflare info');
//       }
//     });
//   }
// }

class _SectionTemplate extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final String value;
  final bool isLoading;
  final bool hasError;
  final String title;

  const _SectionTemplate({
    required this.buttonText,
    required this.onPressed,
    required this.value,
    required this.isLoading,
    required this.hasError,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              child: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Text(buttonText),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          value.isEmpty ? 'Click to fetch data' : value,
          style: TextStyle(
            color: hasError ? Colors.red : Theme.of(context).textTheme.bodyMedium?.color,
            fontStyle: value.isEmpty ? FontStyle.italic : FontStyle.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
// Updated sections using the template
// class CountrySection extends StatelessWidget {
//   const CountrySection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetX<CountryController>(
//       init: CountryController(),
//       builder: (controller) => _SectionTemplate(
//         buttonText: 'Fetch Location Info',
//         onPressed: controller.fetchLocationInfo,
//         value: controller.status.value,
//         isLoading: controller.isLoading.value,
//         hasError: controller.hasError.value,
//       ),
//     );
//   }
// }
//
// class LocalInfoSection extends StatelessWidget {
//   const LocalInfoSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetX<LocalInfoController>(
//       init: LocalInfoController(),
//       builder: (controller) => _SectionTemplate(
//         buttonText: 'Fetch Local Info',
//         onPressed: controller.fetchLocalInfo,
//         value: controller.status.value,
//         isLoading: controller.isLoading.value,
//         hasError: controller.hasError.value,
//       ),
//     );
//   }
// }

class ApiInfoSection extends StatelessWidget {
  const ApiInfoSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetX<ApiInfoController>(
      init: ApiInfoController(apiService: Get.find()),
      builder: (controller) => _SectionTemplate(
        buttonText: 'Fetch API Info',
        onPressed: controller.fetchApiInfo,
        value: controller.status.value,
        isLoading: controller.isLoading.value,
        hasError: controller.hasError.value,
        title: title,
      ),
    );
  }
}

// class CloudflareSection extends StatelessWidget {
//   const CloudflareSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetX<CloudflareController>(
//       init: CloudflareController(),
//       builder: (controller) => _SectionTemplate(
//         buttonText: 'Fetch Cloudflare Info',
//         onPressed: controller.fetchCloudflareInfo,
//         value: controller.status.value,
//         isLoading: controller.isLoading.value,
//         hasError: controller.hasError.value,
//       ),
//     );
//   }
// }


// class LocationInfo {
//   final String ip;
//   final String country;
//
//   LocationInfo({required this.ip, required this.country});
//
//   factory LocationInfo.fromJson(Map<String, dynamic> json) {
//     return LocationInfo(
//       ip: json['ip'],
//       country: json['country'],
//     );
//   }
// }

// class LocalInfo {
//   final String message;
//   final String country;
//   final String ip;
//
//   LocalInfo({required this.message, required this.country, required this.ip});
//
//   factory LocalInfo.fromJson(Map<String, dynamic> json) {
//     return LocalInfo(
//       message: json['message'],
//       country: json['country'],
//       ip: json['ip'],
//     );
//   }
// }



// class CloudflareInfo {
//   final String message;
//   final bool error;
//   final int statusCode;
//   final int optionalCode;
//   final dynamic data;
//
//   CloudflareInfo({
//     required this.message,
//     required this.error,
//     required this.statusCode,
//     required this.optionalCode,
//     required this.data,
//   });
//
//   factory CloudflareInfo.fromJson(Map<String, dynamic> json) {
//     return CloudflareInfo(
//       message: json['message'],
//       error: json['error'],
//       statusCode: json['statusCode'],
//       optionalCode: json['optionalCode'],
//       data: json['data'],
//     );
//   }
// }

class DynamicLinkSection extends StatelessWidget {
  const DynamicLinkSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetX<DynamicLinkController>(
      init: DynamicLinkController(apiService: Get.find()),  // Initialize the DynamicLinkController
      builder: (controller) {
        print("TheStatus value is ${controller.status.value}");
        return _SectionTemplate(
          buttonText: 'Fetch Data',
          onPressed: controller.fetchDynamicLinkData, // Now using DynamicLinkController's method
          value: controller.status.value,
          isLoading: controller.isLoading.value,
          hasError: controller.hasError.value,
          title: title,
        );
      },
    );
  }
}

class CheckTokenSection extends StatelessWidget {
  const CheckTokenSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GetX<CheckTokenController>(
      init: CheckTokenController(apiService: Get.find()),  // Initialize the CheckTokenController
      builder: (controller) {
        print("TheTokenStatus value is ${controller.status.value}");
        return _SectionTemplate(
          buttonText: 'Check Token',  // Button text for checking the token
          onPressed: controller.checkAuthToken,  // Replace with actual token
          value: controller.status.value,  // Display the status of the check token
          isLoading: controller.isLoading.value,
          hasError: controller.hasError.value,
          title: title,  // Section title
        );
      },
    );
  }
}
