import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/new_api_controller.dart';
import '../main.dart';

class NewApiScreen extends StatelessWidget {
  const NewApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewApiController controller = Get.put(NewApiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("New API"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reset,  // Reset all results when clicked
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // InfoCardSection(
            //   title: 'API 1 - IPAPI',
            //   child: NewApiInfoSection(title: "IPAPI", index: 1, controller: controller),
            // ),
            InfoCardSection(
              title: 'API 2 - IP Geolocation',
              child: NewApiInfoSection(title: "IP Geolocation", index: 2, controller: controller),
            ),
            InfoCardSection(
              title: 'API 3 - IP Data',
              child: NewApiInfoSection(title: "IP Data", index: 3, controller: controller),
            ),
            InfoCardSection(
              title: 'API 4 - IP API',
              child: NewApiInfoSection(title: "IP API", index: 4, controller: controller),
            ),
            InfoCardSection(
              title: 'API 5 - IP Info',
              child: NewApiInfoSection(title: "IP Info", index: 5, controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class NewApiInfoSection extends StatelessWidget {
  const NewApiInfoSection({
    super.key,
    required this.title,
    required this.index,
    required this.controller,
  });
  final String title;
  final int index;
  final NewApiController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            ElevatedButton(
              onPressed: () => controller.fetchCountryCode(index), // Fetch the corresponding country code based on the index
              child: Text("Fetch Data"),
            ),
          ]
        ),
        SizedBox(height: 10,),
        Obx(() {
          String countryCode = '';
          bool isLoading = false;
          bool hasError = false;

          // Determine which country code, loading, and error states to show based on the index
          switch (index) {
            case 1:
              countryCode = controller.countryCode1.value;
              isLoading = controller.isLoading1.value;
              hasError = controller.hasError1.value;
              break;
            case 2:
              countryCode = controller.countryCode2.value;
              isLoading = controller.isLoading2.value;
              hasError = controller.hasError2.value;
              break;
            case 3:
              countryCode = controller.countryCode3.value;
              isLoading = controller.isLoading3.value;
              hasError = controller.hasError3.value;
              break;
            case 4:
              countryCode = controller.countryCode4.value;
              isLoading = controller.isLoading4.value;
              hasError = controller.hasError4.value;
              break;
            case 5:
              countryCode = controller.countryCode5.value;
              isLoading = controller.isLoading5.value;
              hasError = controller.hasError5.value;
              break;
            default:
              break;
          }

          // Conditional rendering based on loading and error state
          if (isLoading) {
            return const CircularProgressIndicator(strokeWidth: 2,); // Show loading indicator when fetching
          } else if (hasError) {
            return const Text("Error fetching data."); // Show error message if API call failed
          } else if (countryCode.isNotEmpty) {
            return Text("Country Code: $countryCode"); // Show the fetched country code
          } else {
            return const Text("Click to fetch data"); // Default message when no data is available
          }
        }),
      ],
    );
  }
}

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
