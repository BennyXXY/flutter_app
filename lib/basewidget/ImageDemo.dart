import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("assets/images/image_invite.png");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: new Text("Image fix属性"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.contain"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.cover"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.fill"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.fitHeight"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),     Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.fitWidth"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.none,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.none"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),     Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: img,
                                width: 150,
                                height: 150,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Container(
                              child: Text("BoxFit.scaleDown"),
                            )
                          ],
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
