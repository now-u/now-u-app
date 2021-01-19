import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../setup/helpers/image_helpers.dart';
import '../setup/fake_cache_manager.dart';

void main() {
  FakeCacheManager cacheManager;

  setUp(() {
    cacheManager = FakeCacheManager();
  });

  tearDown(() {
    cacheManager = null;
  });

  group("Custom network image tests - ", () {

    // Tests taken from here
    // https://github.com/Baseflow/flutter_cached_network_image/blob/develop/test/image_widget_test.dart    

    // TODO Fix this test
    // testWidgets('progress indicator called when success', (tester) async {
    //   var imageUrl = '123';
    //   // Create the widget by telling the tester to build it.
    //   cacheManager.returns(imageUrl, kTransparentImage);
    //   var progressShown = false;
    //   var thrown = false;
    //   await tester.pumpWidget(TestImageWidget(
    //     imageUrl: imageUrl,
    //     cacheManager: cacheManager,
    //     onProgress: () => progressShown = true,
    //     onError: () => thrown = true,
    //   ));
    //   await tester.pump();
    //   expect(thrown, isFalse);
    //   expect(progressShown, isTrue);
    // });

    testWidgets('placeholder called when fail', (tester) async {
      var imageUrl = '1234';
      // Create the widget by telling the tester to build it.
      cacheManager.throwsNotFound(imageUrl);
      var placeholderShown = false;
      var thrown = false;
      await tester.pumpWidget(TestImageWidget(
        imageUrl: imageUrl,
        cacheManager: cacheManager,
        onPlaceHolder: () => placeholderShown = true,
        onError: () => thrown = true,
      ));
      await tester.pumpAndSettle();
      expect(thrown, isTrue);
      expect(placeholderShown, isTrue);
    });

    testWidgets('errorBuilder called when image fails', (tester) async {
      var imageUrl = '12345';
      cacheManager.throwsNotFound(imageUrl);
      var thrown = false;
      await tester.pumpWidget(TestImageWidget(
        imageUrl: imageUrl,
        cacheManager: cacheManager,
        onError: () => thrown = true,
      ));
      await tester.pumpAndSettle();
      expect(thrown, isTrue);
    });

    // TODO Fix this test
    // testWidgets("errorBuilder doesn't call when image doesn't fail",
    //     (tester) async {
    //   var imageUrl = '123456';
    //   // Create the widget by telling the tester to build it.
    //   cacheManager.returns(imageUrl, kTransparentImage);
    //   var thrown = false;
    //   await tester.pumpWidget(TestImageWidget(
    //     imageUrl: imageUrl,
    //     cacheManager: cacheManager,
    //     onError: () => thrown = true,
    //   ));
    //   await tester.pumpAndSettle();
    //   expect(thrown, isFalse);
    // });

    testWidgets('progress indicator called when success', (tester) async {
      var imageUrl = '123';
      // Create the widget by telling the tester to build it.
      cacheManager.returns(imageUrl, kTransparentImage);
      var progressShown = false;
      var thrown = false;
      await tester.pumpWidget(
        TestImageWidget(
          imageUrl: imageUrl,
          cacheManager: cacheManager,
          onProgress: () => progressShown = true,
          onError: () => thrown = true,
        )
      );
      await tester.pump();
      expect(thrown, isFalse);
      expect(progressShown, isTrue);
    });

    testWidgets('placeholder called when fail', (tester) async {
      var imageUrl = '1234';
      // Create the widget by telling the tester to build it.
      cacheManager.throwsNotFound(imageUrl);
      var placeholderShown = false;
      var thrown = false;
      await tester.pumpWidget(TestImageWidget(
        imageUrl: imageUrl,
        cacheManager: cacheManager,
        onPlaceHolder: () => placeholderShown = true,
        onError: () => thrown = true,
      ));
      await tester.pumpAndSettle();
      expect(thrown, isTrue);
      expect(placeholderShown, isTrue);
    });

    testWidgets('progressIndicator called several times', (tester) async {
      var imageUrl = '7891';
      // Create the widget by telling the tester to build it.
      var delay = Duration(milliseconds: 1);
      var expectedResult = cacheManager.returns(
        imageUrl,
        kTransparentImage,
        delayBetweenChunks: delay,
      );
      var progressIndicatorCalled = 0;
      var thrown = false;
      await tester.pumpWidget(TestImageWidget(
        imageUrl: imageUrl,
        cacheManager: cacheManager,
        onProgress: () => progressIndicatorCalled++,
        onError: () => thrown = true,
      ));
      for (var i = 0; i < expectedResult.chunks; i++) {
        await tester.pump(delay);
        await tester.idle();
      }
      expect(thrown, isFalse);
      expect(progressIndicatorCalled, expectedResult.chunks + 1);
    });

    
  });
}
