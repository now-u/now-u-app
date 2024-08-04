import 'package:flutter/material.dart';

class CustomCheckboxFormField extends FormField<bool> {
  CustomCheckboxFormField({
    Widget? title,
    FormFieldSetter<bool>? onSaved,
    ValueChanged<bool>? onChanged,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<bool> state) {
            return Builder(
              builder: (BuildContext context) => Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Checkbox(
                        value: state.value,
                        onChanged: (value) {
                          state.didChange(value);
                          if (onChanged != null) {
                            assert(
                              value != null,
                              'Value should never be null as tristate is false',
                            );
                            onChanged(value!);
                          }
                        },
                        shape: const CircleBorder(),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 3),
                      Expanded(child: title!),
                    ],
                  ),
                  state.hasError
                      ? Text(
                          state.errorText!,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: 12,
                                  ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        );
}
