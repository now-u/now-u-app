import 'package:flutter/material.dart';
import 'package:app/assets/StyleFrom.dart';

final double WIDTH = 60;
final double HEIGHT = 30;

enum CustomFormFieldStyle {
  Light,
  Dark
}

class CustomTextFormField extends StatelessWidget {
  final bool autofocus;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved;
  final CustomFormFieldStyle style;
  final String hintText;
  final TextCapitalization textCapitalization;

  CustomTextFormField({
    @required this.autofocus,
    @required this.keyboardType,
    @required this.validator,
    @required this.onSaved,
    @required this.style,
    @required this.hintText,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.go,
        autofocus: autofocus,
        validator: validator,
        onSaved: onSaved,
        style: textStyleFrom(
          Theme.of(context).primaryTextTheme.headline5,
          color: Colors.white,
        ),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          filled: true,
          fillColor: Color.fromRGBO(221,221,221,0.2),

          hintText: hintText,
          hintStyle: TextStyle(
            color: colorFrom(
              Theme.of(context).primaryColor,
              opacity: 0.5,
            ),
          ),
        ),
      )
    );
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
            width: WIDTH,
            height: HEIGHT,
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
                      ? SizedBox(width: WIDTH - HEIGHT - 5)
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: HEIGHT - 5,
                      height: HEIGHT - 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      //? _getText(false)
                      ? SizedBox(width: WIDTH - HEIGHT -5)
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
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) =>  Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
