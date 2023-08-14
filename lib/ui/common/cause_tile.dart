import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/customIconButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Cause.dart';

class CauseTile extends StatelessWidget {
  final Cause cause;
  final bool isSelected;
  final IconData icon;
  final VoidCallback gestureFunction;
  final VoidCallback getInfoFunction;

  CauseTile({
    required this.cause,
    required this.gestureFunction,
    required this.getInfoFunction,
    bool? isSelected,
  })  : this.isSelected = isSelected ?? cause.isSelected,
        this.icon = cause.icon.toIconData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gestureFunction,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0XFFFFF3E5) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: isSelected
              ? Border.all(width: 3, color: Theme.of(context).primaryColor)
              : Border.all(width: 3, color: Colors.transparent),
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 8),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          children: [
            Container(height: 18),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(
                      icon,
                      size: 48.0,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : CustomColors.black1,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${cause.title}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: const Text(
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
            const SizedBox(height: 1)
          ],
        ),
      ),
    );
  }
}
