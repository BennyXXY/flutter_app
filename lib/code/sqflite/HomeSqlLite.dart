import 'package:flutter/material.dart';
import 'package:flutterapp/code/sqflite/User.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter SqlLite'),
      ),
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlLite sqlLite = SqlLite();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ListView(
        children: [
          RaisedButton(
            child: Text('增加数据'),
            onPressed: _insertData,
          ),
          RaisedButton(
            child: Text('删除数据'),
            onPressed: _deleteData,
          ),
          RaisedButton(
            child: Text('修改数据'),
            onPressed: _queryData,
          ),
          RaisedButton(
            child: Text('查询数据'),
            onPressed: _queryAll,
          )
        ],
      ),
    );
  }

  ///插入数据
  void _insertData() async {
    await sqlLite.openSqlLite();
    User u1 = User();
    u1.userId = 101;
    u1.name = "镜花水月1";
    u1.age = 31;
    u1.sex = '男';
    await sqlLite.insert(u1);
    User u2 = User();
    u2.userId = 102;
    u2.name = "镜花水月2";
    u2.age = 32;
    u2.sex = '女';
    await sqlLite.insert(u2);
    await sqlLite.close();
  }

  void _deleteData() async {
    await sqlLite.openSqlLite();
    await sqlLite.delete(101);
    await sqlLite.close();
  }

  Future _queryData() async {
    await sqlLite.openSqlLite();
    User user = await sqlLite.getUser(101);
    if (user != null) {
      user.name = 'flutter';
      await sqlLite.update(user);
    }
    await sqlLite.close();
  }

  void _queryAll() async {
    await sqlLite.openSqlLite();
    List<User> users = await sqlLite.queryAll();
    if (users != null) {
      print(users);
    }
    await sqlLite.close();
  }
}
