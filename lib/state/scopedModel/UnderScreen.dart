import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/state/scopedModel/CountModel.dart';
import 'package:scoped_model/scoped_model.dart';

class UnderScreens extends StatefulWidget {
  final String title;

  const UnderScreens({Key key, this.title}) : super(key: key);

  @override
  _UnderScreensState createState() => _UnderScreensState();
}

class _UnderScreensState extends State<UnderScreens> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
      builder: (contexy, child, model) {
        return Scaffold(

          appBar: new AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('这个按钮你已经按了好几次'),
                Text(
                  '${model.count}',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.increment();
            },
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),
        );
      },
    );
  }
}
