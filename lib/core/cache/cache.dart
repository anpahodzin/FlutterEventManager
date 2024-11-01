class MemoryCache<T> implements Cache<T> {
  final _data = <Object?, T>{};

  @override
  T? operator [](Object? key) {
    return _data[key];
  }

  @override
  void operator []=(Object? key, T value) {
    _data[key] = value;
  }

  void clear() {
    _data.clear();
  }
}

abstract interface class Cache<T> {
  T? operator [](Object? key);

  void operator []=(Object? key, T value);
}
