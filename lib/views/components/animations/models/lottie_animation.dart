enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error'),
  circularLoading(name: 'circular_loading');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
