import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MaterialAPP",
        routes: {
          "/other": (BuildContext context) {
            return OtherPage();
          }
        },
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _wigetOptions = [
    Text("信息"),
    Text("发现"),
    Text("朋友圈"),
    Text("我"),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MaterialAPP"),
        centerTitle: true,
        leading: Icon(Icons.star),
        elevation: 0.0,
        //阴影
        actions: <Widget>[Icon(Icons.search), Icon(Icons.more_vert)],
      ),
      body: Center(child: _wigetOptions.elementAt(_currentIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/other");
        },
        tooltip: "这是路由",
        foregroundColor: Colors.red,
        backgroundColor: Colors.amber,
        elevation: 0.7,
        child: Icon(Icons.accessibility),
        // shape: RoundedRectangleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("信息")),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_b_and_w), title: Text("发现")),
          BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly), title: Text("朋友圈")),
          BottomNavigationBarItem(icon: Icon(Icons.memory), title: Text("我")),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        //抽屉
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("demo"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/17.jpg"),
              ),
              accountEmail: new Text("163@qq.com"),
              otherAccountsPictures: <Widget>[Icon(Icons.camera_alt)],
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/tzd.jpg"),
                    fit: BoxFit.fill),
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: new Text("会员特权"),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: new Text("会员特权"),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: new Text("会员特权"),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: new Text("会员特权"),
            ),
            AboutListTile(
              icon: Icon(Icons.error),
              child: Text("关于"),
              applicationName: "哈哈哈",
              applicationVersion:" 1.0",
            )
          ],
        ),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Otherpage"),
      ),
    );
  }
}
