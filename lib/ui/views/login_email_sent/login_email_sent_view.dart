import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/dialogs/basic/basic_dialog.dart';
import 'package:nowu/ui/dialogs/email_app_picker/email_app_picker_dialog.dart';
import 'package:nowu/ui/views/login/components/login_auth_state_listener.dart';
import 'package:open_mail_app/open_mail_app.dart';

// TODO Need to listen for login on this page!!
@RoutePage()
class LoginEmailSentView extends StatelessWidget {
  final String email;
  final String? token;
  final String? initialRoute;

  const LoginEmailSentView({
    Key? key,
    @pathParam required this.email,
    @pathParam this.token,
    @pathParam this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginAuthStateListener(
      initialRoute: initialRoute,
      child: Theme(
        data: darkTheme,
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
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
                        onPressed: () => openMailApp(context),
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
                        onPressed: () => context.router.maybePop(),
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
                        onPressed: () =>
                            context.router.push(LoginCodeRoute(email: email)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future openMailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      showDialog(
        context: context,
        builder: (_) => const BasicDialog(
          const BasicDialogArgs(
            title: 'No email apps found',
            description: 'Please check your emails',
          ),
        ),
      );

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      return showDialog(
        context: context,
        builder: (_) => EmailAppPickerDialog(mailApps: result.options),
      );
    }
  }
}
