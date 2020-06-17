
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _userName;
  String _password;

  void _login() {
    var _loginFrom = _globalKey.currentState;
    if (_loginFrom.validate()) {
      _loginFrom.save();
      print("name : $_userName . password : $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(30.0),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: "请输入用户名"),
                        onSaved: (value) {
                          print("$value");
                          _userName = value;
                        },
                        onFieldSubmitted: (value) {
                          print("onFieldSubmitted : $value");
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: "请输入密码"),
                        onSaved: (value) {
                          print("$value");
                          _password = value;
                        },
                        validator: (value) {
                          return value.length < 6 ? "密码长度不够6位" : null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        width: 400,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            _login();
                          },
                          child: new Text("登录"),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
