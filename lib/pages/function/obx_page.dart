import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/Model/User.dart';
import 'package:getx_init_app/util/route_config.dart';
import 'package:getx_init_app/view/single_line_view.dart';

class ObxPage extends StatelessWidget {
  ObxPage({Key? key}) : super(key: key);
  final ObxController obxC = Get.put(ObxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ObxPage"),
        ),
        body: ListView(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  obxC.increase();
                },
                child: Center(
                  child: Text(
                    '点击了 ${obxC.count.value} 次',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
            SingleLineView(
              title: "Obx 传递对象到下一个页面 并获取新对象",
              onTap: () {
                obxC.pushObjectAndRefresh();
              },
            ),
            Obx(
              () => Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'ThirdPage返回的新对象',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SingleLineView(
                      title: "ID",
                      rightWidget: Text("${obxC.user.value.id}"),
                    ),
                    SingleLineView(
                      title: "姓名",
                      rightWidget: Text("${obxC.user.value.name}"),
                    ),
                    SingleLineView(
                      title: "性别",
                      rightWidget: Text("${obxC.user.value.gender}"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class ObxController extends GetxController {
  var count = 0.obs;

  ///自增
  void increase() => ++count;

  final user = User(id: 0, name: "XX", gender: -1).obs; //监听对象

  void pushObjectAndRefresh() async {
    User bob = User(id: 1, name: "Bob", gender: 1);
    Rx<User> userTemp = await Get.toNamed(RouteConfig.third, arguments: bob);
    saveNewUser(userTemp);
  }

  void saveNewUser(Rx<User> temp) {
    user.update((val) {
      val?.id = temp.value.id;
      val?.name = temp.value.name;
      val?.gender = temp.value.gender;
    });
  }
}
