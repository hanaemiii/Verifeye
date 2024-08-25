import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/core/forms/general_form.dart';

class ConfirmPasswordForm extends GeneralForm {
  static const _currentPasswordControlName = 'currentPassword';

  ConfirmPasswordForm()
      : super(
          FormGroup(
            {
              _currentPasswordControlName: FormControl<String>(
                validators: [Validators.required],
              ),
            },
          ),
        );

  FormControl<String> get currentPasswordControl =>
      formGroup.control(_currentPasswordControlName) as FormControl<String>;
}
