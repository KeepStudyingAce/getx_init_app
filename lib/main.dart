import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/getx_controllers/app_controller.dart';
import 'package:getx_init_app/localization/app_localizations.dart';
import 'package:getx_init_app/pages/first_page.dart';
import 'package:getx_init_app/pages/second_page.dart';
import 'package:getx_init_app/util/route_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppLocalizations(), // 你的翻译
      locale: AppLocalizations.locale, // 将会按照此处指定的语言翻译
      fallbackLocale:
          AppLocalizations.fallbackLocale, // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      title: 'GetX App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: RouteConfig.getPages,
      initialRoute: RouteConfig.welcome,
    );
  }
}
