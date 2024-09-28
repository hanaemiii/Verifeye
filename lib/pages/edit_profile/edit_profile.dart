import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/account_bloc/account_state.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/change_profile_pic_dialog.dart';
import 'package:verifeye/widgets/buttons/authentication_button.dart';
import 'package:verifeye/widgets/custom%20fields/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ChangeProfilePicDialog showDialog = ChangeProfilePicDialog();

  @override
  Widget build(BuildContext context) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;

    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          BlocProvider.of<AccountBloc>(context).add(
            ClearStateFileEvent(),
          );
        }
      },
      child: Scaffold(
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
            'Edit profile',
            style: primaryTextTheme.headlineMedium,
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          return Container(
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
                  photoWidget(
                    state: state,
                    primaryTextTheme: primaryTextTheme,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  formsWidget(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget photoWidget({
    required AccountState state,
    required TextTheme primaryTextTheme,
  }) {
    return Center(
      child: Container(
        width: 120.0,
        height: 120.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            state.file != null
                ? SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(61.0),
                      child: Image.file(
                        state.file!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : state.user!.photoUrl != null
                    ? SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(61.0),
                          child: Image.network(
                            state.user!.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 70,
                        color: AppColors.gray,
                      ),
            editPicWidget(
              primaryTextTheme: primaryTextTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget editPicWidget({
    required TextTheme primaryTextTheme,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog.changePic(
          context,
        );
      },
      child: Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit,
              size: 20,
              color: AppColors.white,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Edit picture',
              style: primaryTextTheme.bodySmall!.copyWith(
                color: AppColors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formsWidget() {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFieldWidget(
                hintText: 'Enter your name',
                labelText: 'First name',
                formControl: state.form.firstNameControl,
                controllerValue: state.user!.firstName,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                hintText: 'Enter your surname',
                labelText: 'Last name',
                formControl: state.form.lastNameControl,
                controllerValue: state.user!.lastName,
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

  Widget confirmButtonWidget(AccountState state) {
    return AuthenticationButton(
      buttonName: 'Save Changes',
      loading: state.loading,
      onTap: () => BlocProvider.of<AccountBloc>(context).add(
        ChangeNameEvent(
          onSuccess: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
