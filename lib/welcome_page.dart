import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_init_app/util/route_config.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // 跳转对应的主页
      Get.offNamed(RouteConfig.rootTab);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("WelcomePage"),
        ),
      ),
    );
  }
}
