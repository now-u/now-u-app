import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO This widget will most likely be added to flutter https://github.com/flutter/flutter/issues/108683
// Replace with build in widget if/when added
class DropdownFilterChip<T> extends StatelessWidget {
  const DropdownFilterChip({
    Key? key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final Widget label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T? value) onChanged;

  @override
  Widget build(BuildContext context) {
    final dropdownButtonKey = GlobalKey();
    final focusNode = FocusNode();
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          label,
          const SizedBox(width: 8),
          const FaIcon(FontAwesomeIcons.caretDown),
          Offstage(
            child: DropdownButton<T>(
              key: dropdownButtonKey,
              focusNode: focusNode,
              value: value,
              items: items,
              onChanged: (value) {
                onChanged(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  focusNode.unfocus();
                });
              },
            ),
          ),
        ],
      ),
      onSelected: (_) {
        dropdownButtonKey.currentContext?.visitChildElements((element) {
          if (element.widget is Semantics) {
            element.visitChildElements((element) {
              if (element.widget is Actions) {
                element.visitChildElements((element) {
                  Actions.invoke(element, const ActivateIntent());
                });
              }
            });
          }
        });
      },
    );
  }
}
