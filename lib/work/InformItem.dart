import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: InformItems(),
    ),
  ));
}

class InformItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _Items(),
        Divider(),
        _Items(),
        Divider(),
        _Items(),
      ],
    );
  }
}

class _Items extends StatelessWidget {
  const _Items({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(10)),
            child: Image.asset(
              "assets/images/image_invite.png",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,bottom: 5,left: 10),
            child: Text(
              "邀请有礼 见者有份",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,bottom: 10),
            child: Text(
              "2020年05月20日   15： 36",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black12,
              ),
            ),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.black12,
            height: 1,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                child: Text(
                  "查看详情",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
              Spacer(),
              Icon(Icons.chevron_right,color: Colors.black12,)
            ],
          )
        ],
      ),
    );
  }
}
