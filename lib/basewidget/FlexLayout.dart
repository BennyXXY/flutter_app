import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("弹性布局Flex"),
          ),
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(0.0),
                sliver: new SliverList(
                    delegate: new SliverChildListDelegate(<Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Expanded(
                                child: _Wrap(),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.grey,
                                ),
                                flex: 1,
                              ),
//                              Spacer(
//                                flex: 2,
//
//                              ),
                              Expanded(
                                child: Container(
                                  child: Flow(
                                    delegate: TestFlowDelegate(
                                        margin: EdgeInsets.all(10.0)),
                                    children: <Widget>[
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.red,
                                      ),
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.green,
                                      ),
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.blue,
                                      ),
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.yellow,
                                      ),
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.brown,
                                      ),
                                      new Container(
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.purple,
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.amberAccent,
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                          height: 1000,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              color: Colors.lightBlue,
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              color: Colors.amber,
                            ))
                      ],
                    ),
                  ),
                ])),
              )
            ],
          )),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 100.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class _layout extends StatelessWidget {
  const _layout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: _Wrap(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                      ),
                      flex: 1,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amberAccent,
                      ),
                      flex: 1,
                    )
                  ],
                ),
                height: 600,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    color: Colors.lightBlue,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    color: Colors.amber,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _Wrap extends StatelessWidget {
  const _Wrap({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, //主轴水平方向间距
      runSpacing: 4.0, //纵轴水平方向间距
      alignment: WrapAlignment.center, //延主轴方向剧中
      children: <Widget>[
        Chip(
          label: new Text("语文"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.deepOrange,
            child: Text("Y"),
          ),
        ),
        Chip(
          label: new Text("数学"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("S"),
          ),
        ),
        Chip(
          label: new Text("英语"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("Y"),
          ),
        ),
        Chip(
          label: new Text("政治"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("Z"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
        Chip(
          label: new Text("地理"),
          avatar: new CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text("D"),
          ),
        ),
      ],
    );
  }
}
