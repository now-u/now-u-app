import 'package:flutter/material.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'action_completed_dialog_model.dart';

class ActionCompletedDialog extends StackedView<ActionCompletedDialogModel> {
  final Function(DialogResponse) completer;

  const ActionCompletedDialog({
    Key? key,
    required DialogRequest request,
    required this.completer,
  }) : super(key: key);

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
            margin: const EdgeInsets.only(top: 90.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ActionCompletedDialogContent(
                viewModel: viewModel,
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

class ActionCompletedDialogContent extends StatelessWidget {
  final ActionCompletedDialogModel viewModel;

  const ActionCompletedDialogContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20.0),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => viewModel.onClose(),
            icon: const Icon(
              CustomIcons.ic_close,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Flexible(
          child: Text(
            'Thank you for taking action!',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 20.0),
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
            onPressed: viewModel.onNavigateToExplore,
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
