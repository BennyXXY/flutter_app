import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: Text('红包弹窗'),
        ),
        body: show()),
  ));
}

class show extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('自定义dialog'),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return dolahsefask();
            });
      },
    );
  }
}

/**
 * 自定义dialog
 */


class dolahsefask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 400,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/image_invite.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              right: 1,
              top: 1,
              child: FlatButton(
                child: IconButton(
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 80,
              child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: Text(
                    '666.00',
                    style: TextStyle(fontSize: 26, color: Colors.red),
                  )),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                alignment: Alignment.center,
                width: 300,
                child: FlatButton(
                  child: IconButton(
                    iconSize: 60,
                    icon: Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomizeDialog extends Dialog {
  CustomizeDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300,
      height: 400,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/image_invite.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 1,
            top: 1,
            child: FlatButton(
              child: IconButton(
                icon: Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 80,
            child: Container(
                alignment: Alignment.center,
                width: 300,
                child: Text(
                  '666.00',
                  style: TextStyle(fontSize: 26, color: Colors.red),
                )),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              alignment: Alignment.center,
              width: 300,
              child: FlatButton(
                child: IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
