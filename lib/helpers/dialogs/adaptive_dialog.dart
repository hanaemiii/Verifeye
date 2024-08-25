import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verifeye/widgets/buttons/dialog_ok_button.dart';
import 'package:verifeye/widgets/buttons/resend_email_button.dart';

class AdaptiveDialog {
  void showAdaptiveDialog(
    context, {
    required Text title,
    required Text content,
    bool resend = false,
  }) {
    Platform.isIOS || Platform.isMacOS
        ? showCupertinoDialog<String>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: title,
              content: content,
              actions: resend
                  ? [
                      const DialogOkButton(),
                      const ResendEmailButton(),
                    ]
                  : [
                      const DialogOkButton(),
                    ],
            ),
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: title,
              content: content,
              actions: resend
                  ? [
                      const DialogOkButton(),
                      const ResendEmailButton(),
                    ]
                  : [
                      const DialogOkButton(),
                    ],
            ),
          );
  }
}
