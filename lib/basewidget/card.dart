import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "card",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CardDemo"),
        leading: Icon(Icons.payment),
      ),
      body: ListView(
        children: <Widget>[
          _buildCard(),
          _buildCard(),
          _buildCard(),
        ],
      ),
    );
  }
}

class _buildCard extends StatelessWidget {
  const _buildCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(100))
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/image/tzd.jpg",
              width: double.infinity,
              height: 50,
              fit: BoxFit.cover,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Icon(Icons.home),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "刚刚的",
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "200",
                      style: new TextStyle(fontSize: 12.0),
                    )
                  ],
                )),
                Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.lightGreen,
                      ),
                      Text("55")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
