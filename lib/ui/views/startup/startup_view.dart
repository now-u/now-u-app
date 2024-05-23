import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'startup_viewmodel.dart';

@RoutePage()
class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 100,
              child: Image.asset('assets/imgs/logo.png'),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class StartupErrorView extends StatelessWidget {
  final String errorMessage;
  final StartupViewModel model;

  const StartupErrorView({
    Key? key,
    required this.errorMessage,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 32),
        Text(
          errorMessage,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: model.handleStartUpLogic,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
