import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/change_password_form.dart';

class ChangePasswordState extends Equatable {
  final ChangePasswordForm form;
  final bool loading;
  const ChangePasswordState({
    required this.form,
    required this.loading,
  });
  ChangePasswordState copyWith({
    String? email,
    bool? loading,
    final ChangePasswordForm? form,
  }) {
    return ChangePasswordState(
      loading: loading ?? this.loading,
      form: form ?? this.form,
    );
  }

  @override
  List<Object?> get props => [
        form,
        loading,
      ];
}
