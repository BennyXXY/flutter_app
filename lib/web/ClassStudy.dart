import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('课外学习'),
          centerTitle: true,
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          // 内容
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(2.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    Container(
                      child: Column(
                        children: [EditorPartly(), _submitButton()],
                      ),
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

///提交按钮
Widget _submitButton() {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, top: 30),
    width: double.infinity,
    height: 50,
    child: FlatButton(
      color: Colors.teal[300],
      shape: StadiumBorder(),
      child: Text(
        '提交',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      onPressed: () {},
    ),
  );
}

///编辑器部分
class EditorPartly extends StatefulWidget {
  @override
  _EditorPartlyState createState() => _EditorPartlyState();
}

class _EditorPartlyState extends State<EditorPartly> {
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: PopMenuMsg()),
              SizedBox(
                width: 1,
                height: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              Expanded(
                flex: 4,
                child: InputMsg,
              )
            ],
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          Container(
            child: TextField(
              maxLines: 30,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  hintText: '最多可输入1000个字',
                  border: InputBorder.none),
              onChanged: (value) {
                _inputText = value;
              },
            ),
          ),
          Spacer(),
          Row(
            children: [
              _EditorTool(
                iconDatas: Icons.mic_none,
                title: '录音',
              ),
              _EditorTool(
                iconDatas: Icons.picture_in_picture,
                title: '图片',
              ),
              _EditorTool(
                iconDatas: Icons.video_library,
                title: '视频',
              ),
              _EditorTool(
                iconDatas: Icons.insert_drive_file,
                title: '文件',
              ),
              _EditorTool(
                iconDatas: Icons.notifications_none,
                title: '微课',
              ),
              _EditorTool(
                iconDatas: Icons.link,
                title: '链接',
              ),
            ],
          )
        ],
      ),
    );
  }

  ///课程输入部分
  Container get InputMsg {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: TextField(
        decoration: InputDecoration(
          hintMaxLines: 1,
          hintText: '时间+课程名称（可修改）',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          _inputText = value;
        },
      ),
    );
  }
}

///标签选择
class PopMenuMsg extends StatefulWidget {
  @override
  PopMenuMsgState createState() => PopMenuMsgState();
}

class PopMenuMsgState extends State<PopMenuMsg> {
  String _bodyText = '作业';

  Widget _ItemBuild(IconData iconData, String title, value) {
    return PopupMenuItem<String>(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(iconData),
          new Text(title),
        ],
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    return PopupMenuButton(
      onSelected: (String value) {
        switch (value) {
          case '1':
            text = '作业';
            break;
          case '2':
            text = '留言';
            break;
          case '3':
            text = '讨论';
            break;
        }
        setState(() {
          _bodyText = text;
        });
      },
      offset: Offset(10, 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('$_bodyText'), Icon(Icons.expand_more)],
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _ItemBuild(Icons.library_books, '作业', '1'),
        _ItemBuild(Icons.library_books, '留言', '2'),
        _ItemBuild(Icons.library_books, '讨论', '3'),
      ],
    );
  }
}

///底部功能按钮
class _EditorTool extends StatelessWidget {
  const _EditorTool({Key key, this.iconDatas, this.title}) : super(key: key);
  final IconData iconDatas;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, bottom: 20),
      child: Column(
        children: [
          Icon(
            iconDatas,
            size: 30,
          ),
          Text(title),
        ],
      ),
    );
  }
}
