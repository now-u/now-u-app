import 'package:app/models/Cause.dart';

abstract class Serializer<T> {
  T fromJson(Map<String, dynamic> data);
}

ListCause causeFromJson(List<dynamic> causes) {
  return ListCause.fromJson(causes[0]);
}

abstract class Explorable {
  const Explorable();
}
