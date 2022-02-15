import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/Model/User.dart';
import 'package:getx_init_app/view/single_line_view.dart';

class ThirdPage extends StatelessWidget {
  ThirdPage({Key? key}) : super(key: key);
  final ThirdController thirdC = Get.put(ThirdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "ThirdPage",
      )),
      body: Obx(
        () => ListView(
          children: [
            SingleLineView(
              title: "ID",
              rightWidget: Text("${thirdC.user.value.id}"),
            ),
            SingleLineView(
              title: "姓名",
              rightWidget: Text("${thirdC.user.value.name}"),
            ),
            SingleLineView(
              title: "性别",
              rightWidget: Text("${thirdC.user.value.gender}"),
            ),
            Center(child: Text(thirdC.statusString.value)),
            SingleLineView(
              title: "新数据带回上一个页面",
              onTap: () {
                Get.back(result: thirdC.user);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdController extends GetxController {
  final user = User(id: 0, name: "XX", gender: -1).obs; //监听对象
  var statusString = "默认展示数据".obs;
  /*
    GetxController包含比较完整的生命周期回调，可以在onInit()接受传递的数据；
    如果接收的数据需要刷新到界面上，请在onReady回调里面接收数据操作
    onReady是在addPostFrameCallback回调中调用，刷新数据的操作在onReady进行，能保证界面是初始加载完毕后才进行页面刷新操作的
  */
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    User temp = Get.arguments;
    //2s后刷新页面数据
    Future.delayed(Duration(seconds: 2), () {
      //炫酷的更新方式
      statusString("新数据");
      user(temp);
    });

    super.onReady();
  }
}
