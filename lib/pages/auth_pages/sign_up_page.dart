import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/sign_up_bloc/sign_up_state.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/widgets/authentication_button.dart';
import 'package:verifeye/widgets/custom_check_box.dart';
import 'package:verifeye/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AdaptiveDialog adaptiveDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double bottomHeight = MediaQuery.of(context).viewInsets.bottom;

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
          height: height,
          color: AppColors.gray.withOpacity(0.1),
          padding: const EdgeInsets.only(
            right: 32,
            left: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: (height / 14) - (bottomHeight / 7),
                ),
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
                    fieldsAdnButtonWidget(height),
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
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your username',
            labelText: 'Email',
            formControl: state.form.emailControl,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your name',
            labelText: 'First name',
            formControl: state.form.firstNameControl,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your surname',
            labelText: 'Last name',
            formControl: state.form.lastNameControl,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your password',
            labelText: 'Password',
            formControl: state.form.passwordControl,
            // obscureText: true,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFieldWidget(
            hintText: 'Enter your password',
            labelText: 'Confirm password',
            formControl: state.form.confirmPasswordControl,
            // obscureText: true,
          ),
          const SizedBox(
            height: 30,
          ),
          checkBoxWidget(state),
          const SizedBox(
            height: 30,
          ),
          signUpButtonWidget(state.loading),
        ],
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
                      builder: (context) =>
                          const Placeholder(), //TermsConditionPage(),
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
                      builder: (context) =>
                          const Placeholder(), //PrivacyPolicyPage(),
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
