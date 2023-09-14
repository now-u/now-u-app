import 'package:causeApiClient/causeApiClient.dart';

import './factory.dart';

class ImageFactory extends ModelFactory<Image> {
  @override
  Image generate() {
    return Image(
      (image) => image
        ..id = faker.randomGenerator.integer(100)
		..url = faker.internet.httpUrl()
		..altText = faker.lorem.sentence(),
    );
  }

  ImageBuilder generateBuilder() {
	final image = this.generate();
	final imageBuilder = ImageBuilder();
	imageBuilder.replace(image);
	return imageBuilder;
  }
}
