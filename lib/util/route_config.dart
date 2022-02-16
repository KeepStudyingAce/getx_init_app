/*
1、导航到新的页面
Get.to(NextScreen());
Get.toNamed("/NextScreen");
2、关闭SnackBars、Dialogs、BottomSheets或任何你通常会用Navigator.pop(context)关闭的东西
Get.back();
3、进入下一个页面，但没有返回上一个页面的选项（用于SplashScreens，登录页面等）
Get.off(NextScreen());
Get.offNamed("/NextScreen");
4、进入下一个界面并取消之前的所有路由（在购物车、投票和测试中很有用）
Get.offAll(NextScreen());
Get.offAllNamed("/NextScreen");
5、发送数据到其它页面
只要发送你想要的参数即可。Get在这里接受任何东西，无论是一个字符串，一个Map，一个List，甚至一个类的实例。

Get.to(NextScreen(), arguments: 'Get is the best');
Get.toNamed("/NextScreen", arguments: 'Get is the best');
在你的类或控制器上：

print(Get.arguments);
//print out: Get is the best
要导航到下一条路由，并在返回后立即接收或更新数据
var data = await Get.to(Payment());
var data = await Get.toNamed("/payment");
在另一个页面上，发送前一个路由的数据
Get.back(result: 'success');
// 并使用它，例：
if(data == 'success') madeAnything();
6、如果你不想使用GetX语法，只要把 Navigator（大写）改成 navigator（小写），你就可以拥有标准导航的所有功能，而不需要使用context，例如：
// 默认的Flutter导航
Navigator.of(context).push(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) {
      return HomePage();
    },
  ),
);

// 使用Flutter语法获得，而不需要context。
navigator.push(
  MaterialPageRoute(
    builder: (_) {
      return HomePage();
    },
  ),
);

6、 get语法
Get.to(HomePage());
动态网页链接

这是一个非常重要的功能，在web端，可以保证通过url传参数到页面里
Get提供高级动态URL，就像在Web上一样。Web开发者可能已经在Flutter上想要这个功能了，Get也解决了这个问题。

Get.offAllNamed("/NextScreen?device=phone&id=354&name=Enzo");
在你的controller/bloc/stateful/stateless类上：

print(Get.parameters['id']);
// out: 354
print(Get.parameters['name']);
// out: Enzo
你也可以用Get轻松接收NamedParameters。

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
      GetPage(
        name: '/',
        page: () => MyHomePage(),
      ),
      GetPage(
        name: '/profile/',
        page: () => MyProfile(),
      ),
       //你可以为有参数的路由定义一个不同的页面，也可以为没有参数的路由定义一个不同的页面，但是你必须在不接收参数的路由上使用斜杠"/"，就像上面说的那样。
       GetPage(
        name: '/profile/:user',
        page: () => UserProfile(),
      ),
      GetPage(
        name: '/third',
        page: () => Third(),
        transition: Transition.cupertino  
      ),
     ],
    )
  );
}
发送命名路由数据

Get.toNamed("/profile/34954");
在第二个页面上，通过参数获取数据

print(Get.parameters['user']);
// out: 34954
现在，你需要做的就是使用Get.toNamed()来导航你的命名路由，不需要任何context(你可以直接从你的BLoC或Controller类中调用你的路由)，当你的应用程序被编译到web时，你的路由将出现在URL中。


*/
import 'package:get/get.dart';
import 'package:getx_init_app/pages/fifth_page.dart';
import 'package:getx_init_app/pages/first_page.dart';
import 'package:getx_init_app/pages/fourth_page.dart';
import 'package:getx_init_app/pages/function/obx_page.dart';
import 'package:getx_init_app/pages/second_page.dart';
import 'package:getx_init_app/pages/third_page.dart';
import 'package:getx_init_app/root_tab.dart';
import 'package:getx_init_app/welcome_page.dart';

class RouteConfig {
  static final String welcome = "/welcome";
  static final String rootTab = "/rootTab";
  static final String first = "/first";
  static final String second = "/second";
  static final String third = "/third";
  static final String fourth = "/fourth";
  static final String fifth = "/fifth";

  static final String obxPage = "/obxPage";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: rootTab, page: () => RootTab()),
    GetPage(name: welcome, page: () => WelcomePage()),
    GetPage(name: first, page: () => FirstPage()),
    GetPage(name: second, page: () => SecondPage()),
    GetPage(name: third, page: () => ThirdPage()),
    GetPage(name: fourth, page: () => FourthPage()),
    GetPage(name: fifth, page: () => FifthPage()),
    GetPage(name: obxPage, page: () => ObxPage()),
  ];
}
