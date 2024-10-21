import 'dart:async';

class StreamStore<T> {
  final _streamController = StreamController<T>.broadcast();
  T _value;

  Stream<T> get stream => _streamController.stream;

  T get value => _value;

  void set value(T value) {
    _value = value;
    _streamController.add(_value);
  }

  StreamStore(T value) : _value = value;
}
