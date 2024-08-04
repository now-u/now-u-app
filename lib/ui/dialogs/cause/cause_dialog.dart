import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/models/cause.dart';

class CauseInfoDialog extends StatelessWidget {
  final Cause cause;
  final void Function() onSelectCause;

  const CauseInfoDialog({required this.cause, required this.onSelectCause});

  @override
  Widget build(BuildContext context) {
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
              CustomNetworkImage(cause.headerImage.url),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
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
                  child: FilledButton(
                    child: const Text('Select Cause'),
                    onPressed: () {
                      onSelectCause();
                      // TODO Check if this is the wrong way round (because we also navigate in the above method)
                      context.router.maybePop();
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
}
