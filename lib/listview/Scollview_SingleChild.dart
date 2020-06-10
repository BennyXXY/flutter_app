import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: infinteListView(),
  ));
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    Widget divider1 = Divider(
//      color: Colors.deepOrange,
//    );
//    Widget divider2 = Divider(
//      color: Colors.lightBlue,
//    );
//    return MaterialApp(
//      home: Scaffold(
////        body: Scrollbar( // 显示进度条
////          child: SingleChildScrollView(
////            padding: EdgeInsets.all(16.0),
////            child: Center(
////              child: Column(
////                //动态创建一个List<Widget>
////                children: str.split("")
////                //每一个字母都用一个Text显示,字体为原来的两倍
////                    .map((c) => Text(c, textScaleFactor: 2.0,))
////                    .toList(),
////              ),
////            ),
////          ),
////        ),
//
////      body: new ListView(
////        shrinkWrap: true,
////        padding: const EdgeInsets.all(20),
////        children: <Widget>[
////          const Text('I\'m dedicating every day to you'),
////          const Text('Domestic life was never quite my style'),
////          const Text('When you smile, you knock me out, I fall apart'),
////          const Text('And I thought I was so smart'),
////        ],
////      ),
//
////        body: ListView.builder(
//////          itemCount: 20,//item子项个数
//////          itemExtent: 50,//item子项的强制高度
//////          itemBuilder: (BuildContext context, int index) {
//////            return ListTile(
//////              title: new Text("$index"),
//////            );
//////          },
//////        ),
////        body: ListView.separated(
////            itemBuilder: (BuildContext context, int index) {
////              return ListTile(
////                title: Text("$index"),
////              );
////            },
////            separatorBuilder: (BuildContext context, int index) {
////              return index % 2 == 0 ? divider1 : divider2;
////            },
////            itemCount: 20),
//      ),
//    );
//  }
//}

//无限下拉
class infinteListView extends StatefulWidget {
  @override
  _infinteListViewState createState() => _infinteListViewState();
}

class _infinteListViewState extends State<infinteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _wors = <String>[loadingTag];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveDate();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("ListView"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("字母列表"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 24 - 56 - 56,
            child: ListView.separated(
              itemCount: _wors.length,
              itemBuilder: (BuildContext context, int index) {
                if (_wors[index] == loadingTag) {
                  //如果到了队尾
                  if (_wors.length - 1 < 100) {
                    _retrieveDate();
                    return Container(
                      padding: new EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          //进度指示器
                          strokeWidth: 2.0,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          border: new Border.all(color: Colors.lightBlue)),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "没有更多了",
                        style:
                            new TextStyle(color: Colors.black26, fontSize: 20),
                      ),
                    );
                  }
                }
                return ListTile(
                  title: Text(_wors[index]),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 1.0),
            ),
          )
        ],
      ),
    );
  }

  void _retrieveDate() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _wors.insertAll(
            _wors.length - 1,
            generateWordPairs()
                .take(10)
                .map((e) => e.asPascalCase)
                .toList()); //每次生成20个单词
      });
    });
  }
}
