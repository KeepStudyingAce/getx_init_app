import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/getx_controllers/app_controller.dart';
import 'package:getx_init_app/pages/first_page.dart';
import 'package:getx_init_app/pages/second_page.dart';

class RootTab extends StatefulWidget {
  RootTab({Key? key}) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: Get.put(AppController()),
        builder: (controller) {
          return CupertinoTabScaffold(
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  label: "tab_home".tr,
                  icon: Icon(Icons.home),
                  activeIcon: Icon(Icons.home_filled),
                ),
                BottomNavigationBarItem(
                  label: "tab_mine".tr,
                  icon: Icon(Icons.person),
                  activeIcon: Icon(Icons.person_outline),
                )
              ],
            ),
            tabBuilder: (context, index) {
              Widget item = SizedBox();
              switch (index) {
                case 0:
                  item = FirstPage();
                  break;
                case 1:
                  item = SecondPage();
                  break;
                default:
              }
              return item;
            },
          );
        });
  }
}
