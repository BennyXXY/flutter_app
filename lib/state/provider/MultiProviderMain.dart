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
        ChangeNotifierProvider<BannerModel>(create: (context) => BannerModel()),
        ChangeNotifierProvider<ListModel>(create: (context) => ListModel())
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
                BannerModel _model = Provider.of<BannerModel>(context);
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text('当前Banner有几个：${_model.counter}'),
                );
              }),
              //获取provider提供出来的值
              Consumer<ListModel>(builder: (context, model, child) {
                return Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text('当前Banner有几个：${model.counter}'),
                );
              }),
              Consumer<BannerModel>(builder: (context, model, child) {
                return FlatButton(
                  color: Colors.amber,
                  onPressed: model.getBanner,
                  child: Text('获取banner'),
                );
              }),
              Consumer<ListModel>(builder: (context, model, child) {
                return FlatButton(
                  color: Colors.deepOrange,
                  onPressed: model.getList,
                  child: Text('获取List'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class BannerModel with ChangeNotifier {
  int counter = 0;

  Future<void> getBanner() async {
    await Future.delayed(Duration(seconds: 2));
    counter++;
    notifyListeners();
    print(counter);
  }
}

class ListModel with ChangeNotifier {
  int counter = 0;

  Future<void> getList() async {
    await Future.delayed(Duration(seconds: 2));
    counter++;
    notifyListeners();
    print(counter);
  }
}
