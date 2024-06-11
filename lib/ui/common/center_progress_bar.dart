import 'package:flutter/material.dart';

import '../../assets/constants.dart';

class CenterProgressBar extends StatelessWidget {
  final bool isLoading;

  const CenterProgressBar({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(CustomPaddingSize.normal),
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
