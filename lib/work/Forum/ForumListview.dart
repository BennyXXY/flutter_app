import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DetailsMessage.dart';
import 'ForumMode.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DemoAppState();
  }
}

class _DemoAppState extends State<DemoApp> {
  ScrollController _controller = new ScrollController();
  List _items = new List<FMode>();
  var _mPage = 0;

  @override
  void initState() {
    super.initState();
    getData();
    //给_controller添加监听
    _controller.addListener(() {
      //判断是否滑动到了页面的最底部
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        //如果不是最后一页数据，则生成新的数据添加到list里面
        if (_mPage < 4) {
          _retrieveData();
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ListView Demo',
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('ListView Demo'),
          ),
          body: Container(
            child: getRefreshMessage(),
          )),
    );
  }

  ///下拉刷新
  Widget getRefreshMessage() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: new ListView.separated(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            //判断是否构建到了最后一条item
            if (index == _items.length) {
              //判断是不是最后一页
              if (_mPage < 4) {
                //不是最后一页，返回一个loading窗
                return new Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                //是最后一页，显示我是有底线的
                return new Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: new Text(
                    '我是有底线的!!!',
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageInfo()));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.amber,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text('一个无趣的问题'),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Image.asset(
                                    "assets/image/tzd.jpg",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/image/tzd.jpg",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/image/tzd.jpg",
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              );
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '12',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('耗时大约12小时'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          //分割线构造器
          separatorBuilder: (context, index) {
            return new Divider(
              color: Colors.blue,
            );
          },
          //_items.length + 1是为了给最后一行的加载loading留出位置
          itemCount: _items.length + 1),
    );
  }

  void getData() {
    //初始数据源
    for (int i = 0; i < 20; i++) {
      FMode fMode = new FMode();
      fMode.title = '1+1=?';
      fMode.answerTime = 'day';

      _items.add(fMode);
      print(_items[i]);
    }
  }

  void _retrieveData() {
    //上拉加载新的数据
    _mPage++;
    Future.delayed(Duration(seconds: 2)).then((e) {
      for (int i = 0; i < 20; i++) {
        FMode fMode = new FMode();
        fMode.title = '1+1=?';
        fMode.answerTime = 'day';

        _items.insert(_items.length, fMode);
        _items.insert(_items.length, fMode);
      }
      setState(() {});
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _mPage = 0;
        _items.clear();
        for (int i = 0; i < 20; i++) {
          FMode fMode = new FMode();
          fMode.title = '1+1=?';
          fMode.answerTime = 'day';

          _items.insert(_items.length, fMode);
          _items.insert(_items.length, fMode);
        }
      });
    });
  }

  @override
  void dispose() {
    //移除监听，防止内存泄漏
    _controller.dispose();
    super.dispose();
  }
}
