import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/base/theme/text_theme.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/log_out_bloc.dart/log_out_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:verifeye/bloc/main_bloc/main_bloc.dart';
import 'package:verifeye/bloc/search/search_bloc.dart';
import 'package:verifeye/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:verifeye/core/injector/injector.dart';
import 'package:verifeye/firebase_options.dart';
import 'package:verifeye/pages/welcome/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  registerSingletons();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => MainBloc(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(),
        ),
        BlocProvider(
          create: (context) => LogOutBloc(
            mainBloc: BlocProvider.of<MainBloc>(context),
            accountBloc: BlocProvider.of<AccountBloc>(context),
          ),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountBloc(),
        ),
        BlocProvider(
          create: (context) => SplashScreenBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VerifEye',
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: AppColors.violet.withOpacity(0.5),
            selectionHandleColor: AppColors.violet,
            cursorColor: AppColors.violet,
          ),
          fontFamily: GoogleFonts.sen().fontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.black,
          ),
          primaryColor: AppColors.black,
          useMaterial3: true,
          primaryTextTheme: AppTextTheme.primaryTextTheme,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
