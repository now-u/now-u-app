import 'package:flutter/material.dart';

Container _child;

class HomeTile extends StatelessWidget {
  HomeTile (Container child) {
    _child = child;
  }
  @override
  Widget build(BuildContext context) {
    return 
        Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: 
              Material(
                    color: Colors.white,
                    shadowColor:  Color.fromRGBO(69, 91, 99, 0.2),
                    elevation: 10.0,
                    child: 
                      SizedBox(
                        width: double.infinity,
                        height: 100.0,
                        child: _child,
                      )
                    , 
                  )
            , 
            );
  }
}
