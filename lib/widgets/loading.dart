import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const shimmerIcon = "lib/sources/images/shimmer_icon.png";
const String refreshIcon = "lib/sources/images/refresh_icon.png";

class Loading {
  static showToast(String message) {
    EasyLoading.instance.textColor = Colors.white;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.indicatorColor = Colors.white;
    EasyLoading.instance.progressColor = Colors.blue;
    EasyLoading.instance.backgroundColor = Colors.black54;
    EasyLoading.showToast(message, duration: Duration(milliseconds: 1000));
  }

  static show() {
    //展示loading的时候不允许用户交互
    EasyLoading.instance.userInteractions = false;

    //==========自定义loading动画==========
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    setRingIndicator();
    EasyLoading.show();
  }

  //类似转圈
  static setRingIndicator() {
    EasyLoading.instance.indicatorWidget = Container(
        constraints: BoxConstraints(
          maxWidth: 30,
        ),
        child: SpinKitRing(
          color: Colors.white,
          size: 30,
          lineWidth: 3,
        ));
    EasyLoading.instance.textColor = Colors.black87;
    EasyLoading.instance.progressColor = Colors.white;
    EasyLoading.instance.indicatorColor = Colors.white;
    EasyLoading.instance.backgroundColor = Colors.black26;
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
