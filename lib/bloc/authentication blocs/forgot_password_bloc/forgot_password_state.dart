import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/forgot_password_form.dart';
import 'package:verifeye/core/resources/data_state.dart';

class ForgotPasswordState extends Equatable {
  final ForgotPasswordForm form;
  final bool loading;
  final DataState<dynamic> response;
  const ForgotPasswordState({
    required this.form,
    required this.loading,
    required this.response,
  });
  ForgotPasswordState copyWith({
    String? email,
    bool? loading,
    ForgotPasswordForm? form,
    DataState<dynamic>? response,
  }) {
    return ForgotPasswordState(
      loading: loading ?? this.loading,
      form: form ?? this.form,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        form,
        loading,
        response,
      ];
}
