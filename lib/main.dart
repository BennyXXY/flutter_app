import 'package:flutter/material.dart';

import 'basewidget/NewRouteDemo.dart';
import 'animation/like.dart';

//void main() {
//  runApp(MyApp());
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonBarTheme:
        ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.accent),
      ),
      initialRoute: "/",
      //将此页注册为初始化路由页面

      home: _bobody(),
      title: "Benny",
      routes: {
        "newRoute": (context) => MyAPPRout(text:ModalRoute.of(context).settings.arguments),
        // "/": (context) => MyApp(),
      },
    );
  }
}

class _bobody extends StatelessWidget {
  const _bobody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        //一个底部应用导航栏
        notchMargin: 10, //控件之间的空白等级
        shape: CircularNotchedRectangle(), //创建一个有阴影的原型
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //将自由空间放在两个child之间
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MyAPPRout(
                        text: "我是返回值2",
                      );
                    }));
                print("路由返回值$result");
              },
            ),
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
//                print("=======================");
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(
////                      builder: (context) {
////                        return MyAPPRout();
////                      },
////                      // settings: settings,
////                      maintainState: false,
////                      fullscreenDialog: false),
////                );

                Navigator.pushNamed(context, "newRoute",arguments: "猪头一个");
              },
            )
//            LayoutBuilder(
//              builder: (context, t) => IconButton(
//                icon: Icon(Icons.people),
//                onPressed: () {
//                  print("=======================");
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) {
//                      return MyAPPRout();
//                    }),
//                  );
//                },
//              ),
//            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(),
      //创建一个浮动按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //此属性会将浮动按钮放在底部导航栏中心并浮动在导航栏上
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Like(),
        ),
      ),
    );
  }
}

class ShowMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowMenuState();
}

class _ShowMenuState extends State<ShowMenu> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => _buildShowMenu(),
    );
  }

  _buildShowMenu() {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(context: context, position: position, items: <PopupMenuEntry>[
      PopupMenuItem(child: Text('语文')),
      PopupMenuDivider(),
      CheckedPopupMenuItem(
        child: Text('数学'),
        checked: true,
      ),
      PopupMenuDivider(),
      PopupMenuItem(child: Text('英语')),
    ]);
  }
}
