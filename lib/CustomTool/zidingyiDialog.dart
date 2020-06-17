import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GenderChooseDialog(),
  ));
}

class GenderChooseDialog extends Dialog {
  GenderChooseDialog({
    Key key,
    this.title,
    @required this.onBoyChooseEvent,
    @required this.onGirlChooseEvent,
  }) : super(key: key);

  var title;
  Function onBoyChooseEvent;
  Function onGirlChooseEvent;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 28.0),
                    child: Center(
                      child: Text(
                        "请选择性别",
                        style: new TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _genderChooseItemWid(1),
                      _genderChooseItemWid(0)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderChooseItemWid(var gender) {
    return GestureDetector(
      onTap: gender == 1 ? onBoyChooseEvent : onGirlChooseEvent,
      child: Column(
        children: <Widget>[
          Image.asset(
            gender == 1
                ? "assets/images/image_family.png"
                : "assets/images/imge_student.png",
            width: 135,
            height: 135,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 40.0),
            child: Text(
              gender == 1 ? "我是男生" : "我是女生",
              style: TextStyle(
                  color: Color(gender == 1 ? 0xff4285f4 : 0xffff4444),
                  fontSize: 15.0),
            ),
          )
        ],
      ),
    );
  }
}
