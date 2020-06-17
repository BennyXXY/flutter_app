import 'package:flutter/cupertino.dart';

///State中所有的属性都应该是只读
@immutable
class CountState {
  final int _count;

  CountState(this._count);

  get count => _count;

  CountState.initState() : _count = 0;
}

///定义操作State的Action的属性
//这里只有一个属性
enum ActionType { increment }

///redux会根据新的action 生成countstate
CountState reducer(CountState state, action) {
  //匹配action

  print('$action=====CountState====${ActionType.increment}');
  if (action == ActionType.increment) {
    print('${state.count}===========CountState');
    return CountState(state.count + 1);
  }
  return state;
}
