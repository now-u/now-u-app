import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/textButton.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/views/intro/intro_bloc.dart';
import 'package:nowu/ui/views/intro/intro_state.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/app.locator.dart';
import '../../../services/storage.dart';
import 'data/intro_page_data.dart';

const curve = Curves.ease;
const duration = Duration(milliseconds: 500);
const Duration animationDuration = Duration(milliseconds: 500);

@RoutePage()
class IntroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: BlocProvider(
        create: (context) => IntroBloc(
          appRouter: AutoRouter.of(context),
          storageService: locator<SecureStorageService>(),
        ),
        child: const IntroViewPages(),
      ),
    );
  }
}

class IntroViewPages extends StatelessWidget {
  const IntroViewPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Scaffold(
              body: Container(
                decoration: state.currentPage.backgroundImage == null
                    ? BoxDecoration(
                        // TODO This Context is wrong, this need to be a subwidget
                        color: Theme.of(context).colorScheme.surface,
                      )
                    : BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            state.currentPage.backgroundImage!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SafeArea(
                      child: Container(),
                    ),
                    if (state.currentPage.showSkip)
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: RectGetter(
                                key: context.read<IntroBloc>().skipKey,
                                child: CustomTextButton(
                                  'Skip',
                                  onClick: () =>
                                      context.read<IntroBloc>().skip(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state.currentPage.showLogo)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              'assets/imgs/intro/now-u-logo-onboarding.png',
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: PageView(
                        //physics: NeverScrollableScrollPhysics(),
                        onPageChanged: context.read<IntroBloc>().setIndex,
                        controller: context.read<IntroBloc>().controller,
                        children: introPages
                            .map((page) => IntroPageSectionWidget(page))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          height: 45,
                          child: !state.isLastPage
                              ? Container()
                              : RectGetter(
                                  key: context.read<IntroBloc>().getStartedKey,
                                  child: DarkButton(
                                    'Get Started!',
                                    onPressed: () => context
                                        .read<IntroBloc>()
                                        .getStarted(context),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: context.read<IntroBloc>().controller,
                      count: introPages.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.white.withOpacity(0.3),
                        activeDotColor: Colors.orange,
                        spacing: 8.0,
                        dotHeight: 12,
                        radius: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            if (state.animationRect != null)
              AnimatedPositioned(
                duration: animationDuration,
                left: state.animationRect!.left,
                right: MediaQuery.of(context).size.width -
                    state.animationRect!.right,
                top: state.animationRect!.top,
                bottom: MediaQuery.of(context).size.height -
                    state.animationRect!.bottom,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 136, 0, 1),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class IntroPageSectionWidget extends StatelessWidget {
  final IntroPageData data;

  IntroPageSectionWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: data.image != null
                ? Image(image: AssetImage(data.image!))
                : Container(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              data.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
