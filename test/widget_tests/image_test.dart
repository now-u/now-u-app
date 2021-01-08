import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../setup/helpers/image_helpers.dart';

import 'package:app/assets/components/custom_network_image.dart';

void main() {
  group("Custom network image should not crash - ", () {

    Future testImageDoesNotCrash(int statusCode, WidgetTester tester) async {
      await provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: CustomNetworkImage('https://example.com/image.png'),
          ),
        );

      }, statusCode: statusCode);
    }
    
    Future testErrorIconDisplayed(int statusCode, WidgetTester tester, bool iconShown) async {
      await provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          CustomNetworkImage('https://example.com/image.png'),
        );
        await tester.pump(Duration(seconds: 1));
        
        var image = find.byType(CustomNetworkImage);
        var icon = find.byType(CircularProgressIndicator);
        
        // Assert one icon shown
        expect(image, findsOneWidget);
        if (iconShown) {
          expect(icon, findsOneWidget);
        }
        else {
          expect(icon, findsNothing);
        }

      }, statusCode: statusCode);
    }
    
    testWidgets('200', (WidgetTester tester) async {
      await testImageDoesNotCrash(200, tester);
      await testErrorIconDisplayed(200, tester, false);
    });
    
    testWidgets('404', (WidgetTester tester) async {
      await testImageDoesNotCrash(404, tester);
      await testErrorIconDisplayed(404, tester, true);
    });
    
    testWidgets('400', (WidgetTester tester) async {
      await testImageDoesNotCrash(400, tester);
      await testErrorIconDisplayed(400, tester, true);
    });
    
  });
}
