import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AdaptiveDialog showDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    double height = screenHeight;
    double bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.gray.withOpacity(0.1),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
        return Container(
          color: AppColors.gray.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: (height / 7) - (bottomHeight / 4),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Forgot password',
                  style: primaryTextTheme.displayMedium!.copyWith(
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CustomTextFieldWidget(
                hintText: 'Enter your E-mail adress',
                labelText: 'Email',
                formControl: state.form.emailControl,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Please write your email to receive a \nconfirmation code to set a new password.',
                style: primaryTextTheme.labelSmall!.copyWith(
                  color: AppColors.black.withOpacity(0.57),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonWidget(state),
            ],
          ),
        );
      }),
    );
  }

  Widget buttonWidget(ForgotPasswordState state) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ForgotPasswordBloc forgotPasswordBloc =
        BlocProvider.of<ForgotPasswordBloc>(context);

    return AuthenticationButton(
      buttonName: 'Confirm email',
      onTap: () => forgotPasswordBloc.add(
        SendEmailEvent(
          onSuccess: () {
            showDialog.showAdaptiveDialog(
              context,
              title: Text(
                'Check your email',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text.rich(
                TextSpan(
                  style: textTheme.labelLarge,
                  children: [
                    const TextSpan(
                      text: 'Please check the email adress ',
                    ),
                    TextSpan(
                      text: state.form.emailControl.value,
                      style: textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const TextSpan(
                      text: ' for instructions to reset your password.',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      loading: state.loading,
    );
  }
}
