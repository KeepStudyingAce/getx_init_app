import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/getx_controllers/app_controller.dart';
import 'package:getx_init_app/view/single_line_view.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);

  final AppController appC = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: ListView(
        children: [
          SingleLineView(
            title: "修改语言",
            onTap: () {
              if (Get.locale!.countryCode == "CN") {
                var locale = Locale('en', 'US');
                Get.updateLocale(locale);
                appC.changeLocale(locale);
              } else {
                var locale = Locale('zh', 'CN');
                Get.updateLocale(locale);
                appC.changeLocale(locale);
              }
            },
          ),
          SingleLineView(
            title: "修改主题",
            onTap: () {
              appC.changeMode();
            },
          ),
        ],
      ),
    );
  }
}
