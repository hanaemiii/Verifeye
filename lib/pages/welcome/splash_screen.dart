import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:verifeye/base/assets/assets.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:verifeye/bloc/splash_screen/splash_screen_event.dart';
import 'package:verifeye/core/app_preferences/app_preferences.dart';
import 'package:verifeye/enums/enum.dart';
import 'package:verifeye/pages/auth_pages/sign_in_page.dart';
import 'package:verifeye/pages/main_pages/navigation.dart';
import 'package:verifeye/pages/welcome/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  static const name = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkInitialSetup() async {
    return await AppPreferences.isFirstRun();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkInitialSetup(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          final bool isFirstRun = snapshot.data!;
          final User? currentUser = FirebaseAuth.instance.currentUser;

          BlocProvider.of<SplashScreenBloc>(context).add(
            LoadSplashEvent(
              onDone: () {
                if (isFirstRun) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                  );
                } else if (currentUser != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationPage(
                        selectedPage: NavigationPages.home,
                      ),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                }
              },
            ),
          );
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Lottie.asset(
                AppAssets.animation,
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
