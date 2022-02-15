import 'dart:ui';

import 'package:get/get.dart';
import 'package:getx_init_app/localization/en_US.dart';
import 'package:getx_init_app/localization/zh_CN.dart';

class AppLocalizations extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('zh', 'CN');
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh_CN,
        'en_US': en_US,
      };
}
