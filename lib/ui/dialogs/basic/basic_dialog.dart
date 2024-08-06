import 'package:flutter/material.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/utils/intersperse.dart';

class BasicDialogButtonArgs {
  final String text;
  final void Function() onClick;

  const BasicDialogButtonArgs({
    required this.text,
    required this.onClick,
  });
}

class BasicDialogArgs {
  final String title;
  final String description;
  final BasicDialogButtonArgs? mainButtonArgs;
  final BasicDialogButtonArgs? secondaryButtonArgs;

  const BasicDialogArgs({
    required this.title,
    required this.description,
    this.mainButtonArgs,
    this.secondaryButtonArgs,
  });
}

class BasicDialog extends StatelessWidget {
  final BasicDialogArgs args;
  const BasicDialog(this.args);

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
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  args.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    args.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (args.mainButtonArgs != null)
                      FilledButton(
                        child: Text(args.mainButtonArgs!.text),
                        onPressed: args.mainButtonArgs!.onClick,
                      ),
                    if (args.secondaryButtonArgs != null)
                      FilledButton(
                        style: secondaryFilledButtonStyle,
                        child: Text(args.secondaryButtonArgs!.text),
                        onPressed: args.secondaryButtonArgs!.onClick,
                      ),
                  ]
                      .intersperse(
                        const SizedBox(
                          height: 15,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
