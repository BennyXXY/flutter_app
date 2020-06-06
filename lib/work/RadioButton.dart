

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("支付页面"),
      ),
      body: Container(
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //选中支付项
  int groupValue = 0;
  bool flag = true;
  bool wxFlag=true;
  bool payFlag=false;

  //支付金额集合
  final List<RadioMode> payAmountList = [
    RadioMode("30元", ""),
    RadioMode("30元", "(送5元)"),
    RadioMode("200元", "(送10元)"),
    RadioMode("300元", "(送30元)"),
    RadioMode("500元", "(送100元)"),
    RadioMode("1000元", "(送300元)")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              "- 余额充值 -",
              style: TextStyle(color: Colors.black87, fontSize: 13),
            ),
          ),
          buildGridView(),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              "- 支付方式 -",
              style: TextStyle(color: Colors.black87, fontSize: 13),
            ),
          ),
          ListTile(
            leading: Icon(Icons.four_k),
            title: Text("微信"),
            trailing: Container(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: wxFlag
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.teal,
                      )
                    : Icon(
                        Icons.radio_button_unchecked,
                      ),
                onPressed: () {
                  setState(
                    () {
                      if (wxFlag) {
                        wxFlag=false;
                        payFlag = true;
                      } else {
                        wxFlag = true;
                        payFlag=false;
                      }
                    },
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.four_k),
            title: Text("支付宝"),
            trailing: Container(
              child: FlatButton(

                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: payFlag
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.teal,
                      )
                    : Icon(
                        Icons.radio_button_unchecked,
                      ),
                onPressed: () {
                  setState(
                    () {
                      if (payFlag) {
                        wxFlag = true;
                        payFlag=false;
                      } else {
                        wxFlag=false;
                        payFlag = true;
                      }
                    },
                  );
                },
              ),
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Colors.teal, ),
            child: FlatButton(
              child: Text("立即充值",style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
          )
        ],
      ),
    ));
  }

  GridView buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15.0,
        childAspectRatio: 1 / 0.5,
        // 上下间隔
        mainAxisSpacing: 15.0,
      ),
      itemBuilder: (context, index) => _buildItem(index),
      itemCount: payAmountList.length,
    );
  }

  Widget _buildItem(int index) {
    bool _isSelected = groupValue == index;
    Color colorChange = _isSelected ? Colors.white : Colors.teal;
    RadioMode _radioMode = payAmountList[index];
    return FlatButton(
      color: _isSelected ? Colors.teal : Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _radioMode.title,
            style: TextStyle(color: colorChange, fontSize: 15),
          ),
          Text(
            _radioMode.present,
            style: TextStyle(color: colorChange, fontSize: 10),
          )
        ],
      ),
      shape: new RoundedRectangleBorder(
        side: new BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        setState(() {
          groupValue = index;
        });
      },
    );
  }
}

//支付model
class RadioMode {
  final String title;
  final String present;

  RadioMode(this.title, this.present);
}
