import 'package:flutter/material.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:app/assets/components/circularCheckbox.dart';

final double theWidth = 60;
final double theHeight = 30;

enum CustomFormFieldStyle { Light, Dark }

class CustomTextFormField extends StatelessWidget {
  final bool autofocus;
  final bool enabled;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final CustomFormFieldStyle style;
  final String hintText;
  final String initialValue;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.go,
      autofocus: autofocus ?? false,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      style: textStyleFrom(
        Theme.of(context).primaryTextTheme.headline5,
        color:
            style == CustomFormFieldStyle.Light ? Colors.black : Colors.white,
      ),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        filled: true,
        fillColor: Color.fromRGBO(221, 221, 221, 0.2),
        hintText: hintText ?? "",
        hintStyle: TextStyle(
          color: colorFrom(
            Theme.of(context).primaryColor,
            opacity: 0.5,
          ),
        ),
      ),
      initialValue: initialValue,
      enabled: enabled ?? true,
      controller: controller,
    ));
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;

  final String activeText = "On";
  final String inactiveText = "Off";

  const CustomSwitch(
      {Key key,
      this.value,
      this.onChanged,
      this.activeColor,
      this.inactiveColor = Colors.grey,
      this.activeTextColor = Colors.white70,
      this.inactiveTextColor = Colors.white70})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
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

              !widget.value ? widget.onChanged(true) : widget.onChanged(false);
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
                      decoration: BoxDecoration(
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

  _getText(bool active) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Text(
        active ? widget.activeText : widget.inactiveText,
        style: TextStyle(
          color: active ? widget.activeTextColor : widget.inactiveTextColor,
          fontWeight: FontWeight.w900,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class CustomCheckboxFormField extends FormField<bool> {
  CustomCheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.disabled,
            builder: (FormFieldState<bool> state) {
              return Builder(
                  builder: (BuildContext context) => Column(children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CircularCheckBox(
                              value: state.value,
                              onChanged: state.didChange,
                              inactiveColor: Theme.of(context).primaryColor,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 3),
                            Expanded(child: title),
                          ],
                        ),
                        state.hasError
                            ? Text(state.errorText,
                                style: textStyleFrom(
                                    Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                    color: Theme.of(context).errorColor,
                                    fontSize: 12))
                            : Container(),
                      ]));
            });
}
