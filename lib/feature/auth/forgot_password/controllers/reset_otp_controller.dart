import 'dart:async';
import 'package:get/get.dart';

class ResetOtpController extends GetxController {
  static ResetOtpController get instance => Get.find();


  var otp = "".obs;


  var secondsRemaining = 20.obs;
  Timer? _timer;


  var canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }


  void startTimer() {
    secondsRemaining.value = 20;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }


  String? validateOtp() {
    if (otp.value.length < 6) return "Enter the 6-digit code";
    return null;
  }



  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
