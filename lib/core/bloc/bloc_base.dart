import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocCore {
  void dispose();
}

// S - State, SS - SingleState, E - Event
abstract class BlocBase<S, SS, E> extends BlocCore {
  final _stateController = BehaviorSubject<S>();
  final _singleStateController = BehaviorSubject<SS?>.seeded(null);
  final _eventController = PublishSubject<E>();
  @protected
  final compositeSubscription = CompositeSubscription();

  S get state => _stateController.value;

  Stream<S> get outState => _stateController.stream.distinct();

  @protected
  Sink<S> get inState => _stateController.sink;

  Stream<SS?> get outSingleState => _singleStateController.stream.distinct();

  @protected
  Sink<SS?> get inSingleState => _singleStateController.sink;

  Stream<E> get outEvent => _eventController.stream;

  Sink<E> get inEvent => _eventController.sink;

  @override
  void dispose() {
    _stateController.close();
    _singleStateController.close();
    _eventController.close();
    compositeSubscription.cancel();
  }

  void listen<T>(
    Stream<T> stream,
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    compositeSubscription.add(stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError));
  }
}
