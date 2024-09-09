import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:verifeye/pages/conditions_pages/privacy_policy.dart';
import 'package:verifeye/pages/conditions_pages/terms_conditions.dart';

class TermsAndPrivacyWidget extends StatefulWidget {
  const TermsAndPrivacyWidget({
    super.key,
    required this.textColor,
  });
  final int textColor;
  @override
  State<TermsAndPrivacyWidget> createState() => _TermsAndPrivacyWidgetState();
}

class _TermsAndPrivacyWidgetState extends State<TermsAndPrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: SizedBox(
              height: mediaHeight < 1000 ? 20 : null,
              child: AutoSizeText(
                'see ',
                minFontSize: 10,
                style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                      color: Color(widget.textColor),
                    ),
              ),
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsConditionsPage(),
                  ),
                );
              },
              child: SizedBox(
                height: mediaHeight < 1000 ? 20 : null,
                child: AutoSizeText(
                  'Terms and Conditions',
                  minFontSize: 10,
                  style:
                      Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                            color: Color(widget.textColor),
                            decorationColor: Color(widget.textColor),
                            decoration: TextDecoration.underline,
                          ),
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: SizedBox(
              height: mediaHeight < 1000 ? 20 : null,
              child: AutoSizeText(
                ' and ',
                minFontSize: 10,
                style: Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                      color: Color(widget.textColor),
                    ),
              ),
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                );
              },
              child: SizedBox(
                height: mediaHeight < 1000 ? 20 : null,
                child: AutoSizeText(
                  'Privacy Policy.',
                  minFontSize: 10,
                  style:
                      Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                            color: Color(widget.textColor),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(widget.textColor),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
