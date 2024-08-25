import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_event.dart';

class ResendEmailButton extends StatefulWidget {
  const ResendEmailButton({super.key});

  @override
  State<ResendEmailButton> createState() => _ResendEmailButtonState();
}

class _ResendEmailButtonState extends State<ResendEmailButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        BlocProvider.of<SignInBloc>(context).add(
          ResendVerificationEmailEvent(
            onSuccess: () => Navigator.pop(context),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        alignment: Alignment.center,
        child: Text(
          'Resend email',
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
