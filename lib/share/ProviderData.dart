import 'package:flutter/cupertino.dart';

class ChangeNotifierProviders<T extends ChangeNotifiers>
    extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProviders({
    Key key,
    this.data,
    this.child,
  });

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
    //如使用此处代码，由于子树ChangeNotifierProvider.of，依赖于InheritedWidget，
    // 所以后面model变化子widget树会被重构，从而按钮控件会被从新构建，所以按钮每次都会被从新构建影响性能
//    final provider =
//        context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();

    //调用dependOnInheritedWidgetOfExactType() 和
    // getElementForInheritedWidgetOfExactType()的区别就是前者会构建依赖，而后者不会构建依赖。
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget
    as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProvider<T> createState() => _ChangeNotifierProvider<T>();
}

class _ChangeNotifierProvider<T extends ChangeNotifiers>
    extends State<ChangeNotifierProviders<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProviders<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

//创建监听观察者以用来监视是否状态发生变化
class ChangeNotifiers extends Listenable {
  List listeners = [];

  @override
  void addListener(listener) {
    //添加监听
    listeners.add(listener);
  }

  @override
  void removeListener(listener) {
    //移除监听
    listeners.remove(listener);
  }

  void notifyListener() {
    //通知所有监听器，触发监听回调
    listeners.forEach((item) => item());
  }
}

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    print("${old.data}");
    return true;
  }
}
