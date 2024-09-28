import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_event.dart';
import 'package:verifeye/bloc/authentication%20blocs/delete_account_bloc/delete_account_state.dart';
import 'package:verifeye/helpers/dialogs/adaptive_dialog.dart';
import 'package:verifeye/pages/auth_pages/sign_in_page.dart';
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final AdaptiveDialog showDialog = AdaptiveDialog();

  @override
  Widget build(BuildContext context) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      appBar: AppBar(
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
          'Delete Account',
          style: primaryTextTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 32,
            left: 32,
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Delete my account',
                    textAlign: TextAlign.center,
                    style: primaryTextTheme.displayMedium!.copyWith(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: formsWidget(
                  currentPasswordControl: state.form.currentPasswordControl,
                  isChecked: state.checked,
                  isLoading: state.loading,
                  formControl: state.form.currentPasswordControl,
                  primaryTextTheme: primaryTextTheme,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget formsWidget({
    required FormControl<String> currentPasswordControl,
    required bool isChecked,
    required bool isLoading,
    required FormControl<String> formControl,
    required TextTheme primaryTextTheme,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextFieldWidget(
            labelText: 'Current Password',
            hintText: 'Enter Password',
            formControl: formControl,
            obscureText: true,
          ),
          const SizedBox(
            height: 15,
          ),
          checkBoxAreaWidget(
            primaryTextTheme: primaryTextTheme,
          ),
          const SizedBox(
            height: 44,
          ),
          confirmButtonWidget(
            isChecked,
            isLoading,
          ),
        ],
      ),
    );
  }

  Widget checkBoxAreaWidget({
    required TextTheme primaryTextTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: checkBoxWidget(
            context,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 10,
          child: Text(
            'I understand that deleting my account is permanent and cannot be undone.',
            softWrap: true,
            style: primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(0.75),
            ),
          ),
        ),
      ],
    );
  }

  Widget checkBoxWidget(
    BuildContext context,
  ) {
    final DeleteAccountBloc deleteAccountBloc =
        BlocProvider.of<DeleteAccountBloc>(context);
    return BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
      builder: (context, state) {
        return SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            side: WidgetStateBorderSide.resolveWith(
              (states) => const BorderSide(
                width: 2.0,
                color: AppColors.black,
              ),
            ),
            activeColor: Colors.transparent,
            checkColor: AppColors.black,
            value: state.checked,
            onChanged: (value) {
              deleteAccountBloc.add(
                CheckBoxEvent(),
              );
            },
          ),
        );
      },
    );
  }

  Widget confirmButtonWidget(
    bool isChecked,
    bool isLoading,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: isChecked ? 1 : 0.5,
      child: AuthenticationButton(
        onTap: () {
          isChecked
              ? BlocProvider.of<DeleteAccountBloc>(context).add(
                  ConfirmDeletingEvent(
                    onError: (exception) {
                      showDialog.showAdaptiveDialog(
                        context,
                        title: Text(
                          "Can't delete account",
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
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                  ),
                )
              : null;
        },
        buttonName: 'Permanently Delete my Account',
        loading: isLoading,
        padding: 20,
        color: 0xFFFF0000,
      ),
    );
  }
}
