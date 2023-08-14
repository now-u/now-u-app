import 'package:flutter/material.dart';

import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/textButton.dart';
import 'package:nowu/ui/views/login/login_viewmodel.dart';

import 'package:stacked/stacked.dart';

import 'package:nowu/routes.dart';

class EmailSentPageArguments {
  final String email;
  final String? token;
  EmailSentPageArguments({
    required this.email,
    this.token,
  });
}

class EmailSentPage extends StatelessWidget {
  final EmailSentPageArguments args;
  EmailSentPage(this.args);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) {
        model.init();
        // if (args.token != null) {
        //   model.login(email: args.email, token: args.token!);
        // }
      },
      onDispose: (model) => model.dispose(),
      builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            Scaffold(
              body: Container(
                color: Theme.of(context).primaryColorDark,
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    args.token == null
                        ? Container()
                        : Container(
                            height: 40,
                            child: const CircularProgressIndicator(),
                          ),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Image(
                          image: AssetImage(
                            'assets/imgs/intro/il-mail@4x.png',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Check your email',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: double.infinity,
                        child: DarkButton(
                          'Open Email',
                          onPressed: () {
                            model.openMailApp();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextButton(
                          "I didn't get my email",
                          onClick: () {
                            Navigator.of(context).pushNamed(Routes.login);
                          },
                          fontSize: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'If the email link does not work, use the code we have emailed you.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: double.infinity,
                        child: DarkButton(
                          'Use secret code',
                          onPressed: () {
                            model.navigateToSecretCodePage(args.email);
                          },
                          style: DarkButtonStyle.Outline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// TODO Back button was broken on these pages
class IntroPageSection extends StatelessWidget {
  final String title;
  final String description;
  final AssetImage image;

  IntroPageSection(this.title, this.description, this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image(image: image),
          ),
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
