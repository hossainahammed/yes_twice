import 'package:get/get.dart';

class TaskController extends GetxController {
  var selectedDuration = 1.obs;
  var isHighPriority = false.obs;
  var isToday = false.obs;

  void selectDuration(int index) {
    selectedDuration.value = index;
  }

  void togglePriority() {
    isHighPriority.toggle();
  }

  void toggleToday() {
    isToday.toggle();
  }
}
