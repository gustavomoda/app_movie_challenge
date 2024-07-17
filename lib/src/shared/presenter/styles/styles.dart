class Styles<T> {
  const Styles({
    required this.normal,
    T? loading,
    T? error,
  })  : assert(normal != null, 'normal state cannot be nul'),
        loading = loading ?? normal,
        error = error ?? normal;

  final T normal;
  final T loading;
  final T error;
}
