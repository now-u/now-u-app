import 'package:faker/faker.dart';

abstract class ModelFactory<T> {
	Faker get faker => Faker();

	/// Generate a single fake model.
	T generate();

	/// Generate fake list based on provided length.
  	List<T> generateList({required int length}) {
		return List.generate(length, (index) => generate());
	}
}
