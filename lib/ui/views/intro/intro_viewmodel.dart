import 'package:flutter/widgets.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/ui/views/causes_selection/select_causes_viewmodel.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class IntroPageData {
  final String title;
  final String description;
  final String? image;
  final String? backgroundImage;
  final bool showSkip;
  final bool showLogo;

  IntroPageData({
    required this.title,
    required this.description,
    this.image,
    this.backgroundImage,
    this.showSkip = true,
    this.showLogo = false,
  });
}

// TODO Use IndexTracking view model
class IntroViewModel extends BaseViewModel {
  final _routerService = locator<NavigationService>();

  final PageController controller;
  final Duration animationDuration = const Duration(milliseconds: 500);
  final Duration delay = const Duration(milliseconds: 300);

  final List<IntroPageData> pages = [
    IntroPageData(
      title: 'Welcome',
      description:
          'Our mission is to inform, involve and inspire everyone to help tackle some of the world’s most pressing problems.',
      backgroundImage: 'assets/imgs/intro/OnBoarding1.png',
      showSkip: false,
      showLogo: true,
    ),
    IntroPageData(
      title: 'Choose causes you care about',
      description:
          'Select and support the social and environmental issues important to you.',
      image: 'assets/imgs/intro/On-Boarding illustrations-01.png',
    ),
    IntroPageData(
      title: 'Learn and take action',
      description: 'Find ways to make a difference that suit you.',
      image: 'assets/imgs/intro/On-Boarding illustrations-02.png',
    ),
    IntroPageData(
      title: 'Help shape a better world',
      description: 'Join our growing community driving lasting change.',
      image: 'assets/imgs/intro/On-Boarding illustrations-04.png',
    ),
  ];

  int currentIndex = 0;

  IntroPageData get currentPage => pages[currentIndex];

  bool get isLastPage => currentIndex == pages.length - 1;

  Rect? animationRect;

  var skipKey = RectGetter.createGlobalKey();
  var getStartedKey = RectGetter.createGlobalKey();

  IntroViewModel(int currentIndex)
      : this.currentIndex = currentIndex,
        this.controller = PageController(
          initialPage: currentIndex,
          viewportFraction: 1,
        );

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void getStarted(BuildContext context) {
    animationRect = RectGetter.getRectFromKey(getStartedKey)!;
    nextPage(context);
  }

  void skip(BuildContext context) {
    animationRect = RectGetter.getRectFromKey(skipKey)!;
    nextPage(context);
  }

  void nextPage(BuildContext context) async {
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationRect =
          animationRect!.inflate(1.3 * MediaQuery.of(context).size.longestSide);
      notifyListeners();
      Future.delayed(animationDuration + delay, () => _goToNextPage(context));
    });
  }

  void _goToNextPage(BuildContext context) {
    // TODO: Find a way to apply FadeIn transition only here
    _routerService.clearStackAndShow(Routes.loginView);
  }
}
