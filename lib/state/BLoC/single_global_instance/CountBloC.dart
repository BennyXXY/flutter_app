import 'dart:async';

class CountBloC {
  int _count = 0;

  var _streamController = StreamController<int>.broadcast();

  Stream<int> get stream => _streamController.stream;

  int get value => _count;

  increment() {
    _streamController.sink.add(++_count);
  }

  dispose() {
    _streamController.close();
  }
}

CountBloC bLoC = CountBloC();
