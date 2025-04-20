import 'package:another_telephony/telephony.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class TelephonyController extends GetxController {
  var simOperator = ''.obs;
  var networkOperator = ''.obs;
  var simState = ''.obs;
  var isLoading = false.obs;
  var hasError = false.obs;

  final Telephony telephony = Telephony.instance;

  // Method to fetch SIM data
  Future<void> fetchSimData() async {
    bool permissionsGranted = await telephony.requestPhoneAndSmsPermissions ?? false;

    if (permissionsGranted) {
      try {
        isLoading.value = true;

        // Fetch SIM state correctly by awaiting the result
        SimState state = await telephony.simState;

        // Convert the simState to string value for display
        simState.value = state.toString();
        print("Sim state value is: ${simState.value}");

        if (state == SimState.READY) {
          simOperator.value = await telephony.simOperator ?? 'Not Available';
          networkOperator.value = await telephony.networkOperator ?? 'Not Available';
        } else {
          simOperator.value = 'SIM is not ready';
          networkOperator.value = 'Network not available';
        }

        hasError.value = false;
      } catch (e) {
        hasError.value = true;
        simOperator.value = 'Failed to fetch SIM data';
        networkOperator.value = 'Failed to fetch Network data';
      } finally {
        isLoading.value = false;
      }
    } else {
      simOperator.value = 'Permissions denied';
      networkOperator.value = 'Permissions denied';
      hasError.value = true;
    }
  }

  // Method to reset all values
  void resetData() {
    simOperator.value = '';
    networkOperator.value = '';
    simState.value = '';
    hasError.value = false;
    isLoading.value = false;
  }
}
