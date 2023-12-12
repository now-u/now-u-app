import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/models/Cause.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'action_completed_dialog_model.dart';

class ActionCompletedDialog extends StackedView<ActionCompletedDialogModel> {
  // final DialogRequest<Cause> request;
  final Function(DialogResponse) completer;

  const ActionCompletedDialog({
    Key? key,
    required DialogRequest request,
    required this.completer,
  }) :
        // TODO Figure out how to remove this cast
        //       this.request = request as DialogRequest<Cause>,
        super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ActionCompletedDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      content: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 90),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 70),
                  Flexible(
                    child: Text(
                      'Thank you for taking action!',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Text(
                      'Discover more ways to make a difference in our community',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    width: double.infinity,
                    child: FilledButton(
                      child: const Text('Explore'),
                      onPressed: () => {},
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Image.asset(
            'assets/imgs/actions/hearts.png',
          ),
        ],
      ),
    );
  }

  @override
  ActionCompletedDialogModel viewModelBuilder(BuildContext context) =>
      ActionCompletedDialogModel();
}
