import 'package:flutter/material.dart';
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
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
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
