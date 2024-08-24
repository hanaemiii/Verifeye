import 'package:reactive_forms/reactive_forms.dart';
import 'package:verifeye/core/forms/general_form.dart';

class ChangeNameForm extends GeneralForm {
  static const _firstNameControl = 'first_name';
  static const _lastNameControl = 'last_name';

  ChangeNameForm()
      : super(
          FormGroup(
            {
              _firstNameControl: FormControl<String>(
                validators: [Validators.required],
              ),
              _lastNameControl: FormControl<String>(
                validators: [Validators.required],
              ),
            },
          ),
        );

  FormControl<String> get firstNameControl =>
      formGroup.control(_firstNameControl) as FormControl<String>;
  FormControl<String> get lastNameControl =>
      formGroup.control(_lastNameControl) as FormControl<String>;
}
