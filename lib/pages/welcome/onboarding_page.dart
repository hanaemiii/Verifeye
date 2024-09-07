import 'package:flutter/material.dart';
import 'package:verifeye/base/assets/assets.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/pages/auth_pages/sign_in_page.dart';
import 'package:verifeye/widgets/buttons/main_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: safeAreaTop * 2,
          bottom: safeAreaBottom * 3,
        ),
        color: AppColors.gray.withOpacity(0.1),
        child: Column(
          children: [
            imageWidget(),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome',
                    style: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    'Find trusted web links, ensure media security, and check and upload images with ease. Your reliable partner for online safety and content verification.',
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge!.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  MainButton(
                    title: 'Get Started',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      height: screenHeight / 2.5,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          AppAssets.onboarding,
        ),
      ),
    );
  }
}
