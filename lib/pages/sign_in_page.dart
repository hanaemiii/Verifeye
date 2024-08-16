import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:verifeye/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:verifeye/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:verifeye/enums/enum.dart';
import 'package:verifeye/pages/navigation_page.dart';
import 'package:verifeye/widgets/authentication_button.dart';
import 'package:verifeye/widgets/custom_text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: AppColors.gray.withOpacity(0.1),
        padding: EdgeInsets.only(
          right: 32,
          left: 32,
          top: height / 3,
          // bottom: 40,
        ),
        child: SizedBox(
          height: height / 2.5,
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
                height: 40,
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
          const Align(
            alignment: Alignment.centerRight,
            child: Text('Forgot your password?'),
          ),
          const SizedBox(
            height: 20,
          ),
          AuthenticationButton(
            buttonName: 'Sign In',
            loading: false,
            onTap: () => BlocProvider.of<SignInBloc>(context).add(
              UserSignInEvent(
                onError: (exception) {
                  print(exception);
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
          ),
        ],
      );
    });
  }
}
