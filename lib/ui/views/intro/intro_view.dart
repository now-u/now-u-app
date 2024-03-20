import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/textButton.dart';
import 'package:nowu/themes.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

import 'intro_viewmodel.dart';

const curve = Curves.ease;
const duration = Duration(milliseconds: 500);
const Duration animationDuration = Duration(milliseconds: 500);

class IntroView extends StackedView<IntroViewModel> {
  @override
  IntroViewModel viewModelBuilder(BuildContext context) => IntroViewModel(0);

  @override
  Widget builder(
    BuildContext context,
    IntroViewModel viewModel,
    Widget? child,
  ) {
    return Theme(
      data: darkTheme,
      child: IntroViewPages(viewModel),
    );
  }
}

class IntroViewPages extends StatelessWidget {
  final IntroViewModel viewModel;

  const IntroViewPages(
    this.viewModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            decoration: viewModel.currentPage.backgroundImage == null
                ? BoxDecoration(
                    // TODO This Context is wrong, this need to be a subwidget
                    color: Theme.of(context).colorScheme.background,
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        viewModel.currentPage.backgroundImage!,
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
                if (viewModel.currentPage.showSkip)
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 70,
                          child: RectGetter(
                            key: viewModel.skipKey,
                            child: CustomTextButton(
                              'Skip',
                              onClick: () => viewModel.skip(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (viewModel.currentPage.showLogo)
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
                    onPageChanged: viewModel.setIndex,
                    controller: viewModel.controller,
                    children: viewModel.pages
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
                      child: !viewModel.isLastPage
                          ? Container()
                          : RectGetter(
                              key: viewModel.getStartedKey,
                              child: DarkButton(
                                'Get Started!',
                                onPressed: () => viewModel.getStarted(context),
                              ),
                            ),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: viewModel.controller,
                  count: viewModel.pages.length,
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
        if (viewModel.animationRect != null)
          AnimatedPositioned(
            duration: animationDuration,
            left: viewModel.animationRect!.left,
            right: MediaQuery.of(context).size.width -
                viewModel.animationRect!.right,
            top: viewModel.animationRect!.top,
            bottom: MediaQuery.of(context).size.height -
                viewModel.animationRect!.bottom,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 136, 0, 1),
              ),
            ),
          ),
      ],
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
