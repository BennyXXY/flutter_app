import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('柱状图'),
      ),
      body: CylinderChart(),
    ),
  ));
}

//制作坐标系
class _Axis extends StatelessWidget {
  final Widget child;

  const _Axis({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2))),
      child: child,
    );
  }
}

//单个柱状图
class _Cylinder extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;

  const _Cylinder({Key key, this.width, this.height, this.color, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: height,
      width: width,
      color: color,
      child: Text(
        '$text',
      ),
    );
  }
}

class CylinderChart extends StatefulWidget {
  @override
  _CylinderChartState createState() => _CylinderChartState();
}

class _CylinderChartState extends State<CylinderChart> {
  final double _width = 20.0;
  List<double> _heightList = [60.0, 80.0, 100.0, 120.0, 140.0];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 250,
        child: Stack(
          children: [
            _Axis(),
            Positioned.fill(
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(_heightList.length, (index) {
                  return _Cylinder(
                    height: _heightList[index],
                    width: _width,
                    color: Colors.primaries[index % Colors.primaries.length],
                    text: _heightList[index].toString(),
                  );
                }),
              ),
            ),
            Positioned(
              top: 0,
              left: 30,
              child: OutlineButton(
                child: Text('反转'),
                onPressed: () {
                  setState(() {
                    _heightList = _heightList.reversed.toList();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
