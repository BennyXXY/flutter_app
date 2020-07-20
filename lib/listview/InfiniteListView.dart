import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/CustomTool/RoundnessSchedul.dart';
import 'package:flutterapp/listview/k/AnimatedRotationBox.dart';
import 'package:flutterapp/listview/k/InfiniteListViewtool.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('上拉加载下拉刷新'),
      ),
      body: RefresMoreItems(),
    ),
  ));
}

class RefresMoreItems extends StatefulWidget {
  @override
  _RefresMoreItemsState createState() => _RefresMoreItemsState();
}

class _RefresMoreItemsState extends State<RefresMoreItems> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<int>(
      headerBuilder: (list, context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('下刷新和加载'),
        );
      },
      itemBuilder: (List list, int index, BuildContext context) {
        return ListTile(title: Text("${list[index]}"));
      },
      onRetrieveData: (int page, List items, bool refresh) {
        return Future.delayed(Duration(seconds: 2), () {
          int start = _current;
          if (refresh) {
            _current = start = 0;
            items.clear();
          }
          if (_current == 50) return false; //最多加载50
          while (start++ < _current + 10) {
            items.add(start);
          }
          _current += 10;
          return true;
        });
      },
      loadingBuilder: (context) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedRotationBox(
                duration: Duration(milliseconds: 800),
                child: GradientCircularProgressIndicator(
                  radius: 10.0,
                  colors: [Colors.blue, Colors.lightBlue[50]],
                  value: .8,
                  backgroundColor: Colors.transparent,
                  strokeCapRound: true,
                ),
              ),
              Text("  加载更多...")
            ],
          ),
        );
      },
      noMoreViewBuilder: (list, context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text('共${list.length}条', style: TextStyle(color: Colors.grey)),
          ),
        );
      },
    );
  }
}
