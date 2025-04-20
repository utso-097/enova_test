import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/api_info.controller.dart';
import '../controllers/check_token.controller.dart';
import '../controllers/dynamic_link.controller.dart';
import '../main.dart';

class OldApiScreen extends StatelessWidget {
  const OldApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Old API"),  // Set the title of the AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),  // Back button icon
          onPressed: () {
            // Use Get.back() to go back to the previous screen
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reset controllers if necessary
              Get.find<ApiInfoController>().reset();
              Get.find<DynamicLinkController>().reset();
              Get.find<CheckTokenController>().reset();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Each of these sections will be handled by their respective controllers
            InfoCardSection(
              title: 'API Info',
              child: ApiInfoSection(title: "API Info"),
            ),
            InfoCardSection(
              title: 'Dynamic Link Data',
              child: DynamicLinkSection(title: "Dynamic Link Info"),
            ),
            InfoCardSection(
              title: "Check Token Data",
              child: CheckTokenSection(title: "Check Token Info"),
            ),
          ],
        ),
      ),
    );
  }
}
