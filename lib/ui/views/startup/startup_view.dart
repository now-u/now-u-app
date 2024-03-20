import 'package:flutter/material.dart';
import 'package:nowu/ui/views/startup/startup_state.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel model,
    Widget? widget,
  ) {
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
            switch (model.state) {
              Loading() => CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).primaryColor,
                  ),
                ),
              Error() => StartupErrorView(
                  errorMessage: (model.state as Error).message,
                  model: model,
                ),
            },
          ],
        ),
      ),
    );
  }

  @override
  viewModelBuilder(context) {
    return StartupViewModel();
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
