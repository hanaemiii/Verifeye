import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogOkButton extends StatefulWidget {
  const DialogOkButton({super.key});

  @override
  State<DialogOkButton> createState() => _DialogOkButtonState();
}

class _DialogOkButtonState extends State<DialogOkButton> {
  @override
  Widget build(BuildContext context) {
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
          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.sen().fontFamily,
              ),
        ),
      ),
    );
  }
}
