import 'package:flutter/material.dart';


class HomeTile extends StatelessWidget {
  final Container child;
  HomeTile (this.child);

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
                        child: child,
                      )
                    , 
                  )
            , 
            );
  }
}
