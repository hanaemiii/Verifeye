import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/base/theme/colors.dart';
import 'package:verifeye/base/theme/decorations/input/decorated_input_border.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.formControl,
    this.suffixIcon,
    this.obscureText = false,
    this.numberCount,
    this.type,
    this.controllerValue,
  });
  final String hintText;
  final String labelText;
  final TextInputType? type;
  final FormControl formControl;
  final int? numberCount;
  final String? controllerValue;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late TextEditingController _controller;
  var obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    _controller = TextEditingController(text: widget.controllerValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update form control value
    widget.formControl.value = _controller.text;

    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'Field must not be empty',
        ValidationMessage.email: (error) => 'Must enter a valid email',
        ValidationMessage.minLength: (error) => 'Must contain 4 numbers.',
      },
      child: ReactiveTextField(
        obscureText: obscureText,
        formControl: widget.formControl,
        controller: _controller,
        keyboardType: widget.type,
        inputFormatters: widget.type != null
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.numberCount),
              ]
            : null,
        decoration: InputDecoration(
          fillColor: AppColors.gray.withOpacity(0.15),
          filled: true,
          suffixIcon: suffixIcon,
          border: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(16),
            ),
            shadow: BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 3),
              color: AppColors.black.withOpacity(0.15),
            ),
          ),
          focusedBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.greenCyan,
              ),
            ),
            shadow: BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 3),
              color: AppColors.black.withOpacity(0.15),
            ),
          ),
          enabledBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.black.withOpacity(0.12),
              ),
            ),
            shadow: BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 3),
              color: AppColors.black.withOpacity(0.15),
            ),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black.withOpacity(0.33),
              ),
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(0.8),
              ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget? get suffixIcon {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.obscureText) {
      return GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        // child: Icon(
        //   // obscureText ? WoloIcons.eyeOff : WoloIcons.eye,
        // ),
      );
    }

    return null;
  }
}
