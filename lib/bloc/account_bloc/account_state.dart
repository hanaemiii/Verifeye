import 'dart:io';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:verifeye/core/forms/change_name_form.dart';
import 'package:verifeye/models/user_model.dart';

class AccountState extends Equatable {
  final File? file;
  final AppUser? user;
  final CameraController? controller;
  final ChangeNameForm form;
  final bool loading;

  const AccountState({
    required this.file,
    required this.user,
    required this.controller,
    required this.form,
    required this.loading,
  });
  AccountState copyWith({
    File? file,
    AppUser? user,
    CameraController? controller,
    ChangeNameForm? form,
    bool? loading,
  }) {
    return AccountState(
      file: file ?? this.file,
      user: user ?? this.user,
      controller: controller ?? this.controller,
      form: form ?? this.form,
      loading: loading ?? this.loading,
    );
  }

  AccountState copyWithFile({
    File? file,
  }) {
    return AccountState(
      file: file,
      user: user,
      controller: controller,
      form: form,
      loading: loading,
    );
  }

  @override
  List<Object?> get props => [
        file,
        user,
        controller,
        form,
        loading,
      ];
}
