import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("自定义按钮"),
      ),
      body: GradientButtonRoute(),
    ),
  ));
}

class GradientButtonRoute extends StatefulWidget {
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.red, Colors.amber],
            height: 50,
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green[700]],
            height: 50,
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            height: 50,
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  onTap() {
    print("click");
  }
}

class GradientButton extends StatelessWidget {
  final List<Color> colors;
  final double height;
  final double width;
  final Widget child;
  final BorderRadius borderRadius;
  final GestureTapCallback onPressed;

  const GradientButton(
      {Key key,
      this.colors,
      this.height,
      this.width,
      this.borderRadius,
      this.onPressed,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //获取主题信息
    ThemeData theme = Theme.of(context);
    //确保color不能为空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors), //设置装饰盒子的渐变
        borderRadius: borderRadius,
      ),
      child: Material(
        //创建一个子材料
        type: MaterialType.transparency, //type:显示材料种类，其值为一种透明材料，可以画出墨水飞溅的高光
        child: InkWell(
          splashColor: _colors.last,
          //墨水飞溅效果变化到集合最后一个元素
          highlightColor: Colors.transparent,
          //按下按钮的颜色
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            //对子控件添加束缚
            constraints: BoxConstraints.tightFor(height: height, width: width),
            //创建一个给定宽高的约束框子
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  //创建默认文本样式
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
