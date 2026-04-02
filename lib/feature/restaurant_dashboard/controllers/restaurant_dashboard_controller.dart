import 'package:get/get.dart';

class RestaurantDashboardController extends GetxController {
  var selectedTab = 0.obs; // 0: Dishes, 1: Event, 2: Gallery
  var currentNavIndex = 0.obs;
  
  // States for the action menu
  var isActive = true.obs;
  var isHide = false.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
}
