import 'dart:async';

class SimpleBloc<T> {
  final _streamController = StreamController<T>();

  Stream<T> get stream => _streamController.stream;

  void add(T object) {
    _streamController.add(object);
  }

  void addError(Object erro) {

    if ( _streamController.isClosed ) {
      _streamController.addError(erro);
    }
   
  }

  void dispose() {
    _streamController.close();
  }
}
