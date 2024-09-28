import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/bloc/account_bloc/account_bloc.dart';
import 'package:verifeye/bloc/account_bloc/account_event.dart';
import 'package:verifeye/pages/take_photo_pages/camera_screen.dart';

class ChangeProfilePicDialog {
  void changePic(
    BuildContext context,
  ) {
    TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
    AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(18),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          content: SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                takePhotoWidget(
                  context: context,
                  primaryTextTheme: primaryTextTheme,
                ),
                const SizedBox(
                  height: 16,
                ),
                openGalleryWidget(
                  context: context,
                  primaryTextTheme: primaryTextTheme,
                  accountBloc: accountBloc,
                ),
                const SizedBox(
                  height: 16,
                ),
                deletePhotoWidget(
                  context: context,
                  primaryTextTheme: primaryTextTheme,
                  accountBloc: accountBloc,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget takePhotoWidget({
    required BuildContext context,
    required TextTheme primaryTextTheme,
  }) {
    return TouchRippleEffect(
      rippleColor: AppColors.violet.withOpacity(0.5),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraScreen(),
          ),
        );
      },
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.camera,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            'Take a photo',
            style: primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget deletePhotoWidget({
    required BuildContext context,
    required TextTheme primaryTextTheme,
    required AccountBloc accountBloc,
  }) {
    return TouchRippleEffect(
      rippleColor: AppColors.backgroundViolet.withOpacity(0.5),
      onTap: () {
        accountBloc.add(
          DeletePhotoEvent(),
        );

        Navigator.pop(context);
      },
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.delete,
            color: Color(0xFFFF0000),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            'Delete photo',
            style: primaryTextTheme.bodyMedium!.copyWith(
              color: const Color(0xFFFF0000),
            ),
          ),
        ],
      ),
    );
  }

  Widget openGalleryWidget({
    required BuildContext context,
    required TextTheme primaryTextTheme,
    required AccountBloc accountBloc,
  }) {
    return TouchRippleEffect(
      rippleColor: AppColors.violet.withOpacity(0.5),
      onTap: () {
        accountBloc.add(
          ChooseProfilePhotoEvent(),
        );

        Navigator.pop(context);
      },
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.photo_on_rectangle,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            'Open gallery',
            style: primaryTextTheme.bodyMedium!.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
