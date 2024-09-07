import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verifeye/base/icons/verifeye_icons_icons.dart';
import 'package:verifeye/base/theme/colors.dart';

class SettingsOption extends StatefulWidget {
  const SettingsOption({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  @override
  State<SettingsOption> createState() => _SettingsOptionState();
}

class _SettingsOptionState extends State<SettingsOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.violet,
                    size: widget.icon == VerifeyeIcons.legal ||
                            widget.icon == VerifeyeIcons.privace
                        ? 20
                        : 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.title,
                    style:
                        Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                  ),
                ],
              ),
              const Icon(
                CupertinoIcons.chevron_forward,
                size: 30,
                color: AppColors.backgroundViolet,
              )
            ],
          ),
        ),
        const Divider(
          color: AppColors.gray,
        ),
      ],
    );
  }
}
