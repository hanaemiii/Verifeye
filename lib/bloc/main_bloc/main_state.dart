import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:verifeye/models/user_model.dart';

class MainState extends Equatable {
  final File? file;
  final AppUser? user;

  const MainState({
    this.file,
    this.user,
  });
  MainState copyWith({
    File? file,
    AppUser? user,
  }) {
    return MainState(
      file: file ?? this.file,
      user: user ?? this.user,
    );
  }

  MainState copyWithFile({
    File? file,
  }) {
    return MainState(
      file: file,
      user: user,
    );
  }

  @override
  List<Object?> get props => [
        file,
        user,
      ];
}
