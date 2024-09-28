import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:verifeye/models/user_model.dart';

class MainState extends Equatable {
  final File? file;
  final AppUser? user;
  final String? imageInfo;
  final bool loading;

  const MainState({
    this.file,
    this.user,
    this.imageInfo,
    required this.loading,
  });
  MainState copyWith({
    File? file,
    AppUser? user,
    String? imageInfo,
    bool? loading,
  }) {
    return MainState(
      file: file ?? this.file,
      user: user ?? this.user,
      imageInfo: imageInfo ?? this.imageInfo,
      loading: loading ?? this.loading,
    );
  }

  MainState copyWithFile({
    File? file,
    String? imageInfo,
  }) {
    return MainState(
      file: file,
      user: user,
      imageInfo: imageInfo,
      loading: loading,
    );
  }

  @override
  List<Object?> get props => [
        file,
        user,
        imageInfo,
        loading,
      ];
}
