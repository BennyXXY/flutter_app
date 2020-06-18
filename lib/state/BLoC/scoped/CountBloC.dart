import 'dart:async';

class CountBloC {
  int _count;
  StreamController<int> _streamController;

  //初始化流
  CountBloC() {
    _count = 0;
    _streamController = StreamController<int>.broadcast();
  }

  //流的出口
  Stream<int> get stream => _streamController.stream;

  int get value => _count;

  //流的入口
  increment() {
    _streamController.sink.add(++_count);
  }

  dispose() {
    _streamController.close();
  }
}
