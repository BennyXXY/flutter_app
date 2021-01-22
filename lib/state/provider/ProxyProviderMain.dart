import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PicModel>(create: (context) => PicModel()),
        ProxyProvider<PicModel, SubmitModel>(
            update: (context, myModel, antherModel) => SubmitModel(myModel))
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('provider'),
          ),
          body: Column(
            children: [
              Builder(builder: (context) {
                //获取provider提供的值
                PicModel _model = Provider.of<PicModel>(context);
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text('提交图片：${_model.counter}'),
                );
              }),

              Consumer<PicModel>(builder: (context, model, child) {
                return FlatButton(
                  color: Colors.amber,
                  onPressed: model.upLoadPic,
                  child: Text('提交图片'),
                );
              }),
              Consumer<SubmitModel>(builder: (context, model, child) {
                return FlatButton(
                  color: Colors.deepOrange,
                  onPressed: model.subMit,
                  child: Text('提交'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class PicModel with ChangeNotifier {
  int counter = 0;

  Future<void> upLoadPic() async {
    await Future.delayed(Duration(seconds: 2));
    counter++;
    notifyListeners();
    print(counter);
  }
}

class SubmitModel {
  PicModel _model;

  SubmitModel(this._model);

  Future<void> subMit() async {
    await _model.upLoadPic();
  }
}
