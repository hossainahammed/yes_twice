import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../offline_storage/shared_pref.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _isLoggedIn = false.obs;
  final _isGuest = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isGuest => _isGuest.value;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await SharedPreferencesHelper.getToken();
    if (token != null && token.isNotEmpty) {
      _isLoggedIn.value = true;
      _isGuest.value = false;
    } else {
      _isLoggedIn.value = false;

    }
  }

  void setGuestMode(bool value) {
    _isGuest.value = value;
    if (value) {
      _isLoggedIn.value = false;
    }
  }

  Future<void> logout() async {
    await SharedPreferencesHelper.clearToken();
    _isLoggedIn.value = false;
    _isGuest.value = false;
  }

  bool checkAuthAndPrompt() {
    if (isLoggedIn) return true;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 50, color: Color(0xFF4C080C)),
              const SizedBox(height: 20),
              const Text(
                'Login Required',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please login to perform this action.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.offAll(() => const LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C080C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    return false;
  }
}
