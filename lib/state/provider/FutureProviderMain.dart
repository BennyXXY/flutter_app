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
    return FutureProvider(
      initialData: MyModel(counter: 0),
      create: (context) => someAsyncFunctionToGetMyModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('provider'),
          ),
          body: Column(
            children: [
              Builder(builder: (context) {
                //获取provider提供的值
                MyModel _model = Provider.of<MyModel>(context);
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text('当前是：${_model.counter}'),
                );
              }),
              //获取provider提供出来的值
              Consumer<MyModel>(builder: (context, model, child) {
                //获取provider提供的值
                MyModel _model = Provider.of<MyModel>(context);
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text('${model.counter}'),
                );
              }),
              Consumer<MyModel>(builder: (context, model, child) {
                return FlatButton(
                  color: Colors.amber,
                  onPressed: model.incrementCounter,
                  child: Icon(Icons.add),
                );
              })
            ],
          ),
        ) ,
      ),
    );
  }

  Future<MyModel> someAsyncFunctionToGetMyModel() async {

    //  <--- async function
    await Future.delayed(Duration(seconds: 3));
    return MyModel(counter: 1);
  }
}

class MyModel with ChangeNotifier {
  MyModel({this.counter = 0});

  int counter = 0;

  Future<void> incrementCounter() async {
    await Future.delayed(Duration(seconds: 2));
    counter++;
    print(counter);
    notifyListeners();
  }
}
