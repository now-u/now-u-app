import 'package:flutter/material.dart';
import 'package:nowu/themes.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';

import 'login_email_sent_viewmodel.dart';

@RoutePage()
class LoginEmailSentView extends StackedView<LoginEmailSentViewModel> {
  final String email;
  final String? token;

  const LoginEmailSentView({
    Key? key,
    @pathParam required this.email,
    this.token,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginEmailSentViewModel viewModel,
    Widget? child,
  ) {
    return Theme(
      data: darkTheme,
      child: _Body(viewModel: viewModel, token: token, email: email),
    );
  }

  @override
  LoginEmailSentViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginEmailSentViewModel(email: email);
}

class _Body extends StatelessWidget {
  final String email;
  final String? token;
  final LoginEmailSentViewModel viewModel;

  const _Body({
    required this.token,
    required this.email,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO Why do I have to explicitly set this?
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
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
          token == null
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
              child: FilledButton(
                child: const Text('Open Email'),
                onPressed: viewModel.openMailApp,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO Replace with actual text button
              TextButton(
                child: const Text("I didn't get my email"),
                onPressed: viewModel.backToLogin,
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
              child: FilledButton(
                child: const Text('Use secret code'),
                onPressed: viewModel.navigateToSecretCodePage,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
