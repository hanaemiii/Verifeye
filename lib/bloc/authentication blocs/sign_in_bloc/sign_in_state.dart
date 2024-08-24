import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/sign_in_form.dart';

class SignInState extends Equatable {
  final SignInForm signInForm;
  final bool loading;

  const SignInState({
    required this.signInForm,
    required this.loading,
  });
  SignInState copyWith({
    SignInForm? signInForm,
    bool? loading,
  }) {
    return SignInState(
      signInForm: signInForm ?? this.signInForm,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        signInForm,
        loading,
      ];
}
