import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_helpers.dart';

import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/locator.dart';


void main() {
    
  setupTestLocator();
  WidgetsFlutterBinding.ensureInitialized();
  NavigationService _navigationService = locator<NavigationService>();

  group('InternalLinkingTests -', () {  

    group('isInternalLink tests -', () {  
      void testIsInternalLink(String input, bool output) {
        expect(_navigationService.isInternalLink(input), output);
      }
      test('Valid internal link isInternalLink', () {
        testIsInternalLink("internal:home", true);
      });
      
      test('Valid internal link with parameters isInternalLink', () {
        testIsInternalLink("internal:home&1=2?2=4", true);
      });
      
      test('Http link is not internal link', () {
        testIsInternalLink("http://hello.com", false);
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
  
  group('External urls tests -', () {  

    group('isPDF tests -', () {  
      void testIsPDF(String input, bool output) {
        expect(_navigationService.isPDF(input), output);
      }
      test('Pdf link is a pdf', () {
        testIsPDF("https://share.now-u.com/legal/now-u_privacy_policy.pdf", true);
      });
      
      test('Pdf internal link is a pdf', () {
        testIsPDF("internal://hello.pdf", true);
      });

      test('Non pdf link is not a pdf', () {
        testIsPDF("https://hello.com", false);
      });
    });
    
    group('isMailTo tests -', () {  
      final NavigationService _navigationService = locator<NavigationService>();
      void testIsMailto(String input, bool output) {
        expect(_navigationService.isMailTo(input), output);
      }
      test('Mailto link is a mailto', () {
        testIsMailto("mailto:name@email.com", true);
      });
      
      test('internal link is no a mailto', () {
        testIsMailto("internal://hello.pdf", false);
      });

      test('http link is not a mailto', () {
        testIsMailto("https://hello.com", false);
      });
    });
    
    group('launchLink uses launchLinkExternal -', () {  
      test('for PDF link', () async {
        
        print("Starting sad test");
        final List<MethodCall> log = <MethodCall>[];
        MethodChannel channel = const MethodChannel('plugins.flutter.io/url_launcher');
        channel.setMockMethodCallHandler((MethodCall methodCall) async {
          log.add(methodCall);
        });
  
        // Mock dialog service so it doesnt do a popup
        MockDialogService mockDialogService = setupMockDialogService();
        when(mockDialogService.showDialog(buttons: anyNamed('buttons'), title:
                anyNamed('title'), description:
                anyNamed('description'))).thenAnswer((_) =>
            Future.value(AlertResponse(response: true)));

        String url = "mailto:hello@hello.com";
        
        _navigationService = locator<NavigationService>();
        await _navigationService.launchLink(url);


        // expect(log, equals(<MethodCall>[new MethodCall('launch', url)]));

        // channel.setMockMethodCallHandler(null);
      });
    });

  });
}
