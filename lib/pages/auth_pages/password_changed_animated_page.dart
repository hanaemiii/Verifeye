import 'dart:async';
import 'package:flutter/material.dart';
import 'package:verifeye/base/assets/assets.dart';
import 'package:verifeye/base/theme/colors.dart';

class PasswordChangedAnimatedPage extends StatefulWidget {
  const PasswordChangedAnimatedPage({super.key});

  @override
  State<PasswordChangedAnimatedPage> createState() =>
      _PasswordChangedAnimatedPageState();
}

class _PasswordChangedAnimatedPageState
    extends State<PasswordChangedAnimatedPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pop();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.changed,
                height: 164.0,
                width: 164.0,
              ),
              Text(
                textAlign: TextAlign.center,
                'Your password has been successfully changed!',
                style: primaryTextTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
