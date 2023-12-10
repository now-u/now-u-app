T require<T>(T? value, [String? message]) {
  if (value == null) {
    throw Exception(message ?? 'Required value is null');
  }
  return value;
}
