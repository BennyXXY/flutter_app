import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyAPP(),
  ));
}

class MyAPP extends StatefulWidget {
  @override
  _MyAPPState createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  @override
  Widget build(BuildContext context) {
    var _tabs = <String>[];
    _tabs = <String>["Tab 1", "Tab 2", "Tab 3"];
    return Scaffold(
        body: DefaultTabController(//此部件时创建tab的最底层控制器
      length: _tabs.length,
      child: NestedScrollView(//创建滚动视图
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: new IconButton(
                    icon: Icon(Icons.arrow_back), onPressed: () {}),
                title: const Text("标题"),
                centerTitle: false,
                pinned: true,
                floating: false,
                snap: false,
                primary: true,
                expandedHeight: 250.0,
                elevation: 10,
                forceElevated: innerBoxScrolled,
                actions: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        print("更多");
                      })
                ],
                flexibleSpace: new FlexibleSpaceBar(//创建一个灵活的卡片布局
                  background: Image.asset(
                    "assets/images/image_invite.png",
                    fit: BoxFit.fill,
                  ),
                ),
                bottom: TabBar(
                    tabs: _tabs
                        .map((name) => Tab(
                              text: name,
                            ))
                        .toList()),
              ),
            )
          ];
        },
        body: TabBarView(
            children: _tabs.map((e) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(e),//数据存贮
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: SliverFixedExtentList(
                      itemExtent: 50.0,
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return ListTile(
                          title: new Text("item $index"),
                        );
                      }, childCount: 20),
                    ),
                  )
                ],
              );
            }),
          );
        }).toList()),
      ),

    ),);
  }
}
