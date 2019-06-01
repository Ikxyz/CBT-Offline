import 'dart:async';

import 'package:cbt_offline/import.dart';

class DrawerIndexBloc {
  final _currentIndexStreamController = StreamController<int>();

  Stream<int> get newCurrentIndexStream =>
      _currentIndexStreamController.stream;

  StreamSink<int> get newCurrentIndexSink =>
      _currentIndexStreamController.sink;

  DrawerIndexBloc() {
    _newCurrentIndexSink.add(0);
    _newCurrentIndexStream.listen(_newIndex);
  }

  void _newIndex(int val) {
    if (val == null) return;
    _newCurrentIndexSink.add(val);
  }

  void dispose() {
    _currentIndexStreamController.close();
  }
}
