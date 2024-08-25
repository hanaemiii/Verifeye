import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/confirm_password_form.dart';

class DeleteAccountState extends Equatable {
  final bool checked;
  final ConfirmPasswordForm form;
  final bool loading;

  const DeleteAccountState({
    required this.checked,
    required this.form,
    required this.loading,
  });
  DeleteAccountState copyWith({
    bool? checked,
    ConfirmPasswordForm? form,
    bool? loading,
  }) {
    return DeleteAccountState(
      checked: checked ?? this.checked,
      form: form ?? this.form,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        checked,
        form,
        loading,
      ];
}
