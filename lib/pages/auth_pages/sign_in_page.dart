import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_in_bloc/sign_in_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/enums/enum.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/pages/auth_pages/forgot_password_page.dart';
import 'package:verifeye/pages/main_pages/navigation.dart';
import 'package:verifeye/pages/auth_pages/sign_up_page.dart';
import 'package:verifeye/widgets/authentication_button.dart';
import 'package:verifeye/widgets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AdaptiveDialog adaptiveDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Container(
        height: screenHeight,
        color: AppColors.gray.withOpacity(0.1),
        padding: EdgeInsets.only(
          right: 32,
          left: 32,
          bottom: bottomHeight == 0 ? screenHeight / 4 : 0,
          top: (screenHeight / 5) - (bottomHeight / 4),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sign In',
                style:
                    Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                          fontSize: 40,
                        ),
              ),
              const SizedBox(
                height: 100,
              ),
              fieldsAndButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldsAndButtonWidget() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWidget(
            hintText: 'Enter your username',
            labelText: 'Email',
            formControl: state.signInForm.emailControl,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your password',
            labelText: 'Password',
            formControl: state.signInForm.passwordControl,
            // obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          forgotPasswordWidget(),
          const SizedBox(
            height: 20,
          ),
          signInButtonWidget(state.loading),
          const SizedBox(
            height: 20,
          ),
          signUpWidget(),
        ],
      );
    });
  }

  Widget signInButtonWidget(bool isLoaded) {
    return AuthenticationButton(
      buttonName: 'Sign In',
      loading: isLoaded,
      onTap: () => BlocProvider.of<SignInBloc>(context).add(
        UserSignInEvent(
          onError: (exception) {
            adaptiveDialog.showAdaptiveDialog(
              context,
              resend: exception.code == 'not-verified',
              title: Text(
                'Sign In Error',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              content: Text(exception.message.toString(),
                  style: Theme.of(context).textTheme.labelLarge),
            );
          },
          onInternetError: () {
            adaptiveDialog.showAdaptiveDialog(
              context,
              title: Text(
                'No Internet Connection',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              content: Text("Please check your connection and try again.",
                  style: Theme.of(context).textTheme.labelLarge),
            );
          },
          onSuccess: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationPage(
                  selectedPage: NavigationPages.home,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget signUpWidget() {
    return Text.rich(
      TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          const TextSpan(
            text: "Don't have an account? ",
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontFamily: GoogleFonts.sen().fontFamily,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPasswordWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            ),
          );
        },
        child: Text(
          'Forgot your password?',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.black.withOpacity(0.5),
              ),
        ),
      ),
    );
  }
}
