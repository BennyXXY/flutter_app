import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ClickAddNumDemo(),
  ));
}

class ClickAddNumDemo extends StatefulWidget {
  @override
  _ClickAddNumDemoState createState() => _ClickAddNumDemoState();
}

class _ClickAddNumDemoState extends State<ClickAddNumDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TestTime(),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  return ++count;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class _TestTime extends StatefulWidget {
  @override
  __TestTimeState createState() => __TestTimeState();
}

class __TestTimeState extends State<_TestTime> {
  @override
  Widget build(BuildContext context) {
    //使用inheritedWidget共享的数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    //父组件inheritedWidget被改变（updateShouldNotify返回true）时会被调用
    //如果build中没有依赖inheritedwidget 则此回调不会被调用
    super.didChangeDependencies();
    print("Dependencise change===============================");
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data; //在子树中保存的数据，点击计数

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  //定义一个边界方法，方便子树中的widget获取数据
  static ShareDataWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ShareDataWidget>(); //此处就是传值方法
  }

  //该回调决定当data发生回调时，是否通知子树中依赖data的widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    //如果返回true 则子树中依赖本widget 的子widget的state.didChangeDependencies会被调用
    return oldWidget.data != data;
  }
}
