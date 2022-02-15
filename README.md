## 一、GetX使用

1、Obx是配合Rx响应式变量使用、GetBuilder是配合update使用：请注意，这完全是俩套定点刷新控件的方案
区别：前者响应式变量变化，Obx自动刷新；后者需要使用update手动调用刷新
响应式变量，因为使用的是StreamBuilder，会消耗一定资源
GetBuilder内部实际上是对StatefulWidget的封装，所以占用资源极小。

1.1:更新obs变量的两种方式：

        例子：final user = User().obs;
        1.1.1、当你需要更新user变量时：获取到新的对象为Rx<User>
        user.update( (user) { // 这个参数是你要更新的类本身。
            user.name = 'Jonny';
            user.age = 18;
        });
        1.1.2更新user变量的另一种方式：获取到新的对象为User
        user(User(name: 'João', age: 35));


使用场景

    一般来说，对于大多数场景都是可以使用响应式变量的
    但是，在一个包含了大量对象的List，都使用响应式变量，将生成大量的StreamBuilder，必将对内存造成较大的压力，该情况下，就要考虑使用简单状态管理了

    GetBuilder这个方法
    init：虽然上述代码没用到，但是，这个参数是存在在GetBuilder中的，因为在加载变量的时候就使用Get.put()生成了CounterEasyGetLogic对象，GetBuilder会自动查找该对象，所以，就可以不使用init参数
    builder：方法参数，拥有一个入参，类型便是GetBuilder所传入泛型的类型
    initState，dispose等：GetBuilder拥有StatefulWidget所有周期回调，可以在相应回调内做一些操作


总的来说：推荐GetBuilder和update配合的写法
GetBuilder内置回收GetxController的功能，能避免一些无法自动回收GetxController的坑爹问题
使用Obx，相关变量定义初始化以及实体更新和常规写法不同，会对初次接触该框架的人，造成很大的困扰
getx插件现已支持一键Wrap Widget生成GetBuilder，可以一定程度上提升你的开发效率



2、GetxController包含比较完整的生命周期回调，可以在onInit()接受传递的数据；
如果接收的数据需要刷新到界面上，请在onReady回调里面接收数据操作
onReady是在addPostFrameCallback回调中调用，刷新数据的操作在onReady进行，能保证界面是初始加载完毕后才进行页面刷新操作的；

3、路由相关

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

4、 get语法

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

5、导航的嵌套，新模块设置新的导航；

    Navigator(
        key: Get.nestedKey(1),
        initialRoute: "specialPage",
        onGenerateRoute: controller.onGenerateRoute;
    )
在controller中实现新的路由定义：

    Route? onGenerateRoute(RouteSetting settings){
        Route? route;
        switch (settings.name){
            case "expample":
                route = GetPageRoute(
                    settings:setting,
                    page:()=> LoginPage(),
                )
            break;
            default;
        }
        return null;
    }

6、切换主题

    Get.changeTheme(Get.isDarkMode? ThemeData.light():ThemeData.dark());


## 二、GetX未被释放场景

    在我们使用GetX的时候，可能没什么GetxController未被释放的感觉，这种情况，是因为我们一般都是用了getx的那一套路由跳转api（Get.to、Get.toName...）之类：使用Get.toName，肯定需要使用GetPage；如果使用Get.to，是不需要在GetPage中注册的，Get.to的内部有一个添加到GetPageRoute的操作


通过上面会在GetPage注册可知，说明在我们跳转页面的时候，GetX会拿你到页面信息存储起来，加以管理，下面俩种场景会导致GetxController无法释放

    
    1、未使用GetX提供的路由跳转：直接使用原生路由api的跳转操作
    这样会直接导致GetX无法感知对应页面GetxController的生命周期，会导致其无法释放
    在GetPage注册页面，不使用Get.toName，这样无法释放；GetPage+Get.toName配套使用可释放
    直接使用Get.to，可释放
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => XxxxPage()),
    );

    2、一般app都是，一个主页面，加几个tab：首页、信息流页、操作页、个人中心之类
    如果你遇到需要重新登录，再回到主页，你可能会发现个人中心这些页面的GetxController控制未被回收！
    这些页面已经和上面的路由页面无关了，因为他们本身只能算是主页面上的几个tab子页面，没法用路由去标定绑定关系；

解决方案

上面两种情况只需要手动去释放GetxController；
第一个页面跳转

    Navigator.push(
        Get.context,
        MaterialPageRoute(builder: (context) => AutoDisposePage()),
    );

这地方必须要使用StatefulWidget在dispose函数里去手动回收GetxController

    class AutoDisposePage extends StatefulWidget {
    @override
    _AutoDisposePageState createState() => _AutoDisposePageState();
    }

    class _AutoDisposePageState extends State<AutoDisposePage> {
    final AutoDisposeLogic logic = Get.put(AutoDisposeLogic());

    @override
    Widget build(BuildContext context) {
        return BaseScaffold(
        appBar: AppBar(title: const Text('计数器-自动释放')),
        body: Center(
            child: Obx(
            () => Text('点击了 ${logic.count.value} 次',
                style: TextStyle(fontSize: 30.0)),
            ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => logic.increase(),
            child: const Icon(Icons.add),
        ),
        );
    }

    @override
    void dispose() {
        Get.delete<AutoDisposeLogic>();
        super.dispose();
    }
    }

    class AutoDisposeLogic extends GetxController {
    var count = 0.obs;

    ///自增
    void increase() => ++count;
    }



