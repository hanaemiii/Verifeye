import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/base/theme/colors.dart';

class CustomCheckBox extends StatelessWidget {
  final FormControl<bool> formControl;
  final Widget? trailing;

  const CustomCheckBox({
    super.key,
    required this.formControl,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        final value = formControl.value == true;
        formControl.updateValue(!value);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<ControlStatus>(
            stream: formControl.statusChanged,
            builder: (context, snapshot) {
              final hasError =
                  formControl.touched && snapshot.data == ControlStatus.invalid;
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: hasError
                        ? Theme.of(context).colorScheme.error
                        : AppColors.black,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: StreamBuilder(
                    stream: formControl.valueChanges,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: snapshot.data == true,
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: AppColors.violet,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: trailing!,
            ),
        ],
      ),
    );
  }
}
