import 'dart:math';

import 'package:fbutton/fbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ffloat/ffloat.dart';
import 'package:flutterapp/listview/NestedScrollDemoPage.dart';
import 'package:fradio/fradio.dart';
import 'package:fsuper/fsuper.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('弹框'),
      ),
      body: demo1(),
    ),
  ));
}

class demo1 extends StatefulWidget {
  @override
  _demo1State createState() => _demo1State();
}

class _demo1State extends State<demo1> {
  List<FFloatAlignment> alignmentList;
  FFloatController controller5 = FFloatController();
  FFloatController controller4 = FFloatController();
  FFloatController controller3_1 = FFloatController();
  List<String> clickList = [];
  int group_corner_value = -1;
  int group_menu_value1 = -1;
  int group_menu_value2 = -1;
  int group_menu_value3 = -1;
  int group_toolbar_value = -1;

  List<String> fileMenuList = [];
  @override
  void initState() {
    alignmentList = [
//      FFloatAlignment.topLeft,
      FFloatAlignment.topCenter,
//      FFloatAlignment.topRight,
//      FFloatAlignment.bottomLeft,
      FFloatAlignment.bottomCenter,
//      FFloatAlignment.bottomRight,
//      FFloatAlignment.leftTop,
      FFloatAlignment.leftCenter,
//      FFloatAlignment.leftBottom,
//      FFloatAlignment.rightTop,
      FFloatAlignment.rightCenter,
//      FFloatAlignment.rightBottom,
    ];
    const Color mainShadowColor = Color(0x4d3754AA);

    fileMenuList.add("New Finder Window           ⌘N");
    fileMenuList.add("New Smart Folder              ");
    fileMenuList.add("New Tab                              ⌘T");
    fileMenuList.add("Open in New Tab              ^⌘O");
    /// clickList
    clickList.add("Android");
    clickList.add("iOS");
    clickList.add("Flutter");
    clickList.add("Fuchsia");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          new SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: new SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                buildAbsolutePositionDemo(context),
                moreDemo(),
                gradientDemo(),
                cornerDemo()
              ]),
            ),
          )
        ],
      ),
    );
  }

  FFloat cornerDemo() {
    return FFloat(
      (setter) {
        return SizedBox(
          width: 150,
          height: 100,
          child: Column(
            children: [Text('asdasdasd'), Text('asdasdasd'), Text('asdasdasd')],
          ),
        );
      },
      anchor: FButton(
        width: 80,
        height: 40,
        onPressed: () {
          controller4.show();
        },
        text: "Click",
        color: Colors.white,
        padding: EdgeInsets.zero,
        shadowColor: Colors.teal,
        shadowOffset: Offset(1, 1),
        shadowBlur: 5.0,
        image: Icon(
          Icons.arrow_drop_down,
          size: 20,
          color: Colors.blue,
        ),
        imageAlignment: ImageAlignment.right,
      ),
      controller: controller4,
      color: Colors.white,
      corner: FFloatCorner.all(6),
      strokeWidth: 1.0,
      alignment: FFloatAlignment.bottomLeft,
      hideTriangle: true,
      margin: EdgeInsets.only(top: 9),
      padding: EdgeInsets.only(top: 9, bottom: 9),
    );
  }

  FFloat gradientDemo() {
    return FFloat(
      (setter) {
        return Container(
          width: 100,
          height: 100,
        );
      },
      anchor: FButton(
        width: 72,
        height: 30,
        padding: EdgeInsets.all(0),
        color: Color(0xff373737),
        image: Image.asset("assets/image/icon_color.png", width: 18),
        onPressed: () {
          controller5.show();
        },
        hoverColor: Colors.white60.withOpacity(0.3),
      ),
      controller: controller5,
      gradient: SweepGradient(
        colors: [
          Color(0xffE271C0),
          Color(0xffC671EB),
          Color(0xff7673F3),
          Color(0xff8BEBEF),
          Color(0xff93FCA8),
          Color(0xff94FC9D),
          Color(0xffEDF980),
          Color(0xffF0C479),
          Color(0xffE07E77),
        ],
      ),
      corner: FFloatCorner.all(100),
      hideTriangle: true,
      margin: EdgeInsets.only(top: 9),
      alignment: FFloatAlignment.bottomCenter,
      shadowColor: Colors.black38,
      shadowBlur: 3,
      shadowOffset: Offset(3, 2),
    );
  }

  Container moreDemo() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xffe2f1fa),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 5, offset: Offset(5, 5)),
        ],
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            left: 300,
            child: FFloat(
              (_) {
                return Text(
                  "Airpos",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(
                  leftTopCorner: 50,
                  rightTopCorner: 50,
                  leftBottomCorner: 35,
                  rightBottomCorner: 35),
              triangleWidth: 30,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/image/airpos.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 100,
            top: 10,
            child: FFloat(
              (_) {
                return Text(
                  "Apple Tv",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(
                  leftTopCorner: 80,
                  rightTopCorner: 80,
                  leftBottomCorner: 35,
                  rightBottomCorner: 35),
              triangleWidth: 55,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/image/appletv.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 80,
            top: 90,
            child: FFloat(
              (_) {
                return Text(
                  "iPhone",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 10, right: 3),
              corner: FFloatCorner(
                  leftTopCorner: 50,
                  rightTopCorner: 25,
                  leftBottomCorner: 50,
                  rightBottomCorner: 25),
              triangleWidth: 23,
              triangleHeight: 10,
              alignment: FFloatAlignment.leftTop,
              anchor: Image.asset(
                "assets/image/iphone.png",
                width: 80,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 200,
            top: 10,
            child: FFloat(
              (_) {
                return Text(
                  "Switch",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(
                  leftTopCorner: 80,
                  rightTopCorner: 80,
                  leftBottomCorner: 40,
                  rightBottomCorner: 40),
              triangleWidth: 41,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/image/switch.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
          Positioned(
            left: 250,
            top: 100,
            child: FFloat(
              (_) {
                return Text(
                  "Watch",
                  style: TextStyle(color: Colors.white),
                );
              },
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(bottom: 3),
              corner: FFloatCorner(
                  leftTopCorner: 50,
                  rightTopCorner: 80,
                  leftBottomCorner: 50,
                  rightBottomCorner: 80),
              alignment: FFloatAlignment.rightCenter,
              triangleWidth: 19,
              triangleHeight: 10,
              anchor: Image.asset(
                "assets/image/watch.png",
                width: 60,
              ),
              canTouchOutside: false,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildAbsolutePositionDemo(BuildContext context) {
    return GestureDetector(
      child: Text(
        '点击按钮',
        style: TextStyle(
          fontSize: 30,
          backgroundColor: Colors.blue,
          color: Colors.white,
        ),
      ),
      onPanDown: (details) {
        FFloat(
          (setter) => Text(
            "Hello",
            style: TextStyle(color: Colors.white),
          ),
          location:
              Offset(details.globalPosition.dx, details.globalPosition.dy),
          autoDismissDuration: Duration(milliseconds: 2000),
          padding: EdgeInsets.all(6.0),
          corner: FFloatCorner.all(6.0),
          canTouchOutside: false,
          alignment: randomAlignment(),
        ).show(context);
      },
    );
  }

  FFloatAlignment randomAlignment() {
    return alignmentList[Random().nextInt(alignmentList.length)];
  }
}
