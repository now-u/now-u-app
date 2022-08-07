abstract class Serializer<T> {
  T fromJson(Map<String, dynamic> data);
}

abstract class Explorable {
	const Explorable();
}
