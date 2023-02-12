import 'package:flutter/material.dart';
import 'package:app/assets/components/buttons/customIconButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/models/Cause.dart';

class CauseTile extends StatelessWidget {
  final ListCause cause;
  final bool isSelected;
  final IconData icon;
  final VoidCallback gestureFunction;
  final VoidCallback getInfoFunction;

  CauseTile({
    required this.cause,
    required this.gestureFunction,
    required this.getInfoFunction,
    bool? isSelected,
  })  : this.isSelected = isSelected ?? cause.selected,
        this.icon = cause.icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gestureFunction,
      child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Color(0XFFFFF3E5) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: isSelected
                ? Border.all(width: 3, color: Theme.of(context).primaryColor)
                : Border.all(width: 3, color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 8),
                  blurRadius: 6)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                      child: Icon(
                        icon,
                        size: 24.0,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Container(
                        height: 60,
                        child: Center(
                          child: Text(
                            '${cause.title}',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                height: 1),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      child: Text(
                        'Learn more',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: getInfoFunction,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    CircularIconButton(
                      onPressed: getInfoFunction,
                      icon: FontAwesomeIcons.questionCircle,
                      iconSize: 14,
                      height: 20,
                      backgroundColor: Colors.transparent,
                      iconColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1)
            ],
          )),
    );
  }
}
