import 'package:flutter/material.dart';

final double theWidth = 60;
final double theHeight = 30;

enum CustomFormFieldStyle { Light, Dark }

// TODO We can probably remove this since we have themes now
class CustomTextFormField extends StatelessWidget {
  final bool? autofocus;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final Function? validator;
  final Function? onSaved;
  final Function? onChanged;
  final void Function()? onTap;
  final CustomFormFieldStyle? style;
  final String? hintText;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? errorText;

  CustomTextFormField({
    this.autofocus,
    this.hintText,
    this.initialValue,
    this.textCapitalization,
    this.style,
    this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.enabled,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.focusNode,
    this.readOnly,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onTap: onTap,
        focusNode: this.focusNode,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.go,
        autofocus: autofocus ?? false,
        validator: validator as String? Function(String?)?,
        onSaved: onSaved as void Function(String?)?,
        onChanged: onChanged as void Function(String)?,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: style == CustomFormFieldStyle.Light
                  ? Colors.black
                  : Colors.white,
            ),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          // hintStyle: style == CustomFormFieldStyle.Light
          //     ? TextStyle(color: CustomColors.greyMed1)
          //     : TextStyle(
          //         color: colorFrom(
          //           Theme.of(context).primaryColor,
          //           opacity: 0.5,
          //         ),
          //       ),
          // enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(color: CustomColors.greyMed1)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
        ),
        initialValue: initialValue,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        controller: controller,
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;

  final String activeText = 'On';
  final String inactiveText = 'Off';

  const CustomSwitch({
    Key? key,
    this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value! ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (!_animationController.isAnimating) {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }

              !widget.value!
                  ? widget.onChanged!(true)
                  : widget.onChanged!(false);
            }
          },
          child: Container(
            width: theWidth,
            height: theHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      //? _getText(true)
                      ? SizedBox(width: theWidth - theHeight - 5)
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: theHeight - 5,
                      height: theHeight - 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      //? _getText(false)
                      ? SizedBox(width: theWidth - theHeight - 5)
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
                            // Note value will never be null as tristate is false
                            onChanged(value!);
                          }
                        },
                        shape: const CircleBorder(),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      // CircularCheckBox(
                      //   value: state.value,
                      //   onChanged: state.didChange,
                      //   inactiveColor: Theme.of(context).primaryColor,
                      //   activeColor: Theme.of(context).primaryColor,
                      // ),
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
