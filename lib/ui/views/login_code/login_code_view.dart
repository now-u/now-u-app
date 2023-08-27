import 'package:flutter/material.dart';
import 'package:nowu/assets/components/header.dart';
import 'package:nowu/themes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_code_view.form.dart';
import 'login_code_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(
      name: 'codeInput',
      validator: LoginCodeFormValidators.codeInputValidator,
    ),
  ],
)
class LoginCodeView extends StackedView<LoginCodeViewModel>
    with $LoginCodeView {
  final String email;

  const LoginCodeView({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginCodeViewModel viewModel,
    Widget? child,
  ) {
    // TODO Does this still work?
    return WillPopScope(
      onWillPop: () async => false,
      child: Theme(
        data: darkTheme,
        child: _Body(viewModel, codeInputController: codeInputController),
      ),
    );
  }

  @override
  LoginCodeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginCodeViewModel(email: email);
}

class _LoginForm extends StatelessWidget {
  final LoginCodeViewModel viewModel;
  final TextEditingController codeInputController;

  const _LoginForm(this.viewModel, {
    super.key,
    required this.codeInputController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: SafeArea(
        child: Column(
          //shrinkWrap: true,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PageHeader(
              title: 'Complete login',
              backButton: true,
              textColor: Colors.white,
            ),

            const SizedBox(height: 35),

            Center(
              child: ClipRRect(
                child: Container(
                  width: 65,
                  child: Image.asset('assets/imgs/logo.png'),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
            ),

            const SizedBox(
              height: 35,
            ),
            Text(
              'Type in your 6 digit code from the email to log into now-u',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 35,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your secret 6 digit code',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: codeInputController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textCapitalization: TextCapitalization.none,
                  autofocus: false,
                  decoration: const InputDecoration(
                    hintText: 'e.g. 123456',
                  ),
                  onChanged: (value) {
                    if (viewModel.codeInputValidationMessage != null) {
                      viewModel.validateForm();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextButton(
                    child: const Text('Log in'),
                    onPressed: () {
                      viewModel.loginWithCode();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )

            // Uncomment to readd Skip button
            //skipButton(),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final LoginCodeViewModel viewModel;
  final TextEditingController codeInputController;

  const _Body(this.viewModel, {
    super.key,
	required this.codeInputController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
	// TODO Why do I need to specify this manually?
	  backgroundColor: Theme.of(context).colorScheme.background,
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            _LoginForm(viewModel, codeInputController: codeInputController),
          ],
        ),
      ),
    );
  }
}
