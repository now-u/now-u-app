import 'package:flutter_test/flutter_test.dart';

import 'package:app/services/navigation_service.dart';
import 'package:app/locator.dart';

void main() {
  group('InternalLinkingTests -', () {  
    setupLocator();
    final NavigationService _navigationService = locator<NavigationService>();

    group('isInternalLink tests -', () {  
      test('Valid internal link isInternalLink', () {
        String link = "internal:home";
        expect(_navigationService.isInternalLink(link), true);
      });
      
      test('Valid internal link with parameters isInternalLink', () {
        String link = "internal:home&1=2?2=4";
        expect(_navigationService.isInternalLink(link), true);
      });
      
      test('Http link is not internal link', () {
        String link = "http://hello.com";
        expect(_navigationService.isInternalLink(link), false);
      });
    });

    group('getInternalLinkRoute -', () {
      void testInternalLinkRoute(String input, String expected) {
        expect(_navigationService.getInternalLinkRoute(input), expected);
      }
  
      test('Link with no parameters gets correct route', () {
        testInternalLinkRoute("internal:home", "home");
        testInternalLinkRoute("internal:aboutus", "aboutus");
      });
      
      test('Link with parameters gets correct route', () {
        testInternalLinkRoute("internal:home&1=2?2=3", "home");
        testInternalLinkRoute("internal:aboutus&hello=howareyou?2=3", "aboutus");
      });
    });
    

    group('getInternalLinkParameters -', () {
      void testInternalLinkParameters(String input, Map expected) {
        expect(_navigationService.getInternalLinkParameters(input), expected);
      }
  
      test('Link with no parameters gets correct parameters', () {
        testInternalLinkParameters("internal:aboutus", null);
      });
      
      test('Link with parameters gets correct parameters', () {
        testInternalLinkParameters(
          "internal:aboutus&hello=howareyou?2=3",
          {
            "hello": "howareyou",
            "2": "3",
          }
        );

        testInternalLinkParameters(
          "internal:aboutus&id=3",
          {
            "id": "3",
          }
        );
      });
    });

  });
}
