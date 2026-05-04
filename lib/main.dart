import 'package:bolaji277/core/service/auth_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'core/constant/app_colors.dart';
import 'my_app.dart';

void main() {
  /// Register services globally so they can be found anywhere
  configEasyLoading();
  Get.put(AuthService());

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.textColor
    ..textColor = AppColors.whiteColor
    ..indicatorColor = AppColors.whiteColor
    ..maskColor = AppColors.primaryColor
    ..indicatorSize = 45
    ..radius = 10
    ..userInteractions = false
    ..dismissOnTap = false;
}