import 'dart:async' show StreamSubscription;

import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

abstract class StreamBuilderBase<T> extends SingleChildStatefulWidget {
  const StreamBuilderBase({super.key, required this.stream});

  final Stream<T> stream;

  T? initial();

  T? addData(T? data) => data;

  void build(BuildContext context, T? currentSummary);

  @override
  SingleChildState<StreamBuilderBase<T>> createState() =>
      _StreamBuilderBaseState<T>();
}

class _StreamBuilderBaseState<T>
    extends SingleChildState<StreamBuilderBase<T>> {
  StreamSubscription<T>? _subscription;
  late T? _summary = widget.initial();

  @override
  void initState() {
    super.initState();
    _summary = widget.initial();
    _subscribe();
  }

  @override
  void didUpdateWidget(StreamBuilderBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      _unsubscribe();
      _subscribe();
    }
  }

  // @override
  // Widget build(BuildContext context) => widget.build(context, _summary);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    assert(
      child != null,
      '''${widget.runtimeType} used outside of MultiBlocListener must specify a child''',
    );
    widget.build(context, _summary);
    return child!;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.stream.listen((T data) {
      setState(() {
        _summary = widget.addData(data);
      });
    }, onError: (Object error, StackTrace stackTrace) {
      setState(() {
        _summary = widget.addData(_summary);
      });
    }, onDone: () {
      setState(() {
        _summary = widget.addData(_summary);
      });
    });
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}

class BlocStreamListener<T> extends StreamBuilderBase<T> {
  const BlocStreamListener({
    super.key,
    this.initialData,
    required super.stream,
    required this.builder,
  });

  final Function(BuildContext context, T? snapshot) builder;
  final T? initialData;

  @override
  T? initial() => initialData;

  @override
  void build(BuildContext context, T? currentSummary) =>
      builder(context, currentSummary);
}
