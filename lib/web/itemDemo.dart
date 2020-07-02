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
          SizedBox(
            height: 10,
          ),
          _user,
          SizedBox(
            height: 10,
          ),
          _content,
          _bottomTool,
          Divider(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  ///用户头像行
  Widget get _user => Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/image/head.png'),
            radius: 20.0,
          ),
          Container(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('努力让梦想成为现时'),
              Row(
                children: [
                  Text(
                    '人气值25w',
                    style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                  ),
                  Container(
                    height: 10,
                    child: VerticalDivider(
                      color: Colors.grey[400],
                      width: 20,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    '22小时前',
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.more_horiz,
            size: 20,
            color: Colors.grey[400],
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  ///富文本显示区
  Widget get _content => Container(
        width: double.infinity,
        height: 100,
        color: Colors.blue,
      );

  ///底部工具栏
  Widget get _bottomTool => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton.icon(
              onPressed: null, icon: Icon(Icons.share), label: Text('')),
          FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.library_books),
              label: Text('40')),
          FlatButton.icon(
              onPressed: null, icon: Icon(Icons.thumb_up), label: Text('40'))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Add HeaderView'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          listHeader(),
          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          SliverList(
            delegate:
                SliverChildBuilderDelegate(_buildListItem, childCount: 18),
          ),
        ],
      ),
    );
  }

  ///课外学习按钮
  SliverToBoxAdapter listHeader() {
    return SliverToBoxAdapter(
      child: Container(
          height: 100,
          child: Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
            width: double.infinity,
            height: 40,
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
    );
  }
}
