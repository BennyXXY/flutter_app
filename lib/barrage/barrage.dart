import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'barrage_transition.dart';

//des
const Duration _kDuration = Duration(seconds: 10);

class Barrage extends StatefulWidget {
  ///显示行数
  final int showCount;

  ///弹幕填充
  final double padding;

  ///偏移量
  final int randomOffset;

  const Barrage(
      {Key key, this.showCount = 10, this.padding = 5, this.randomOffset = 0})
      : super(key: key);

  @override
  BarrageState createState() => BarrageState();
}

class BarrageState extends State<Barrage> {
  //弹幕列表
  List<_BarrageTransitionItem> _barrageList = [];

  ///定时清楚弹幕
  Timer _timer;
  Random _random = Random();
  double _height;
  double _width;
  int barrageIndex = 0;

  //添加弹幕
  addBarrage(Widget child, {Duration duration = _kDuration}) {
    double perRowHeight = (_height - 2 * widget.padding) / widget.showCount;
    //计算距离顶部偏移量
    //不直接使用_barrage.length的原因：弹幕结束会删除列表中的此项，如果此时正好有一个弹幕来袭，
    //会造成此弹幕何上一个弹幕同行
    var index = 0;
    if (_barrageList.length == 0) {
      //屏幕中没有弹幕，从顶部开始
      index = 0;
      barrageIndex++;
    } else {
      index = barrageIndex++;
    }
    var top = _computeTop(index, perRowHeight);
    if (barrageIndex > 100000) {
      barrageIndex = 0;
    }
    var bottom = _height - top - perRowHeight;
    String id = '${DateTime.now().toIso8601String()}:${_random.nextInt(1000)}';
    var item = _BarrageTransitionItem(
      id: id,
      top: top,
      bottom: bottom,
      child: child,
      onComplete: _onComplete,
      duration: duration,
    );
    _barrageList.add(item);
    setState(() {});
  }

  //动画执行完毕删除
  _onComplete(id) {
    //动画执行完毕删除
    _barrageList.removeWhere((element) => element.id == id);
  }

  //计算每一行的顶部便宜量，将显示的弹幕分为showCount 份，
  //如果此弹幕比 showCount 多，第二轮显示在两个 111111中间 ，如下
  //  111111111
  //          22222222
  //  111111111111
  //        222222222
  _computeTop(int index, double perRowHeight) {
    //第几轮弹幕
    int num = (index / widget.showCount).floor();
    var top;
    top = (index % widget.showCount) * perRowHeight + widget.padding;
    if (num % 2 == 1 && index % widget.showCount != widget.showCount - 1) {
      top += perRowHeight / 2;
    }
    if (widget.randomOffset != 0 && top > widget.randomOffset) {
      top += _random.nextInt(widget.randomOffset) * 2 - widget.randomOffset;
    }
    return top;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _barrageList.clear();
    super.dispose();
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _barrageList.removeWhere((element) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraintType) {
      _height = constraintType.maxHeight;
      _width = constraintType.maxWidth;
      return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Stack(
          children: []..addAll(_barrageList),
        ),
      );
    });
  }
}

class _BarrageTransitionItem extends StatelessWidget {
  _BarrageTransitionItem(
      {this.id,
      this.top,
      this.bottom,
      this.onComplete,
      this.duration,
      this.child});

  //每条弹幕id
  final String id;

  //弹幕的位置
  final double top;
  final double bottom;

  //弹幕内容
  final Widget child;

  //值变化回调
  final ValueChanged onComplete;

  //计数器
  final Duration duration;
  var _key = GlobalKey<BarrageTransitionState>();

  bool get isComplete => _key.currentState.isComplete;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: top,
      bottom: bottom,
      child: BarrageTransition(
        key: _key,
        child: child,
        onComplete: (v) {
          onComplete(id);
        },
        duration: duration,
      ),
    );
  }
}
