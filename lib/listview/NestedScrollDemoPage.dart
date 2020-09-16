import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NestedScollDemo(),
  ));
}

class NestedScollDemo extends StatefulWidget {
  @override
  _NestedScollDemoState createState() => _NestedScollDemoState();
}

class _NestedScollDemoState extends State<NestedScollDemo> {
  final _tabs = <String>["TabA", "TabB"];
  final colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  title: Text('NestedScroll Demo'),
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset('assets/images/image_invite.png',
                          fit: BoxFit.cover)),
                  bottom: TabBar(
                      tabs: _tabs
                          .map((tab) =>
                              Text(tab, style: TextStyle(fontSize: 18.0)))
                          .toList()),
                  forceElevated: innerScrolled,
                ),
              )
            ];
          },
          body: TabBarView(
              children: _tabs
                  .map((e) => Builder(
                        builder: (context) {
                          return CustomScrollView(
                            key: PageStorageKey<String>(e),
                            slivers: <Widget>[
                              SliverOverlapInjector(
                                handle: NestedScrollView
                                    .sliverOverlapAbsorberHandleFor(context),
                              ),
                              SliverGrid(
                                delegate:
                                    SliverChildBuilderDelegate((_, index) {
                                  return Image.asset("assets/images/head.png");
                                }, childCount: 8),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0),
                              ),
                              SliverFixedExtentList(
                                delegate:
                                    SliverChildBuilderDelegate((_, index) {
                                  return Container(
                                    child: Text(
                                      "$e - item${index + 1}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: colors[index % 6]),
                                    ),
                                    alignment: Alignment.center,
                                  );
                                }, childCount: 15),
                                itemExtent: 50,
                              )
                            ],
                          );
                        },
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
