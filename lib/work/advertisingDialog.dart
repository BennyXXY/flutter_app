import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Scaffold(
      appBar: AppBar(
        title: Text("dialog"),
      ),
      body: AdvertisingDialog(),
    ),
  ));
}

class AdvertisingDialog extends StatefulWidget {
  @override
  _AdvertisingDialogState createState() => _AdvertisingDialogState();
}

class _AdvertisingDialogState extends State<AdvertisingDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return _advertis();
              });
        },
        child: Text("Dialog"),
      ),
    );
  }
}

class _advertis extends StatelessWidget {
  const _advertis({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
            flex: 3,
          ),
          Expanded(
            child: Image.asset(
              "assets/images/image_invite.png",
            ),
            flex: 7,
          ),
          Expanded(
            child: IconButton(
              icon: Image.asset(
                "assets/images/icon_main_add.png",
                width: 150,
                height: 150,
                alignment: Alignment.topCenter,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}
