import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/pages/conditions_pages/privacy_policy.dart';
import 'package:verifeye/pages/conditions_pages/terms_conditions.dart';
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_check_box.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AdaptiveDialog adaptiveDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          BlocProvider.of<SignUpBloc>(context).add(
            ClearSignUpFieldsEvent(),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.gray.withOpacity(0.1),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Container(
          height: screenHeight,
          color: AppColors.gray.withOpacity(0.1),
          padding: EdgeInsets.only(
            right: 32,
            left: 32,
            bottom: safeAreaBottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .displayMedium!
                          .copyWith(
                            fontSize: 40,
                          ),
                    ),
                    fieldsAdnButtonWidget(screenHeight),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldsAdnButtonWidget(double height) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return SizedBox(
        height: screenHeight - safeAreaBottom - safeAreaTop - 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 40,
            ),
            CustomTextFieldWidget(
              hintText: 'Enter your username',
              labelText: 'Email',
              formControl: state.form.emailControl,
            ),
            CustomTextFieldWidget(
              hintText: 'Enter your name',
              labelText: 'First name',
              formControl: state.form.firstNameControl,
            ),
            CustomTextFieldWidget(
              hintText: 'Enter your surname',
              labelText: 'Last name',
              formControl: state.form.lastNameControl,
            ),
            CustomTextFieldWidget(
              hintText: 'Enter your password',
              labelText: 'Password',
              formControl: state.form.passwordControl,
              obscureText: true,
            ),
            CustomTextFieldWidget(
              hintText: 'Enter your password',
              labelText: 'Confirm password',
              formControl: state.form.confirmPasswordControl,
              obscureText: true,
            ),
            checkBoxWidget(state),
            const SizedBox(
              height: 20,
            ),
            signUpButtonWidget(state.loading),
          ],
        ),
      );
    });
  }

  Widget signUpButtonWidget(bool isLoaded) {
    return AuthenticationButton(
      buttonName: 'Sign Up',
      loading: isLoaded,
      onTap: () => BlocProvider.of<SignUpBloc>(context).add(
        CreateUserEvent(
          onError: (exception) {
            adaptiveDialog.showAdaptiveDialog(
              context,
              title: Text(
                'Sign Up Error',
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
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget checkBoxWidget(SignUpState state) {
    return CustomCheckBox(
      trailing: Text.rich(
        TextSpan(
          text: 'I agree to the ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.5),
          ),
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsConditionsPage(),
                    ),
                  );
                },
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const TextSpan(
              text: ' and\n',
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                child: const Text(
                  'Privacy Policy.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      formControl: state.form.agreeControl,
    );
  }
}
