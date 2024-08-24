import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/core/forms/general_form.dart';

class SignUpForm extends GeneralForm {
  static const _emailControlName = 'email';
  static const _firstNameControl = 'first_name';
  static const _lastNameControl = 'last_name';
  static const _passwordControlName = 'password';
  static const _confirmPasswordControlName = 'confirm_password';
  static const _agreeControlName = 'agree';

  SignUpForm()
      : super(
          FormGroup(
            {
              _emailControlName: FormControl<String>(
                validators: [
                  Validators.required,
                  Validators.email,
                ],
              ),
              _firstNameControl: FormControl<String>(
                validators: [Validators.required],
              ),
              _lastNameControl: FormControl<String>(
                validators: [Validators.required],
              ),
              _passwordControlName: FormControl<String>(
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
              _agreeControlName: FormControl<bool>(
                validators: [
                  Validators.equals(true),
                ],
              ),
            },
            validators: [
              const MustMatchCustomValidator(
                _passwordControlName,
                _confirmPasswordControlName,
              ),
            ],
          ),
        );

  FormControl<String> get emailControl =>
      formGroup.control(_emailControlName) as FormControl<String>;
  FormControl<String> get firstNameControl =>
      formGroup.control(_firstNameControl) as FormControl<String>;
  FormControl<String> get lastNameControl =>
      formGroup.control(_lastNameControl) as FormControl<String>;
  FormControl<String> get passwordControl =>
      formGroup.control(_passwordControlName) as FormControl<String>;
  FormControl<String> get confirmPasswordControl =>
      formGroup.control(_confirmPasswordControlName) as FormControl<String>;
  FormControl<bool> get agreeControl =>
      formGroup.control(_agreeControlName) as FormControl<bool>;
}
