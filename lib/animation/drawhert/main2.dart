import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/services.dart';
/**
 * GestureDetector 处理手势
 */
// ignore: argument_type_not_assignable
void main() {
  /**
   * Center控件使其子控件在�?间位�?
   * Text控件显示各�?�文�?
   * runApp函数将根控件显示在屏幕上
   */
  runApp(new MaterialApp(
    title: "我的应用",
    home: new MyButton(),
  ));
}

class MyButton extends StatelessWidget {
 
var map = Map();

  @override
  Widget build(BuildContext context) {
    //GestureDetector并不具有显示效果，��是棢�测由用户做出的手�?(点击拖动和缩�?)
    return new GestureDetector(
      //发生点击事件后回�?
      onTap: () {
        print("点击了屏�?");
      },
      //这里�?手指按下的时候调用�?�函数，该函数会传��一个deatil包含坐标信息的参�?
      onTapDown: (detail){

        print(detail.globalPosition.dx);
        print(detail.globalPosition.dy);
        map[detail.globalPosition.dx as String]= detail.globalPosition.dy as String; 
        // list.add(new MyPainter());
        //在这里添加组件，并重新绘制界�?
      },
      //发生双击时间后回�?
      onDoubleTap: (){
        print("双击了屏�?");
      },
  //长按事件
      onLongPress: (){
        print("长按屏幕");
      },
      child: new Container(
        child:  Column(
          children: <Widget>[
            CustomPaint( painter:MyPainter(map) ,),
          ],
        ),
        height: 36.0,
        padding: const EdgeInsets.all(0.0),
        //上下左右都偏�?8像素边距
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        //symmetric的参数是�?选的 水平方向
//        背景装饰
        decoration: new BoxDecoration(
          //圆�?�和颜色
        borderRadius: new BorderRadius.circular(5.0),
            color: Colors.white),
   
      ),
    );
  }
}


class MyPainter extends CustomPainter{
  var map ;
  MyPainter(this.map);
  Path _path = Path();
    @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
  ..color = Colors.red
  ..strokeCap = StrokeCap.round 
  ..isAntiAlias = true 
  ..strokeWidth = 15.0; 

    _paint.style = PaintingStyle.stroke; // 画线模式
    _path.addArc(new Rect.fromLTWH(50, 50, 50, 50), 135.0 * (pi / 180.0), 225.0 * (pi / 180.0));
    _path.addArc(new Rect.fromLTWH(100, 50, 50, 50), 180.0 * (pi / 180.0), 225.0 * (pi / 180.0));
    _path.lineTo(100, 140);
    _path.lineTo(58, 93);
    canvas.drawPath(_path, _paint);

    _path.addArc(new Rect.fromLTWH(50, 50, 50, 50), 135.0 * (pi / 180.0), 225.0 * (pi / 180.0));
    _path.addArc(new Rect.fromLTWH(100, 50, 50, 50), 180.0 * (pi / 180.0), 225.0 * (pi / 180.0));
    _path.lineTo(100, 140);
    _path.lineTo(58, 93);
    canvas.drawPath(_path, _paint);
    // ui.Image image = Icon(Icons.menu) as ui.Image;
    // canvas.drawImage(image, new Offset(0, 0), _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
  Future<ui.Image> imageFromFilePath(String filePath) async {
  var byteData = await rootBundle.load(filePath);
  Uint8List lst = Uint8List.view(byteData.buffer);
  var codec = await ui.instantiateImageCodec(lst);
  var nextFrame = await codec.getNextFrame();
  return nextFrame.image;
}
}




















// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'MaterialApp',
//       //�?由功能，也就�?指定�?由�?�应的页�?，相当与android�?的activity
//       routes: {
//           '/other':(BuildContext context) => OtherPage()
//       },
//       //万事万物都是组件，这里将组件抽取出来写成丢��?�?
//       home: HomePage(),
//     );
//   }
// }
// //创建HomePage继承StatefulWidget
// class HomePage extends StatefulWidget{
//   /**
//    * 这�?�代码表示的�?的重写createState方法，返回指定类型的参数，这里我�?将它展开�?以这样看
   
//        @override
//       _HomePageSTate  createState(){
//            return  _HomePageSTate();
//       }
//       如果�?这样你能看得懂么，我相信没问题，就是抽取出来了��已
//    */
//    @override
//   _HomePageSTate  createState() => _HomePageSTate();
// }

// class _HomePageSTate extends State<HomePage>{
//   int _currentIndex = 0;
//   final _widgetOptions = [
//     Text("信息"),
//     Text("通�??�?"),
//     Text('发现'),
//     Text('我的'),
//   ];
//   //这个方法�?必须要实现的
//     @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar:AppBar(
//         title: Text("MaterialApp实例"),//标�??
//         leading: Icon(Icons.backspace), //设置图标
//         elevation: 0.0, //阴影
//         actions: <Widget>[
//           Icon(Icons.search),
//           Icon(Icons.more_vert),
//         ],
//       ) ,
//       body: Center(
//         //这里相当于时从集合中根据index获取数据
//         child: _widgetOptions.elementAt(_currentIndex),

//       ),
//       //这个时悬�?的按�?
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.pushNamed(context, '/other');
//         },
//         tooltip: '�?由跳�?',
//         foregroundColor: Color(0xffffffff),
//         backgroundColor: Color(0xff000000),
//         //阴影
//         elevation: 0.0,
//         child:Icon(Icons.arrow_forward),
//         //        shape: RoundedRectangleBorder(),
//       ),
//       //�?�?按钮的显示位�?
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       //这个时底部�?�航�?
//       bottomNavigationBar: BottomNavigationBar(
//         items:[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             title: Text('信息')
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.contacts),
//             title: Text('通�??�?'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.near_me),
//             title: Text('发现'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             title: Text("我的")
//           ),
//         ],
//         //默�?�的选项卡的点击条目
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         //选项卡的点击事件
//         // onTap: (index){
//         //   setState(() {
//         //    _currentIndex =index; 
//         //   });
//         // },
//       ),
//     );
//   }
// }
// class OtherPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OtherPage'),
//       ),
//     );
//   }
// }
