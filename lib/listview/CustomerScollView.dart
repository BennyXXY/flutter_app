import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CustomerScollViewRoute(),
  ));
}

class CustomerScollViewRoute extends StatefulWidget {
  @override
  _CustomerScollViewRouteState createState() => _CustomerScollViewRouteState();
}

class _CustomerScollViewRouteState extends State<CustomerScollViewRoute> {
  @override
  Widget build(BuildContext context) {
    var _tabs = <String>[];
    _tabs = <String>["Tab 1", "Tab 2", "Tab 3"];
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //头不卡片
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: new Text("Demo"),
              background: Image.asset(
                "assets/images/image_invite.png",
                fit: BoxFit.cover,
              ),
            ),

          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
                delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                }, childCount: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 2)),
          ),
          SliverFixedExtentList(
            itemExtent: 100, //itemz在主轴上的数量
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text("list item $index"),
              );
            }, childCount: 50),
          )
        ],
      ),
    );
  }
}
