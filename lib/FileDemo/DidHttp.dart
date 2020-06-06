import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Dio"),
      ),
      body: FutureBuilderRouteState(),
    ),
  ));
}

class FutureBuilderRouteState extends StatefulWidget {
  @override
  _FutureBuilderRouteStateState createState() =>
      _FutureBuilderRouteStateState();
}

class _FutureBuilderRouteStateState extends State<FutureBuilderRouteState> {
  Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return ListView(
              children: response.data
                  .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
