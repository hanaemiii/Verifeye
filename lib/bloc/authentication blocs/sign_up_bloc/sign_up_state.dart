import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/sign_up_form.dart';

class SignUpState extends Equatable {
  final SignUpForm form;
  final bool loading;
  final List gradeData;
  const SignUpState({
    required this.form,
    required this.loading,
    required this.gradeData,
  });
  SignUpState copyWith({
    String? email,
    bool? loading,
    List? gradeData,
    final SignUpForm? form,
  }) {
    return SignUpState(
      loading: loading ?? this.loading,
      form: form ?? this.form,
      gradeData: gradeData ?? this.gradeData,
    );
  }

  @override
  List<Object?> get props => [
        form,
        loading,
        gradeData,
      ];
}
