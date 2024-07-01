import 'package:flutter/material.dart';

import '../../assets/constants.dart';

class CenterProgressBar extends StatelessWidget {
  final bool isLoading;

  const CenterProgressBar({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Card(
              surfaceTintColor: CustomColors.white,
              child: const Padding(
                padding: EdgeInsets.all(CustomPaddingSize.normal),
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
