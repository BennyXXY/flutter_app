import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: SettingDemo(),
    ),
  ));
}

class _SettingItem extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String title;
  final Widget suffix; //可以填写尾缀布局

  const _SettingItem(
      {Key key, this.iconData, this.iconColor, this.title, this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Icon(
            iconData,
            color: iconColor,
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(child: Text('$title')),
          suffix,
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}

///消息尾椎样式
class _NotificationsText extends StatelessWidget {
  final String text;

  const _NotificationsText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.red,
      ),
      child: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _Suffix extends StatelessWidget {
  final String text;

  const _Suffix({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(color: Colors.grey.withOpacity(.5)),
    );
  }
}

class SettingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingItem(
          iconColor: Colors.blue,
          iconData: Icons.notifications,
          title: '消息中心',
          suffix: _NotificationsText(
            text: '2',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.thumb_up,
          iconColor: Colors.green,
          title: '我赞过的',
          suffix: _Suffix(
            text: '121篇',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.grade,
          iconColor: Colors.yellow,
          title: '收藏集',
          suffix: _Suffix(
            text: '2个',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.shopping_basket,
          iconColor: Colors.yellow,
          title: '已购小册',
          suffix: _Suffix(
            text: '100个',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.account_balance_wallet,
          iconColor: Colors.blue,
          title: '我的钱包',
          suffix: _Suffix(
            text: '10万',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.location_on,
          iconColor: Colors.grey,
          title: '阅读过的文章',
          suffix: _Suffix(
            text: '1034篇',
          ),
        ),
        Divider(),
        _SettingItem(
          iconData: Icons.local_offer,
          iconColor: Colors.grey,
          title: '标签管理',
          suffix: _Suffix(
            text: '27个',
          ),
        ),
      ],
    );
  }
}
