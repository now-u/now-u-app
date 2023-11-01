import 'package:flutter/material.dart';

class TextFormFieldWithExternalLabel extends StatelessWidget {
  final TextFormField textFormField;
  final String externalLabelText;

  const TextFormFieldWithExternalLabel({
    super.key,
    required this.textFormField,
    required this.externalLabelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            externalLabelText,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 8),
        textFormField,
      ],
    );
  }
}
