
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true; //打开不局线
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("ImageDemo"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              //加载网络图片
              Image.network(
                "https://dss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1-66368c33f8.png",
                width: 100,
                height: 100,
              ),
              //加载assets
              Image.asset(
                "assets/image/tzd.jpg",
                width: 200,
                height: 100,
              ),
              //Memory
              MemoryImageWidge(),
              //从文件加载图片
              _AddFileImage()
            ],
          ),
        ),
      ),
    );
  }
}




class _AddFileImage extends StatefulWidget {
  @override
  __AddFileImageState createState() => __AddFileImageState();
}

class __AddFileImageState extends State<_AddFileImage> {
  File _image;

  Future addImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: _image == null
              ? Text("未选择图片")
              : Image.file(
                  _image,
                  width: 150,
                  height: 150,
                ),
        ),
        FlatButton(
          onPressed: addImage,
          child: Text("选择图片"),
          color: Colors.blueAccent,
        )
      ],
    );
  }
}

//从内存加载图片
class MemoryImageWidge extends StatefulWidget {
  @override
  _MemoryImageWidgeState createState() => _MemoryImageWidgeState();
}

class _MemoryImageWidgeState extends State<MemoryImageWidge> {
  Uint8List bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load("assets/image/tzd.jpg").then((value) {
      if (mounted) {
        setState(() {
          bytes = value.buffer.asUint8List();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
        image:
            bytes == null ? null : DecorationImage(image: MemoryImage(bytes)));
    return Container(
      width: 200,
      height: 200,
      decoration: _decoration,
    );
  }
}
