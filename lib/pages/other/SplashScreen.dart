import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image(
            image: AssetImage('assets/imgs/logo.png'),
            width: 150,
        )
      )
    );
  }
}
