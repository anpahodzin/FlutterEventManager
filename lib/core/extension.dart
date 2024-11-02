extension NullableExtension<T> on T? {
  ifNotNull(Function(T) block) {
    if (this != null) {
      return block(this as T);
    }
  }
}