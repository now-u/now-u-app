import 'package:flutter/material.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/utils/intersperse.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'basic_dialog_model.dart';

class BasicDialog extends StackedView<BasicDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BasicDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  request.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    request.description!,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (request.mainButtonTitle != null)
                      TextButton(
                        child: Text(request.mainButtonTitle!),
                        onPressed: () =>
                            completer(DialogResponse(confirmed: true)),
                      ),
                    if (request.secondaryButtonTitle != null)
                      TextButton(
                        style: secondaryTextButtonStyle,
                        child: Text(request.secondaryButtonTitle!),
                        onPressed: () =>
                            completer(DialogResponse(confirmed: false)),
                      ),
                  ].intersperse(const SizedBox(height: 10,)).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  BasicDialogModel viewModelBuilder(BuildContext context) => BasicDialogModel();
}
