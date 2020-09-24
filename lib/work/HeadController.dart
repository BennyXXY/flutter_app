import 'package:ffloat/ffloat.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/work/widget_custom_popup.dart';
import 'package:fradio/fradio.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('SwitchButton'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Head(),
      ),
    ),
  ));
}

class Head extends StatefulWidget {
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
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  FFloatController controller = FFloatController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          showMenuFFloat(),
          widget.bottomLeftHide
              ? _bottomLeftPraiseNum('assets/images/zan.png', widget.praiseNum)
              : Container(),
          widget.bottomRightHide
              ? _bottomRightCup('assets/images/zan.png', widget.cupNum)
              : Container(),
          widget.bottomCenterHide ? _alignCenterName(widget.name) : Container(),
          widget.rightTopHide
              ? _alignTopRight(Icon(Icons.folder_shared))
              : Container(),
          widget.leftTopHide ? _alignTopLeft(Icon(Icons.folder)) : Container()
        ],
      ),
    );
  }

  ///下方悬浮菜单
  FFloat showMenuFFloat() {
    return FFloat(
      (setter) => Container(
          width: widget.width,
          height: widget.height / 2,
          child: Row(
            children: [
              _showRestoration(),
              _showBackUp(),
              _showAllGetOut(),
              _showMore(),
            ],
          )),
      controller: controller,
      alignment: FFloatAlignment.bottomCenter,
      color: Colors.transparent,
      hideTriangle: true,
      anchor: FRadio.custom(
        width: widget.height,
        height: widget.height,
        onChanged: (value) {
          setState(() {});
          controller.show();
        },
        selected: Image.asset('assets/images/head.png'),
      ),
    );
  }

  ///权限菜单按钮
  Widget _showPermission() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '权限',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///奖励
  Widget _showPraise() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '奖励',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///禁音
  Widget _showSoundOff() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '静音',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///更多
  Widget _showMore() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '更多',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///全体下台
  Widget _showAllGetOut() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '全体',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '下台',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///下台
  Widget _showGetOut() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '全体',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///菜单复位按钮
  Widget _showRestoration() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '归为',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        onTap: () {
          print('================aaaa');
          controller.dismiss();
        },
      ),
    );
  }

  ///收回权限按钮
  Widget _showBackUp() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            Icon(Icons.whatshot),
            Text(
              '收回',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '权限',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  ///底部右边奖杯
  Widget _bottomRightCup(String imagePath, int cupNum) {
    return Align(
      alignment: Alignment.bottomRight,
      child: widget.switchFunRight
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
                    width: widget.width / 5,
                    height: widget.width / 5,
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
      child: widget.switchFunLeft
          ? Container(
              child: Row(
                children: [
                  Image.asset(
                    '$imagePath',
                    width: widget.width / 5,
                    height: widget.width / 5,
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
      width: widget.width / 3,
      height: widget.height / 3,
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
      width: widget.width / 3,
      height: widget.height / 3,
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
        height: widget.width / 5,
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
          width: widget.width / 3,
          height: widget.height / 3,
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
          width: widget.width / 3,
          height: widget.height / 3,
          child: GestureDetector(
            child: icon,
            onTap: () {
              print('左上角--------------');
            },
          ),
        ));
  }
}
