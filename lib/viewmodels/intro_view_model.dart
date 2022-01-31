import 'package:app/pages/login/login.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:app/pages/campaign/CampaignPage.dart';

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

class IntroViewModel extends BaseModel {
  final PageController controller;
  final Duration animationDuration = Duration(milliseconds: 500);
  final Duration delay = Duration(milliseconds: 300);
  int currentIndex = 0;
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      animationRect =
          animationRect!.inflate(1.3 * MediaQuery.of(context).size.longestSide);
      notifyListeners();
      Future.delayed(animationDuration + delay, () => _goToNextPage(context));
    });
  }

  void _goToNextPage(BuildContext context) {
    // This is very bad dont use MyHomePage need named route
    Navigator.of(context)
        .push(FadeRouteBuilder(page: LoginPage(LoginPageArguments())));
  }
}
