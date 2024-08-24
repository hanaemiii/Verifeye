import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/core/forms/general_form.dart';

class ChangePasswordForm extends GeneralForm {
  static const _currentPasswordControlName = 'currentPassword';
  static const _newPasswordControlName = 'newPassword';
  static const _confirmPasswordControlName = 'confirm_password';

  ChangePasswordForm()
      : super(
          FormGroup(
            {
              _currentPasswordControlName: FormControl<String>(
                validators: [
                  Validators.required,
                ],
              ),
              _newPasswordControlName: FormControl<String>(
                validators: [
                  Validators.required,
                  Validators.minLength(8),
                  Validators.pattern(
                    RegExp(r'^(?=.*[A-Z])(?=.*[\d\W])[A-Za-z\d\W]+$'),
                  ),
                ],
              ),
              _confirmPasswordControlName: FormControl<String>(
                validators: [Validators.required],
              ),
            },
            validators: [
              const MustMatchCustomValidator(
                _newPasswordControlName,
                _confirmPasswordControlName,
              ),
            ],
          ),
        );

  FormControl<String> get currentPasswordControl =>
      formGroup.control(_currentPasswordControlName) as FormControl<String>;
  FormControl<String> get newPasswordControl =>
      formGroup.control(_newPasswordControlName) as FormControl<String>;
  FormControl<String> get confirmPasswordControl =>
      formGroup.control(_confirmPasswordControlName) as FormControl<String>;
}
