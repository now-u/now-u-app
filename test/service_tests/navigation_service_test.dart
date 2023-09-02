import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/app/app.locator.dart';

import '../setup/test_helpers.dart';

class MockDialogService extends Mock implements DialogService {}

class MockUrlLauncher extends Mock implements UrlLauncher {}

class MockBroswer extends Mock implements ChromeSafariBrowser {}

class UriFake extends Fake implements Uri {}

class MockNavigatorState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

class MockNavigationKey extends Mock implements GlobalKey<NavigatorState> {
  final NavigatorState navigatorState;
  MockNavigationKey({NavigatorState? navigatorState})
      : this.navigatorState = navigatorState ?? MockNavigatorState();

  @override
  NavigatorState? get currentState => navigatorState;
}

class CustomDialogFake extends Fake implements CustomDialog {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late NavigationService navigationService;
  late UrlLauncher mockUrlLauncher;
  late DialogService mockDialogService;
  late NavigatorState mockNavigatorState;
  late ChromeSafariBrowser mockBroswer;

  setUpAll(() {
    registerFallbackValue(CustomDialogFake());
    registerFallbackValue(UriFake());
  });

  setUp(() {
    locator.reset();
    setupLocator();
    mockDialogService = MockDialogService();
    mockUrlLauncher = MockUrlLauncher();
    mockBroswer = MockBroswer();
    registerMock<DialogService>(mockDialogService);

    // Register the real NavigationService with a mock global key
    var mockNavigationKey = MockNavigationKey();
    mockNavigatorState = mockNavigationKey.currentState!;

    navigationService =
        NavigationService(mockNavigationKey, mockUrlLauncher, mockBroswer);
  });

  group('InternalLinkingTests -', () {
    group('isInternalLink tests -', () {
      void testIsInternalLink(String input, bool output) {
        expect(navigationService.isInternalLink(input), output);
      }

      test('Valid internal link isInternalLink', () {
        testIsInternalLink('internal:home', true);
      });

      test('Valid internal link with parameters isInternalLink', () {
        testIsInternalLink('internal:home&1=2?2=4', true);
      });

      test('Http link is not internal link', () {
        testIsInternalLink('http://hello.com', false);
      });
    });

    group('getInternalLinkRoute -', () {
      void testInternalLinkRoute(String input, String expected) {
        expect(navigationService.getInternalLinkRoute(input), expected);
      }

      test('Link with no parameters gets correct route', () {
        testInternalLinkRoute('internal:home', 'home');
        testInternalLinkRoute('internal:aboutus', 'aboutus');
      });

      test('Link with parameters gets correct route', () {
        testInternalLinkRoute('internal:home&1=2?2=3', 'home');
        testInternalLinkRoute(
          'internal:aboutus&hello=howareyou?2=3',
          'aboutus',
        );
      });
    });

    group('getInternalLinkParameters -', () {
      void testInternalLinkParameters(String input, Map? expected) {
        expect(navigationService.getInternalLinkParameters(input), expected);
      }

      test('Link with no parameters gets correct parameters', () {
        testInternalLinkParameters('internal:aboutus', null);
      });

      test('Link with parameters gets correct parameters', () {
        testInternalLinkParameters('internal:aboutus&hello=howareyou?2=3', {
          'hello': 'howareyou',
          '2': '3',
        });

        testInternalLinkParameters('internal:aboutus&id=3', {
          'id': '3',
        });
      });
    });
  });

  group('External urls tests -', () {
    group('isPDF tests -', () {
      void testIsPDF(String input, bool output) {
        expect(navigationService.isPDF(input), output);
      }

      test('Pdf link is a pdf', () {
        testIsPDF(
          'https://share.now-u.com/legal/now-u_privacy_policy.pdf',
          true,
        );
      });

      test('Pdf internal link is a pdf', () {
        testIsPDF('internal://hello.pdf', true);
      });

      test('Non pdf link is not a pdf', () {
        testIsPDF('https://hello.com', false);
      });
    });

    group('isMailTo tests -', () {
      void testIsMailto(String input, bool output) {
        expect(navigationService.isMailTo(input), output);
      }

      test('Mailto link is a mailto', () {
        testIsMailto('mailto:name@email.com', true);
      });

      test('internal link is no a mailto', () {
        testIsMailto('internal://hello.pdf', false);
      });

      test('http link is not a mailto', () {
        testIsMailto('https://hello.com', false);
      });
    });

    group('launchLink', () {
      group('externally opens', () {
        Future<void> assertOpensLinkExternally(String url) async {
          when(() => mockDialogService.showDialog(any())).thenAnswer(
            (_) => Future<AlertResponse>(() => AlertResponse(response: true)),
          );

          when(() => mockUrlLauncher.openUrl(any()))
              .thenAnswer((_) => Future.value());

          await navigationService.launchLink(url);
          verify(() => mockUrlLauncher.openUrl(Uri.parse(url))).called(1);
          verifyNever(() => mockBroswer.open(url: any(named: 'url')));
        }

        test('mailto links', () async {
          await assertOpensLinkExternally(
            'mailto:someone@yoursite.com?subject=Mail from Our Site',
          );
        });
      });

      group('opens in internal browser', () {
        Future<void> assertOpensLinkInternally(String url) async {
          when(() => mockBroswer.open(url: any(named: 'url')))
              .thenAnswer((_) => Future<void>(() => null));

          await navigationService.launchLink(url);

          verify(() => mockBroswer.open(url: Uri.parse(url))).called(1);
          verifyNever(() => mockUrlLauncher.openUrl(any()));
        }

        test('https links', () async {
          await assertOpensLinkInternally(
            'https://css-tricks.com/snippets/html/mailto-links/',
          );
        });

        test('PDF links', () async {
          await assertOpensLinkInternally(
            'https://share.now-u.com/legal/now-u_privacy_policy.pdf',
          );
        });
      });

      group('resolves internal links', () {
        test('opens internal links internally', () async {
          const url = 'internal:home';
          when(
            () => mockNavigatorState.pushNamed<Object?>(
              any(),
              arguments: any(named: 'arguments'),
            ),
          ).thenAnswer((_) => Future.value({}));

          await navigationService.launchLink(url);

          // TODO Fix
          // verify(() => mockNavigatorState.pushNamed(Routes.home)).called(1);
        });
      });
    });
  });
}
