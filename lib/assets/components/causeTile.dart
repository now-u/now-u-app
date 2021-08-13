import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CauseTile extends StatefulWidget {
  final String causeName;
  final IconData iconData;

  CauseTile({@required this.causeName, @required this.iconData});

  @override
  _CauseTileState createState() => _CauseTileState();
}

class _CauseTileState extends State<CauseTile> {

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: selected ? Color(0XFFFFF3E5) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: selected ? Border.all(width:3, color: Color(0XFFFF8800)) : Border.all(width: 3, color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    offset: Offset(0, 8),
                    blurRadius: 6)
              ]),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(widget.iconData, size: 60.0, color: selected ? Color(0XFFFF8800) : Color(0XFF373A4A)),
              Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        '${widget.causeName}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )))
            ],
          )),
    );
  }
}
