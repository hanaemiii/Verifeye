import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/core/forms/general_form.dart';

class SignInForm extends GeneralForm {
  static const _emailControlName = 'email';
  static const _passwordControlName = 'password';

  SignInForm()
      : super(
          FormGroup({
            _emailControlName: FormControl<String>(
              validators: [
                Validators.required,
                Validators.email,
              ],
            ),
            _passwordControlName: FormControl<String>(
              validators: [
                Validators.required,
              ],
            ),
          }),
        );

  FormControl<String> get emailControl =>
      formGroup.control(_emailControlName) as FormControl<String>;
  FormControl<String> get passwordControl =>
      formGroup.control(_passwordControlName) as FormControl<String>;
}
