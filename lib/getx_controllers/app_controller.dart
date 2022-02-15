import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Locale? locale = Get.locale;

  void changeLocale(Locale? temp) {
    locale = temp;
    update();
  }

  void changeMode(){
    Get.changeTheme(Get.isDarkMode? ThemeData.light():ThemeData.dark());
  }
}
