import 'package:flutter/material.dart';

class DialogOkButton extends StatefulWidget {
  const DialogOkButton({super.key});

  @override
  State<DialogOkButton> createState() => _DialogOkButtonState();
}

class _DialogOkButtonState extends State<DialogOkButton> {
  @override
  Widget build(BuildContext context) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
    Color primaryColorDark = Theme.of(context).primaryColorDark;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        alignment: Alignment.center,
        child: Text(
          'OK',
          style: primaryTextTheme.bodyMedium!.copyWith(
            color: primaryColorDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
