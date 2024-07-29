import 'package:flutter/material.dart';

import '../../assets/constants.dart';

class NowFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool enabled;
  final bool loading;

  const NowFilledButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Stack(
        children: [
          Container(
            height: 24,
            width: 24,
            alignment: Alignment.centerRight,
            child: loading
                ? CircularProgressIndicator(
                    color: CustomColors.white,
                  )
                : const SizedBox.shrink(),
          ),
          Center(child: Text(title)),
        ],
      ),
      onPressed: enabled && !loading ? onPressed : null,
      style: FilledButton.styleFrom(
        foregroundColor: CustomColors.white,
        backgroundColor: CustomColors.brandColor,
        disabledBackgroundColor: CustomColors.brandColor.withOpacity(0.5),
        disabledForegroundColor: CustomColors.white,
      ),
    );
  }
}
