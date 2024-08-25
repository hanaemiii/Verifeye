import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:verifeye/base/theme/colors.dart';

class AuthenticationButton extends StatefulWidget {
  const AuthenticationButton({
    super.key,
    required this.buttonName,
    required this.loading,
    this.padding = 70,
    this.color = 0xFF000000,
    required this.onTap,
  });
  final String buttonName;
  final bool loading;
  final double padding;
  final int color;
  final void Function()? onTap;
  @override
  State<AuthenticationButton> createState() => _AuthenticationButtonState();
}

class _AuthenticationButtonState extends State<AuthenticationButton> {
  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      rippleColor: AppColors.white.withOpacity(0.75),
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: widget.padding,
        ),
        decoration: BoxDecoration(
          color: widget.loading == false
              ? Color(widget.color)
              : Color(widget.color).withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: widget.loading == false
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: [
            widget.loading == true
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white.withOpacity(0.5),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Opacity(
                opacity: widget.loading == false ? 1 : 0.5,
                child: Center(
                  child: Text(
                    widget.buttonName,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall!
                        .copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
