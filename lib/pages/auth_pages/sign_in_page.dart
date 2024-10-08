import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';
import 'package:verifeye/widgets/settings%20widget/terms_and_privacy_widget.dart';

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
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      body: Container(
        height: screenHeight,
        color: AppColors.gray.withOpacity(0.1),
        padding: EdgeInsets.only(
          right: 32,
          left: 32,
          bottom: bottomHeight == 0 ? screenHeight / 20 : 0,
          top: (screenHeight / 5) - (bottomHeight / 4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sign In',
                    style: primaryTextTheme.displayMedium!.copyWith(
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
            const TermsAndPrivacyWidget(
              textColor: 0xD9000000,
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldsAndButtonWidget() {
    TextTheme textTheme = Theme.of(context).textTheme;

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
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          forgotPasswordWidget(
            textTheme: textTheme,
          ),
          const SizedBox(
            height: 20,
          ),
          signInButtonWidget(
            isLoaded: state.loading,
            textTheme: textTheme,
          ),
          const SizedBox(
            height: 20,
          ),
          signUpWidget(
            textTheme: textTheme,
          ),
        ],
      );
    });
  }

  Widget signInButtonWidget({
    required bool isLoaded,
    required TextTheme textTheme,
  }) {
    SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);

    return AuthenticationButton(
      buttonName: 'Sign In',
      loading: isLoaded,
      onTap: () => signInBloc.add(
        UserSignInEvent(
          onError: (exception) {
            adaptiveDialog.showAdaptiveDialog(
              context,
              resend: exception.code == 'not-verified',
              title: Text(
                'Sign In Error',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                exception.message.toString(),
                style: textTheme.labelLarge,
              ),
            );
          },
          onInternetError: () {
            adaptiveDialog.showAdaptiveDialog(
              context,
              title: Text(
                'No Internet Connection',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Please check your connection and try again.",
                style: textTheme.labelLarge,
              ),
            );
          },
          onSuccess: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const NavigationPage(
                  selectedPage: NavigationPages.home,
                ),
              ),
              (_) => false,
            );
          },
        ),
      ),
    );
  }

  Widget signUpWidget({
    required TextTheme textTheme,
  }) {
    return Text.rich(
      TextSpan(
        style: textTheme.labelLarge,
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
                style: textTheme.labelLarge!.copyWith(
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

  Widget forgotPasswordWidget({
    required TextTheme textTheme,
  }) {
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
          style: textTheme.labelMedium!.copyWith(
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
