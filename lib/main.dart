import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/enum/enum.dart';
import 'package:verifeye/firebase_options.dart';
import 'package:verifeye/pages/navigation_page.dart';
import 'package:verifeye/theme/colors.dart';
import 'package:verifeye/theme/text_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VerifEye',
      theme: ThemeData(
        fontFamily: GoogleFonts.sen().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.black,
        ),
        primaryColor: AppColors.black,
        useMaterial3: true,
        primaryTextTheme: AppTextTheme.primaryTextTheme,
      ),
      home: const NavigationPage(
        selectedPage: NavigationPages.home,
      ),
    );
  }
}
