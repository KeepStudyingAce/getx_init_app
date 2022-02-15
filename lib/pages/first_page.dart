import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/Model/User.dart';
import 'package:getx_init_app/util/route_config.dart';
import 'package:getx_init_app/view/single_line_view.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First"),
      ),
      body: ListView(
        children: [
          SingleLineView(
            title: "Obx",
            onTap: () {
              Get.toNamed(RouteConfig.obxPage);
            },
          ),
          SingleLineView(
            title: "Obx对象以及页面传值",
            onTap: () {
              User bob = User(id: 1, name: "Bob", gender: 1);
              Get.toNamed(RouteConfig.third, arguments: bob);
            },
          ),
        ],
      ),
    );
  }
}

class FirstController extends GetxController {}
