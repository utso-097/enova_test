import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/telephony_controller.dart';

class TelephonyScreen extends StatelessWidget {
  const TelephonyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the GetX controller
    final TelephonyController controller = Get.put(TelephonyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Telephony Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.resetData();  // Reset data when the button is pressed
              // controller.fetchSimData();  // Fetch SIM data again
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetX<TelephonyController>(builder: (controller) {
              return _SectionTemplate(
                buttonText: 'Fetch SIM Info',
                onPressed: controller.fetchSimData,
                value: controller.simOperator.value + ' | ' + controller.networkOperator.value,
                isLoading: controller.isLoading.value,
                hasError: controller.hasError.value,
                title: 'SIM Operator',
              );
            }),
          ],
        ),
      ),
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
