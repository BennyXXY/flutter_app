import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FlexDemo(),
  ));
}

const APPBAR_SCROLL_OFFSET = 100;

class FlexDemo extends StatefulWidget {
  @override
  _FlexDemoState createState() => _FlexDemoState();
}

class _FlexDemoState extends State<FlexDemo> {
  double appBarAlpha = 0;
  bool _isLoading = true;
  List list = List();

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafc),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index]),
                        );
                      })),
            ),
            _appBar
          ],
        ),
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(14, 20, 0, 0),
            height: 86.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color:
                      appBarAlpha == 1.0 ? Colors.black12 : Colors.transparent,
                  offset: Offset(2, 3),
                  blurRadius: 6,
                  spreadRadius: 0.6,
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              height: 20,
              color: Colors.blue,
              child: Text('你真哈'),
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  Future<Null> _handleRefresh() async {
    try {
      if (!_isLoading) {
        await Future.delayed(Duration(seconds: 2), () {
          _isLoading = false;
        });
      }
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(20) + 15, (index) => 'item $index'));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        print(e);
        setState(() {
          _isLoading = false;
        });
      });
    }
    return null;
  }
}

///自定义loading样式
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: [child, isLoading ? _loadingView : Container()],
          );
  }
}
