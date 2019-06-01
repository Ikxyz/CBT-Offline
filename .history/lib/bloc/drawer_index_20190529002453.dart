import 'dart:async';

import 'package:cbt_offline/import.dart';

class DrawerIndexBloc {
  int currentIndex = 0;

  final _currentIndexStreamController = StreamController<int>();

  Stream<int> get _newCurrentIndexStream =>
      _currentIndexStreamController.stream;

  StreamSink<int> get _newCurrentIndexSink =>
      _currentIndexStreamController.sink;

  DrawerIndexBloc() {
    _newCurrentIndexSin
    _newCurrentIndexStream.listen(_newIndex);
  }

  void _newIndex(int val) {
    if (val == null) return;
    _newCurrentIndexSink.add(val);
  }
}
