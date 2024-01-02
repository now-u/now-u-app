import 'package:flutter/material.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/theme/spacings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../generated/l10n.dart';
import '../../../theme/assets.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.medium_150,
              ),
              child: ActionCompletedDialogContent(
                viewModel: viewModel,
              ),
            ),
          ),
          Image.asset(
            Assets.hearts,
            width: 145.0,
            height: 145.0,
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
        const SizedBox(height: Spacing.medium_125),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => viewModel.onClose(),
            icon: const Icon(
              CustomIcons.ic_close,
            ),
          ),
        ),
        const SizedBox(height: Spacing.medium_125),
        Flexible(
          child: Text(
            S.of(context).action_completed_dialog_title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: Spacing.medium_125),
        Flexible(
          child: Text(
            S.of(context).action_completed_dialog_label,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: Spacing.medium_125),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.large_100),
          width: double.infinity,
          child: FilledButton(
            child: Text(S.of(context).action_completed_dialog_explore_action),
            onPressed: viewModel.onNavigateToExplore,
          ),
        ),
        const SizedBox(height: Spacing.medium_125),
      ],
    );
  }
}
