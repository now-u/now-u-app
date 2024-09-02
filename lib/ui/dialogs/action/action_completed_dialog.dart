import 'package:flutter/material.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nowu/router.gr.dart';
import 'package:share_plus/share_plus.dart';

import '../../../generated/l10n.dart';
import '../../../theme/assets.dart';

class ActionCompletedDialog extends StatelessWidget {
  const ActionCompletedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: const Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomPaddingSize.normal,
              ),
              child: const ActionCompletedDialogContent(),
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
}

class ActionCompletedDialogContent extends StatelessWidget {
  const ActionCompletedDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: CustomPaddingSize.normal),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => context.router.maybePop(),
            icon: const Icon(
              CustomIcons.ic_close,
            ),
          ),
        ),
        const SizedBox(height: CustomPaddingSize.normal),
        Flexible(
          child: Text(
            S.of(context).action_completed_dialog_title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: CustomPaddingSize.normal),
        Flexible(
          child: Text(
            S.of(context).action_completed_dialog_label,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: CustomPaddingSize.normal),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: CustomPaddingSize.large),
          width: double.infinity,
          child: FilledButton(
            child: Text(S.of(context).action_completed_dialog_explore_action),
            onPressed: () => context.router.push(
              TabsRoute(children: [ExploreRoute()]),
            ),
          ),
        ),
        const SizedBox(height: CustomPaddingSize.normal),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: CustomPaddingSize.large),
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('Share'),
            onPressed: () => Share.shareUri(Uri.parse('com.nowu.app://app/more')),
            //   'Checkout https://now-u.com/more',
            //   subject: 'example',
            // ),
          ),
        ),
        const SizedBox(height: CustomPaddingSize.normal),
      ],
    );
  }
}
