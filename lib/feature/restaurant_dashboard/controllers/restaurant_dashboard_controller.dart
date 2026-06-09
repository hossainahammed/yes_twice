import 'package:get/get.dart';

class RestaurantDashboardController extends GetxController {
  var selectedTab = 0.obs; // 0: Dishes, 1: Event, 2: Gallery
  var currentNavIndex = 0.obs;


  var isActive = true.obs;
  var isHide = false.obs;


  var restaurants = <Map<String, dynamic>>[].obs;
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    restaurants.assignAll([
      {
        "name": "Smokehouse",
        "address": "108 Oakway Lane, CA 91303",
        "price": "\$\$",
      },
      {
        "name": "Shahjhan Grill",
        "address": "3523 West Park SUMT 90001",
        "price": "\$\$",
      },
      {"name": "Ramada", "address": "1405 Mattson, IR 7103", "price": "\$\$"},
      {
        "name": "HolidayInn",
        "address": "2323 Dancing, NY 11101",
        "price": "\$\$",
      },
    ]);
    events.assignAll(
      List.generate(8, (index) => {"title": "Sunset Jazz & Tapas"}),
    );
  }

  void clearData() {
    restaurants.clear();
    events.clear();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
}
