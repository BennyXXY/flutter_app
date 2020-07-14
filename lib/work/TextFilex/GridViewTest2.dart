import 'package:flutter/material.dart';
import 'package:flutterapp/work/TextFilex/JhBottomSheet.dart';
import 'package:flutterapp/work/TextFilex/JhNinePictureTool.dart';

void main() {
  runApp(MaterialApp(home: GridViewTest2()));
}

List<String> dataArr;
List<String> dataArr2;

List getData() {
  dataArr = new List();
  for (int i = 0; i < 9; i++) {
    var img;
    if (i % 2 == 0) {
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei2.png";
    } else {
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    }
    dataArr.add(img);
  }
  return dataArr;
}

List getData2() {
  dataArr2 = new List();
  for (int i = 0; i < 4; i++) {
    var img;
    if (i % 2 == 0) {
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei2.png";
    } else {
      img = "https://gitee.com/iotjh/Picture/raw/master/lufei.png";
    }
    dataArr2.add(img);
  }
  return dataArr2;
}

class GridViewTest2 extends StatefulWidget {
  @override
  _GridViewTest2State createState() => _GridViewTest2State();
}

class _GridViewTest2State extends State<GridViewTest2> {
  @override
  void initState() {
    super.initState();
    getData();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView实现朋友圈效果（九宫格）'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('九宫格'),
            Container(
              padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
              color: Colors.blue,
              child: JhNinePictureTool(
                imgData: dataArr,
                lfPaddingSpace: 110,
                onLongPress: () {
                  JhBottomSheet.showText(context, '轮播', dataArr, '轮播按钮',
                      (selectIndex, selectText) {});
                },
              ),
            ),
            Text("九宫格2"),
            Container(
                padding: EdgeInsets.fromLTRB(80, 10, 30, 10),
                color: Colors.blue,
                child: JhNinePictureTool(
                  imgData: dataArr2,
                  lfPaddingSpace: 110,
                  onLongPress: () {
                    JhBottomSheet.showText(context, '九宫', dataArr, '九宫格',
                        (selectIndex, selectText) {});
                  },
                )),
          ],
        ),
      ),
    );
  }
}
