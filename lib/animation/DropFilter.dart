import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropPage'),
      ),
      body: DropPage(),
    ),
  ));
}

class DropPage extends StatefulWidget {
  @override
  _DropPageState createState() => _DropPageState();
}

class _DropPageState extends State<DropPage> {
  List<String> ll = ['默认排序', '首付最低', '月供最低', '车价最低', '车价最高'];
  List<String> lll = ['11111', '22222', '33333', '44444', '55555'];
  List<String> llll = ['红烧鸡块', '糖醋排骨', '红焖羊肉', '爆炒腰花', '糖醋里脊', '红烧猪头'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              child: ListView.builder(
                //此处类似于一个懒加载
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.favorite_border),
                    title: Text("listview builder"),
                    subtitle: Text("builder"),
                    trailing: Icon(Icons.arrow_forward),
                  );
                },
              ),
          ),
          Container(
            color: Colors.white,
            height: 50,
            child: DropItem(
              buttons: [
                FilterButtonModel(
                    title: '排序',
                    type: 'Row',
                    contents: ll,
                    callback: _callBack(ll)),
                FilterButtonModel(
                    title: '排序',
                    type: 'Row',
                    contents: lll,
                    callback: _callBack(lll)),
                FilterButtonModel(
                    title: '排序',
                    type: 'Row',
                    contents: llll,
                    callback: _callBack(llll))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Function _callBack(List<String> a) {
  for (int i = 0; i < a.length; i++) {
    print('$i========第几个================');
  }
}

class FilterButtonModel {
  String title; //按钮title
  List contents; //下拉列表
  String type; //下拉筛选类型 'Column'、'Row'
  Function callback; //按钮点击回调，可以自定义回调，如跳转页面等
  String direction; //下拉箭头方向
  FilterButtonModel(
      {this.title, this.contents, this.type, this.callback, this.direction});
}

///下拉列表按钮布局
class DropItem extends StatefulWidget {
  final Widget otherWidget;
  final List<FilterButtonModel> buttons;

  const DropItem({Key key, this.otherWidget, this.buttons}) : super(key: key);

  @override
  _DropItemState createState() => _DropItemState();
}

class _DropItemState extends State<DropItem>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  double innerHeigt = 150.0; //下拉高度
  bool isMask = false; //下拉蒙层是否显示i
  FilterButtonModel curButton;
  int curFilterIndex;

  @override
  void initState() {
    super.initState();
    curButton = widget.buttons[0]; //下拉初始化为0
    _animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
    new Tween(begin: 0.0, end: innerHeigt).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  ///按下状态
  void triggerIcon(btn) {
    if (btn.direction == 'up') {
      btn.direction = 'down';
    } else {
      btn.direction = 'up';
    }
  }

  ///改变状态
  void triggerMask() {
    setState(() {
      isMask = !isMask;
    });
  }

  ontap() {
    _animationController.reverse();
    triggerIcon(widget.buttons[curFilterIndex]);
    print('$curFilterIndex==================');
    triggerMask();
  }

  void initButtonState() {
    widget.buttons.forEach((element) {
      setState(() {
        element.direction = 'down';
      });
    });
  }

  void updateData(i) {
    setState(() {
      curButton = widget.buttons[i];
      curFilterIndex = i;
    });
    print(i);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [_button()],
          ),
          _contentList(curButton)
        ],
      ),
    );
  }

  Widget _button() {
    return Row(
      children: List.generate(widget.buttons.length, (i) {
        final thisButton = widget.buttons[i];
        return SizedBox(
          height: 50.0,
          width: MediaQuery
              .of(context)
              .size
              .width / widget.buttons.length,
          child: FlatButton(
            padding: EdgeInsets.only(top: 0, left: 10.0),
            child: Row(
              children: [
                Text(thisButton.title),
                _rotateIcon(thisButton.direction),
              ],
            ),
            onPressed: () {
              if (isMask && i != curFilterIndex) {
                initButtonState();
                triggerIcon(widget.buttons[i]);
                updateData(i);
                return;
              }
              updateData(i);
              if (curButton.callback == null) {
                if (_animation.status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                triggerMask();
              } else {
                curButton.callback();
              }
              triggerIcon(widget.buttons[i]);
            },
          ),
        );
      }),
    );
  }

  ///下拉筛选列表
  Widget _contentList(FilterButtonModel lists) {
    if (lists.contents != null && lists.contents.length > 0) {
      return Positioned(
        width: MediaQuery
            .of(context)
            .size
            .width,
        top: 50,
        left: 0,
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.white,
              height: _animation.value,
              child: _innerConList(lists),
            ),
            _mask()
          ],
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _innerConList(FilterButtonModel lists) {
    if (lists.type == 'Row') {
      setState(() {
        innerHeigt = 50.0 * lists.contents.length;
      });
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        child: Wrap(
          alignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          runSpacing: 15,
          children: List.generate(lists.contents.length, (i) {
            return GestureDetector(
              onTap: ontap,
              child: Container(
                height: 40,
                width: (MediaQuery
                    .of(context)
                    .size
                    .width - 20) / 3,
                child: FlatButton(
                  child: Container(
                    child: Text(lists.contents[i]),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(216, 216, 216, 0.3)),
                  ),
                  onPressed: () {
                    print(i);
                    ontap();
                  },
                ),
              ),
            );
          }),
        ),
      );
    } else {
      setState(() {
        innerHeigt = 50.0 * lists.contents.length;
      });
      return ListView(
        children: List.generate(lists.contents.length, (i) {
          return GestureDetector(
            onTap: ontap,
            child: Container(
              height: 50,
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: Text(lists.contents[i]),
            ),
          );
        }),
      );
    }
  }

  ///筛选的黑色蒙层
  Widget _mask() {
    if (isMask) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Color.fromRGBO(0, 0, 0, 0.5),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  ///右侧旋转箭头组建
  Widget _rotateIcon(direction) {
    if (direction == 'up') {
      return Icon(Icons.keyboard_arrow_up, color: Colors.orange);
    } else {
      return Icon(
        Icons.keyboard_arrow_down,
        color: Colors.orange,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
