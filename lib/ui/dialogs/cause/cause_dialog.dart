import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/models/Cause.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'cause_dialog_model.dart';

class CauseDialog extends StackedView<CausesDialogModel> {
  final DialogRequest<Cause> request;
  final Function(DialogResponse) completer;

  const CauseDialog({
    Key? key,
    required DialogRequest request,
    required this.completer,
  })  :
        // TODO Figure out how to remove this cast
        this.request = request as DialogRequest<Cause>,
        super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CausesDialogModel viewModel,
    Widget? child,
  ) {
    final cause = request.data!;
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
          Stack(
            children: [
              CachedNetworkImage(imageUrl: cause.headerImage.url),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      completer(DialogResponse(confirmed: false));
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  cause.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),
                Text(
                  cause.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: DarkButton(
                    'Select Cause',
                    onPressed: () {
                      completer(DialogResponse(confirmed: true));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  CausesDialogModel viewModelBuilder(BuildContext context) =>
      CausesDialogModel();
}
