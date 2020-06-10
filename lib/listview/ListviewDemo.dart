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
          title: Text("listview"),
        ),
        // body: _Horizontal(),
        body: ListView.builder(//此处类似于一个懒加载
            itemCount: 100,
            itemBuilder: (context, index) {
              print("$index");
              if(index.isOdd){
                return Divider(color: Colors.red,);
              }
              return ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text("listview builder$index"),
                subtitle: Text("builder"),
                trailing: Icon(Icons.arrow_forward),
              );
            }),
      ),
    );
  }

  ListView _ListTitleView() {
    return new ListView(
      children: <Widget>[
        ListTile(
          title: Text("我是一个胖子单身狗"),
          leading: Icon(Icons.favorite),
          trailing: Icon(Icons.arrow_forward),
          subtitle: Text("收没人要的女人"),
        ),
        Divider(
          color: Colors.red,
        ),
      ],
    );
  }
}

class _Horizontal extends StatelessWidget {
  const _Horizontal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal, //横向滑动
      children: List.generate(100, (index) {
        return Text("我是一棵松");
      }),
    );
  }
}
