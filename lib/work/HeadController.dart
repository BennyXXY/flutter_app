import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('SwitchButton'),
      ),
      body: Head(),
    ),
  ));
}

class Head extends StatelessWidget {
  final double width;
  final double height;

  ///底部左边
  final bool bottomLeftHide;
  final bool switchFunLeft; //true 点赞  false 麦克风
  final int praiseNum; //点赞数

  ///底部右边
  final bool bottomRightHide;
  final bool switchFunRight; //true 奖杯  false 视频
  final int cupNum; //奖杯数

  ///底部名字是否隐藏
  final bool bottomCenterHide;
  final String name;

  ///左上角图标
  final bool leftTopHide;

  ///右上角图标
  final bool rightTopHide;

  Head(
      {Key key,
      this.width = 120,
      this.height = 120,
      this.name = 'Benny asd',
      this.leftTopHide = true,
      this.rightTopHide = true,
      this.bottomCenterHide = true,
      this.bottomLeftHide = true,
      this.switchFunLeft = false,
      this.praiseNum = 10,
      this.bottomRightHide = true,
      this.cupNum = 10,
      this.switchFunRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          IconButton(
            iconSize: width,
            icon: Image.asset('assets/images/head.png'),
            onPressed: () {
              print('点击 iconbutton');
              showMenu(
                  context: context,
                  position:
                      findWidgetPosition(context).shift(Offset(0, height)),
                  items: [
                    PopupMenuItem(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              child: Column(
                                children: [
                                  Icon(Icons.whatshot),
                                  Text(
                                    '归为',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Icon(Icons.whatshot),
                                  Text('归为', style: TextStyle(fontSize: 10))
                                ],
                              ),
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Icon(Icons.whatshot),
                                  Text('归为', style: TextStyle(fontSize: 10))
                                ],
                              ),
                              onTap: () {},
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  Icon(Icons.whatshot),
                                  Text('归为', style: TextStyle(fontSize: 10))
                                ],
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    )
                  ]);
            },
          ),
          bottomLeftHide
              ? _bottomLeftPraiseNum('assets/images/zan.png', praiseNum)
              : Container(),
          bottomRightHide
              ? _bottomRightCup('assets/images/zan.png', cupNum)
              : Container(),
          bottomCenterHide ? _alignCenterName(name) : Container(),
          rightTopHide
              ? _alignTopRight(Icon(Icons.folder_shared))
              : Container(),
          leftTopHide ? _alignTopLeft(Icon(Icons.folder)) : Container()
        ],
      ),
    );
  }

  ///底部右边奖杯
  Widget _bottomRightCup(String imagePath, int cupNum) {
    return Align(
      alignment: Alignment.bottomRight,
      child: switchFunRight
          ? Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$cupNum',
                    style: TextStyle(fontSize: 10),
                  ),
                  Image.asset(
                    '$imagePath',
                    width: width / 5,
                    height: width / 5,
                  ),
                ],
              ),
            )
          : _bottomVideoContainer(Icon(Icons.videocam)),
    );
  }

  ///底部左边点赞
  Widget _bottomLeftPraiseNum(String imagePath, int praiseNum) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: switchFunLeft
          ? Container(
              child: Row(
                children: [
                  Image.asset(
                    '$imagePath',
                    width: width / 5,
                    height: width / 5,
                  ),
                  Text(
                    '$praiseNum',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            )
          : _bottomMicContainer(Icon(Icons.mic)),
    );
  }

  ///底部麦克风
  Widget _bottomMicContainer(Icon icon) {
    return Container(
      width: width / 3,
      height: height / 3,
      child: GestureDetector(
        child: icon,
        onTap: () {
          print('麦克风-------------');
        },
      ),
    );
  }

  ///底部右下角视频按钮
  Widget _bottomVideoContainer(Icon icon) {
    return Container(
      width: width / 3,
      height: height / 3,
      child: GestureDetector(
        child: icon,
        onTap: () {
          print('视频------------------');
        },
      ),
    );
  }

  ///底部中间名字
  Widget _alignCenterName(String name) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: width / 5,
        alignment: Alignment.center,
        child: Text(
          '$name',
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  ///右上角按钮
  Widget _alignTopRight(Icon icon) {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          width: width / 3,
          height: height / 3,
          child: GestureDetector(
            child: icon,
            onTap: () {
              print('右上角-----------');
            },
          ),
        ));
  }

  ///左上角按钮
  Widget _alignTopLeft(Icon icon) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: width / 3,
          height: height / 3,
          child: GestureDetector(
            child: icon,
            onTap: () {
              print('左上角--------------');
            },
          ),
        ));
  }
}

RelativeRect findWidgetPosition(BuildContext context) {
  final RenderBox button = context.findRenderObject();
  final RenderBox overlay = Overlay.of(context).context.findRenderObject();
  return RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
}
