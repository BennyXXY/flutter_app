import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProviderData.dart';

void main() {
  runApp(MaterialApp(
    home: ProviderRoute(),
  ));
}

//定义商品类
class Item {
  Item(this.price, this.count);

  double price;
  int count;
}

class CarModel extends ChangeNotifiers {
  //定义商品集合表
  final List<Item> _items = [];

  //禁止改变购物车里的商品
  UnmodifiableListView get items => UnmodifiableListView(items);

  //购物车中商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //将 item 添加到购物车，这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    print("${_items.length}");
    //通知监听器（订阅者）重新构建InheritedProvider,更新状态
    notifyListener();
  }
}

//构建便捷类获取数据
class Customer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Customer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  builder(context,ChangeNotifierProviders.of(context));
  }
}

class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProviders<CarModel>(
        data: CarModel(),
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Builder(builder: (context) {
//                var cart = ChangeNotifierProviders.of<CarModel>(context);
//                return Text("总价: ${cart.totalPrice}");
//              }),
              Customer<CarModel>(
                builder: (context, cart) => Text("总价: ${cart.totalPrice}"),
              ),
              Builder(builder: (context) {
                print("RaisedButton build"); //在后面优化部分会用到
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    ChangeNotifierProviders.of<CarModel>(context,listen: true)
                        .add(Item(20.0, 1));
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
