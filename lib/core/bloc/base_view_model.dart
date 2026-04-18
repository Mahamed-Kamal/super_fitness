import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseViewModel<T, I, E> extends Cubit<T> {
  BaseViewModel(super.initialState);

  final StreamController<E> _eventController = StreamController<E>.broadcast();

  Stream<E> get eventStream => _eventController.stream;

  void emitEvent(E event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  void doIntent(I intent);

  @override
  Future<void> close() async {
    await _eventController.close();
    return super.close();
  }
}
