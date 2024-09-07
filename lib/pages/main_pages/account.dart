import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:verifeye/base/icons/verifeye_icons_icons.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/bloc/account_bloc/account_state.dart';
import 'package:verifeye/bloc/authentication%20blocs/log_out_bloc.dart/log_out_bloc.dart';
import 'package:verifeye/bloc/authentication%20blocs/log_out_bloc.dart/log_out_event.dart';
import 'package:verifeye/core/global_values/global_values.dart';
import 'package:verifeye/helpers/dialogs/change_profile_pic_dialog.dart';
import 'package:verifeye/pages/auth_pages/change_password_page.dart';
import 'package:verifeye/pages/auth_pages/delete_account_page.dart';
import 'package:verifeye/pages/auth_pages/sign_in_page.dart';
import 'package:verifeye/pages/edit_profile/edit_profile.dart';
import 'package:verifeye/widgets/settings%20widget/settings_option.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  ChangeProfilePicDialog showDialog = ChangeProfilePicDialog();

  @override
  void didChangeDependencies() {
    BlocProvider.of<AccountBloc>(context).add(
      GetUserInfoEvent(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray.withOpacity(0.1),
      body: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
        return Container(
          height: screenHeight,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25 + safeAreaTop,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                userPhotoAndNameWidget(state),
                const SizedBox(
                  height: 60,
                ),
                TouchRippleEffect(
                  rippleColor: AppColors.violet.withOpacity(0.5),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  ),
                  child: const SettingsOption(
                    icon: CupertinoIcons.create,
                    title: 'Edit profile',
                  ),
                ),
                TouchRippleEffect(
                  rippleColor: AppColors.violet.withOpacity(0.5),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  ),
                  child: const SettingsOption(
                    icon: CupertinoIcons.lock,
                    title: 'Change password',
                  ),
                ),
                const SettingsOption(
                  icon: VerifeyeIcons.legal,
                  title: 'Terms and conditions',
                ),
                const SettingsOption(
                  icon: VerifeyeIcons.privace,
                  title: 'Privacy policy',
                ),
                TouchRippleEffect(
                  rippleColor: AppColors.violet.withOpacity(0.5),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountPage(),
                    ),
                  ),
                  child: const SettingsOption(
                    icon: CupertinoIcons.delete,
                    title: 'Delete account',
                  ),
                ),
                logOutWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget logOutWidget() {
    return TouchRippleEffect(
      rippleColor: AppColors.violet.withOpacity(0.5),
      onTap: () => BlocProvider.of<LogOutBloc>(context).add(
        UserLogOutEvent(
          onSuccess: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (_) => false,
            );
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.exit_to_app,
              color: AppColors.violet,
              size: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'Log out',
              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userPhotoAndNameWidget(AccountState state) {
    return state.user != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              photoWidget(state),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: screenWidth - 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.user!.firstName} ${state.user!.lastName}',
                      style: Theme.of(context).primaryTextTheme.bodyLarge,
                    ),
                    Text(
                      state.user!.email,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyMedium!
                          .copyWith(
                            color: AppColors.black,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget photoWidget(AccountState state) {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(
              width: 2,
              color: AppColors.backgroundViolet,
            )),
        child: state.user!.photoUrl == null
            ? const Icon(
                Icons.person,
                size: 70,
                color: AppColors.gray,
              )
            : SizedBox(
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(61.0),
                  child: Image.network(
                    state.user!.photoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}
