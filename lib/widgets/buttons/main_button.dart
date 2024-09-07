import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/core/global_values/global_values.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color = AppColors.black,
  });
  final VoidCallback onTap;
  final String title;
  final Color color;
  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;

    return TouchRippleEffect(
      rippleColor: AppColors.white.withOpacity(0.5),
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.title,
          style: textTheme.bodyLarge!.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
