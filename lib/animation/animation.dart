import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ScaleAnimationRoute(),
    ),
  ));
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    //AnimationController是一个动画控制器，duration是该动画的持续事件，vsync是当前上下文的TickerProvider
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    //使用弹性曲线
    //animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片高度从0到300
    animation = new Tween(begin: 100.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {//如果结束
        controller.reverse();//朝反向运动
      } else if (status == AnimationStatus.dismissed) {//如果动画没开始就结束
        controller.forward();//从新开始正向运动
      }
    });

    //启动动画正向
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //return AnimatedImage(animation: animation);
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset(
        "assets/images/imge_student.png",
      ),
      builder: (BuildContext context, Widget child) {
        return new Center(
          child: Container(
            width: animation.value,
            height: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    //结束时销毁资源
    controller.dispose();
    super.dispose();
  }
}

//分离Widget
class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset(
        "assets/images/imge_student.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}
