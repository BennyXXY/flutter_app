import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: GoodsListPage(),
    ),
  ));
}

class GoodsListPage extends StatefulWidget {
  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  GlobalKey _key = new GlobalKey();
  Offset _endOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //获取购车位置
      _endOffset = (_key.currentContext.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "我的商品$index",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            var _overlayEntry = OverlayEntry(builder: (_) {
                              RenderBox box = context.findRenderObject();
                              var offset = box.localToGlobal(Offset.zero);//将子widget的宽高转化为全局坐标系，如果父容器非空，子widget给定的点转化为坐标系的父容器更新
                              return RedDotPage(
                                startPosition: offset,
                                endPosition: _endOffset,
                              );
                            });
                            Overlay.of(context).insert(_overlayEntry);
                            Future.delayed(Duration(milliseconds: 800), () {
                              _overlayEntry.remove();
                              _overlayEntry = null;
                            });
                          });
                    })
                  ],
                ),
              );
            },
            itemCount: 100,
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Icon(Icons.shopping_cart),
                key: _key,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//贝塞尔动画曲线
class RedDotPage extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;

  const RedDotPage({Key key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  _RedDotPageState createState() => _RedDotPageState();
}

class _RedDotPageState extends State<RedDotPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; // 动画 controller
  Animation<double> _animation; // 动画
  double left; // 小圆点的left（动态计算）
  double top; // 小远点的right（动态计算）

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    //贝塞尔曲线
    var x0 = widget.startPosition.dx;
    var y0 = widget.startPosition.dy;

    var x1 = widget.startPosition.dx -300;
    var y1 = widget.startPosition.dy -200;

    var x2 = widget.endPosition.dx;
    var y2 = widget.endPosition.dy;

    _animation.addListener(() {
      //动态 t 变化值
      var t = _animation.value;
      if (mounted) {
        setState(() {
          left = pow(1 - t, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0 + 2 * t * (1 - t) * y1 + pow(t, 2) * y2;
        });
      }
    });

    //初始化小圆点位置
    left = widget.startPosition.dx;
    top = widget.startPosition.dy;

    //小圆点开始
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          top: top,
          child: ClipOval(
            child: Container(
              width: 14,
              height: 14,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
