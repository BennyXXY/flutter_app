import 'package:ffloat/ffloat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/work/widget_custom_popup.dart';

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

  ///头像
  final String iconHead;

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

  ///弹出框的方向， true为下方， false为右边
  final bool direction;

  ///是否借用头像
  final bool userHeader;

  Head(
      {Key key,
      this.iconHead = 'assets/images/head.png',
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
      this.switchFunRight = false,
      this.direction = false,
      this.userHeader = false})
      : super(key: key);

  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  FFloatController controller = FFloatController();
  FFloatController userHeadController = FFloatController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          widget.userHeader
              ? showUserHeadFFloat(widget.direction)
              : showMenuFFloat(widget.direction),
          if (widget.bottomLeftHide)
            _bottomLeftPraiseNum('assets/images/zan.png', widget.praiseNum),
          if (widget.bottomRightHide)
            _bottomRightCup('assets/images/zan.png', widget.cupNum),
          if (widget.bottomCenterHide) _alignCenterName(widget.name),
          if (widget.rightTopHide) _alignTopRight(Icon(Icons.folder_shared)),
          if (widget.leftTopHide) _alignTopLeft(Icon(Icons.folder))
        ],
      ),
    );
  }

  ///下方悬浮菜单
  FFloat showMenuFFloat(bool direction) {
    return FFloat(
      (setter) => Container(
          width: direction ? widget.width : null,
          height: direction ? widget.height / 2 : widget.height,
          child: direction
              ? Row(
                  children: [
                    _showRestoration(direction),
                    _showBackUp(direction),
                    _showAllGetOut(direction),
                    _showMore(direction),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _showRestoration(direction),
                    _showBackUp(direction),
                    _showAllGetOut(direction),
                    _showMore(direction),
                  ],
                )),
      controller: controller,
      alignment: direction
          ? FFloatAlignment.bottomCenter
          : FFloatAlignment.rightCenter,
      color: Colors.transparent,
      hideTriangle: true,
      anchor: IconButton(
        iconSize: widget.width,
        icon: Image.asset(widget.iconHead),
        onPressed: () {
          controller.show();
        },
      ),
    );
  }

  ///借用老师头像
  FFloat showUserHeadFFloat(bool direction) {
    double _minHeadTime = 1;
    double _maxHeadTime = 10;
    double _currentTime = 3;
    return FFloat(
      (setter) => Container(
        width: widget.width,
        height: widget.height - widget.height / 4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text(
              '借用老师头像',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              '设置显示时间（单位：秒）',
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_minHeadTime.toInt()}',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: widget.width - widget.width / 3,
                  height: widget.height / 4,
                  child: Slider(
                    value: _currentTime,
                    label: _currentTime.toInt().toString(),
                    min: 1,
                    max: 10,
                    divisions: 10,
                    activeColor: Colors.greenAccent,
                    inactiveColor: Colors.grey,
                    semanticFormatterCallback: (newValue) {
                      return '${newValue.round()} dollars}';
                    },
                    onChanged: (value) {
                      setState(() {
                        _currentTime = value;
                      });
                    },
                  ),
                ),
                Text(
                  '${_maxHeadTime.toInt()}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: widget.width / 2.8,
                  height: widget.height / 6,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('修改昵称',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black38,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: widget.width / 2.8,
                  height: widget.height / 6,
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text('开启摄像头',
                      style: TextStyle(fontSize: 8, color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
      controller: userHeadController,
      alignment: direction
          ? FFloatAlignment.bottomCenter
          : FFloatAlignment.rightCenter,
      triangleAlignment: TriangleAlignment.center,
      triangleWidth: 20,
      triangleHeight: 10,
      corner: FFloatCorner.all(10),
      strokeColor: Colors.black38,
      anchor: IconButton(
        iconSize: widget.width,
        icon: Image.asset(widget.iconHead),
        onPressed: () {
          userHeadController.show();
        },
      ),
    );
  }

  ///更多
  Widget _showMore(bool direction) {
    final GlobalKey _key = GlobalKey();
    return Container(
      key: _key,
      child: GestureDetector(
          child: direction
              ? Column(
                  children: [
                    Icon(Icons.whatshot),
                    Text(
                      '更多',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Icon(Icons.whatshot),
                    Text(
                      '更多',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
          onTap: () {
            showMoreMenu().show(widgetKey: _key);
          }),
    );
  }

  ///更多按钮弹框
  ShowMoreTextPopup showMoreMenu() {
    return ShowMoreTextPopup(context,
        content: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [_showRollingOver(), _showBeauty()],
          ),
        ),
        width: widget.width / 1.5,
        height: widget.height / 3,
        backgroundColor: Colors.black12,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(10.0));
  }

  ///翻转按钮
  Widget _showRollingOver() {
    return Expanded(
      child: GestureDetector(
          child: Column(
        children: [
          Icon(Icons.whatshot),
          Text(
            '翻转',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      )),
    );
  }

  ///翻转按钮
  Widget _showBeauty() {
    return Expanded(
      child: GestureDetector(
          child: Column(
        children: [
          Icon(Icons.whatshot),
          Text(
            '美颜',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      )),
    );
  }

  ///权限菜单按钮
  Widget _showPermission(bool direction) {
    return GestureDetector(
      child: Expanded(
        child: direction
            ? Column(
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
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '权限',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
      ),
      onTap: () {},
    );
  }

  ///奖励
  Widget _showPraise(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
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
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '奖励',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
      ),
    );
  }

  ///禁音
  Widget _showSoundOff(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
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
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '静音',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
      ),
    );
  }

  ///全体下台
  Widget _showAllGetOut(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
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
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '全体下台',
                    style: TextStyle(fontSize: 10),
                  ),
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
  Widget _showRestoration(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.whatshot,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '归位',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            : Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.whatshot,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '归位',
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
  Widget _showBackUp(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.whatshot,color: Colors.white,),
                  ),
                  Text(
                    '收回',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    '权限',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              )
            : Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.whatshot,color: Colors.white,),
                  ),
                  Text(
                    '收回权限',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
      ),
    );
  }

  ///抢话筒
  Widget _showRobMic(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '抢话筒',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '抢话筒',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
      ),
    );
  }

  ///抢位置
  Widget _showRobLocation(bool direction) {
    return Expanded(
      child: GestureDetector(
        child: direction
            ? Column(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '抢位置',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              )
            : Row(
                children: [
                  Icon(Icons.whatshot),
                  Text(
                    '抢位置',
                    style: TextStyle(fontSize: 10),
                  ),
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
