import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:flutter/rendering.dart';

const Icon _unlike = Icon(IconData(0xe60a, fontFamily: "appIconFonts"));
const Icon _like = Icon(IconData(0xe60c, fontFamily: "appIconFonts"));

class Like extends StatefulWidget {
  Like({this.like=false});
  bool like;


  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> with SingleTickerProviderStateMixin {
  AnimationController _animationController; //一个动画控制器，里面有好多相关的操作
  Animation _iconAnimation; //创建一个动画，参数自己定义
  Animation _circleAnimation;


  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this); //此处vsync和SingleTickerProviderStateMixin一起使用，具体好像是将一个动画列队合并
    _iconAnimation = Tween(begin: 1.0, end: 1.3).animate(
        _animationController); //Tween是一个补间动画，开始1秒 结束1.3秒 将动画交给父容器
    _iconAnimation = TweenSequence([ //创建一个构造序列 动画执行列队
      TweenSequenceItem( //执行列队中一个
          tween: Tween(begin: 1.0, end: 1.3).chain(
              CurveTween(curve: Curves.easeIn)),
          weight: 50
      ),
      TweenSequenceItem(
          tween: Tween(begin: 1.3, end: 1.0), weight: 50
      )
    ]).animate(_animationController);
    _circleAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_animationController); //圆环扩散葱花
  }

  _clickIcon() {
    if (_iconAnimation.status == AnimationStatus.forward ||
        _iconAnimation.status ==
            AnimationStatus.reverse) { //动画从头到为都在播放，或是从后往前播放都停止
      return;
    }
    setState(() {
      widget.like = !widget.like;
    });
    if (_iconAnimation.status == AnimationStatus.dismissed) { //如果动画一开始就停止
      _animationController.forward(); //执行到最后
    } else {
      _animationController.reverse(); //反向运行此动画
    }
  }

  //建立手点击事件和图标
  _buildLikeIcon() {
    return ScaleTransition(
      scale: _iconAnimation,
      child: widget.like ?
      IconButton(
        padding: EdgeInsets.all(0),
        icon: _like,
        onPressed: (){
          _clickIcon();
        },
      ):IconButton(
        padding: EdgeInsets.all(0),
        icon: _unlike,
        onPressed: (){
          _clickIcon();
        },
      )
    );
  }

  //构建圆环
  _buildCricle(){
    return !widget.like?
        Container():
        AnimatedBuilder(
          animation: _circleAnimation,
          builder: (BuildContext context,Widget child){
            return Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,//在圆圈边渐变
                  border: Border.all(
                      color: Color(0xFF5FA0EC)
                          .withOpacity(_circleAnimation.value),
                      width: _circleAnimation.value * 8)),
            );
          },
        );
  }

  _buildCirclePoints() {
    return Flow(//创建一个布局流
      delegate: CirclePointFlowDelegate(),//控制子元素的转换委托。就是将动画的变化效果放入一个布局流委托中，在将委托放如布局流中
      children: <Widget>[
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
        _buildCirclePoint(2, Color(0xFF97B1CE)),
        _buildCirclePoint(5, Color(0xFF4AC6B7)),
      ],
    );
  }

  //构建圆环外的点
  _buildCirclePoint(double radius, Color color) {
    return !widget.like
        ? Container()
        : AnimatedBuilder(
      animation: _circleAnimation,
      builder: (BuildContext context, Widget child) {
        return Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(_circleAnimation.value)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled=false;
    debugPrint("_like${widget.like}");//调试参数首选
    //debugDumpRenderTree();
   // debugDumpLayerTree();
    return Stack(
      children: <Widget>[
        _buildCirclePoints(),
        Positioned.fill(
            left: 20, top: 20, right: 20, bottom: 20, child: _buildCricle()),
        Positioned.fill(child: _buildLikeIcon()),
      ],
    );
  }
}

class CirclePointFlowDelegate extends FlowDelegate {//FlowDelegate是一个布局流委托，内部可以带一个Animation，主要是Animation在此基础上构建，避免重新建造Animation。效率更高
  CirclePointFlowDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {//FlowPaintingContext绘制上下文
    var radius = min(context.size.width, context.size.height) / 2.0;//找到中心坐标
    //中心点
    double rx = radius;
    double ry = radius;
    for (int i = 0; i < context.childCount; i++) {
      if (i % 2 == 0) {
        double x =
            rx + (radius - 5) * cos(i * 2 * pi / (context.childCount - 1));
        double y =
            ry + (radius - 5) * sin(i * 2 * pi / (context.childCount - 1));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      } else {
        double x = rx +
            (radius - 5) *
                cos((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        double y = ry +
            (radius - 5) *
                sin((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
