import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/change_password_bloc/change_password_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/pages/auth_pages/password_changed_animated_page.dart';
import 'package:verifeye/widgets/authentication_button.dart';
import 'package:verifeye/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final AdaptiveDialog showDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
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
            color: AppColors.mint,
          ),
        ),
        title: Text(
          'Change password',
          style: Theme.of(context).primaryTextTheme.headlineMedium,
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
                style:
                    Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                          fontFamily: GoogleFonts.sen().fontFamily,
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
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                hintText: 'Enter new password',
                labelText: 'New password',
                formControl: state.form.newPasswordControl,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                hintText: 'Rewrite new password',
                labelText: 'Confirm password',
                formControl: state.form.confirmPasswordControl,
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
    return AuthenticationButton(
      buttonName: 'Reset Password',
      loading: state.loading,
      onTap: () => BlocProvider.of<ChangePasswordBloc>(context).add(
        SetChangePasswordEvent(
          onError: (exception) {
            showDialog.showAdaptiveDialog(
              context,
              title: Text(
                "Can't set new password",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              content: Text(
                "The current password you entered didn't match our records. Please double-check and try again.",
                style: Theme.of(context).textTheme.labelLarge,
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
