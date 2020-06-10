import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GridViews(),
  ));
}

class GridViews extends StatefulWidget {
  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridViews> {
  @override
  Widget build(BuildContext context) {
    List<String> datas = getDataList();
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
//      body: GridView.count(
//        //一行item的个数
//        crossAxisCount: 2,
//        crossAxisSpacing: 10.0,
//        //水平widge的间距
//        mainAxisSpacing: 30.0,
//        //竖直widge的间距
//        padding: EdgeInsets.all(10.0),
//        //子widge的宽高比
//        childAspectRatio: 3.0,
//        children: getWeightList(),
//      ),

//      body: GridView.builder(
//          itemCount: datas.length,
////          //构建了一个横轴固定的gridview
////          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
////              crossAxisCount: 3, //item的数量
////              mainAxisSpacing: 20, //纵轴间距
////              crossAxisSpacing: 10, //横轴间距
////              childAspectRatio: 2 //子组件宽高比例
////              ),
//
//          //构建了一个根据屏幕宽度自动设定item横向数量的grdiview
//          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//              //单个widge水平最大宽度
//              maxCrossAxisExtent: 200,
//              //水平widge之间的宽度
//              mainAxisSpacing: 20.0,
//              crossAxisSpacing: 10,
//              //子元素宽高比
//              childAspectRatio: 1),
//          itemBuilder: (BuildContext context, int index) {
//            return getItemContainer(datas[index]);
//          }),

      body: GridView.custom(//创建委托型
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 20),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            return getItemContainer(datas[index]);
          }, childCount: datas.length)),
    );
  }

  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 100; i++) {
      list.add(i.toString());
    }
    return list;
  }

  List<Widget> getWeightList() {
    return getDataList().map((e) => getItemContainer(e)).toList();
  }

  Widget getItemContainer(String item) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        item,
        style: new TextStyle(color: Colors.yellow, fontSize: 20),
      ),
      color: Colors.deepOrange,
    );
  }
}
