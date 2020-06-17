import 'package:flutter/material.dart';
import 'package:flutterapp/state/scopedModel/CountModel.dart';
import 'package:flutterapp/state/scopedModel/UnderScreen.dart';
import 'package:scoped_model/scoped_model.dart';


class TopScreens extends StatefulWidget {
  @override
  _TopScreensState createState() => _TopScreensState();
}

class _TopScreensState extends State<TopScreens> {
  //静态获取model用法实例
  Model getModel(BuildContext context) {
    ///两种方式均能调用
    //直接使用of
    final countModel = ScopedModel.of<CountModel>(context);
    //使用countmodel中重写的of
    final countModel2 = CountModel().of(context);

    countModel.increment();
    countModel2.increment();
    return countModel;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ScopedModel'),
          ),
          body: Center(
            child: Text(
              model.count.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UnderScreens(
                  title: 'under screen',
                );
              }));
            },
            child: Icon(Icons.forward),
          ),
        );
      },
    );
  }
}
