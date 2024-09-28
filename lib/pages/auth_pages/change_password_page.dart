import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/pages/auth_pages/password_changed_animated_page.dart';
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final AdaptiveDialog showDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray.withOpacity(0.1),
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: AppColors.backgroundViolet,
          ),
        ),
        title: Text(
          'Change password',
          style: primaryTextTheme.headlineMedium,
        ),
      ),
      body: Container(
        color: AppColors.gray.withOpacity(0.1),
        height: screenHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                'Change your password',
                textAlign: TextAlign.center,
                style: primaryTextTheme.displayMedium!.copyWith(
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              formsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget formsWidget() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFieldWidget(
                hintText: 'Enter current password',
                labelText: 'Current password',
                formControl: state.form.currentPasswordControl,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                hintText: 'Enter new password',
                labelText: 'New password',
                formControl: state.form.newPasswordControl,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                hintText: 'Rewrite new password',
                labelText: 'Confirm password',
                formControl: state.form.confirmPasswordControl,
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              confirmButtonWidget(state),
            ],
          ),
        );
      },
    );
  }

  Widget confirmButtonWidget(ChangePasswordState state) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ChangePasswordBloc changePasswordBloc =
        BlocProvider.of<ChangePasswordBloc>(context);
    return AuthenticationButton(
      buttonName: 'Reset Password',
      loading: state.loading,
      onTap: () => changePasswordBloc.add(
        SetChangePasswordEvent(
          onError: (exception) {
            showDialog.showAdaptiveDialog(
              context,
              title: Text(
                "Can't set new password",
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "The current password you entered didn't match our records. Please double-check and try again.",
                style: textTheme.labelLarge,
              ),
            );
          },
          onSuccess: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordChangedAnimatedPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
