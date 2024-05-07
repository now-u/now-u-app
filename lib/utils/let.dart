extension ObjectExt<T> on T {
  R let<R>(R Function(T) x) => x(this);
}
