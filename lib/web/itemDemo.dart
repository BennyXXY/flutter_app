import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ItemHomePage(),
  ));
}

class ItemHomePage extends StatefulWidget {
  @override
  _ItemHomePageState createState() => _ItemHomePageState();
}

class _ItemHomePageState extends State<ItemHomePage> {
  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Add HeaderView'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Container(
                height: 100,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    color: Colors.grey[300],
                    shape: StadiumBorder(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.insert_chart),
                        Text(
                          '创建课外学习...',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                )),
          ),
          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate(_buildListItem, childCount: 18),
              itemExtent: 48.0),
        ],
      ),
    );
  }
}
