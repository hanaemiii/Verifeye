import 'dart:io';

import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final File? file;

  const MainState({
    required this.file,
  });
  MainState copyWith({
    File? file,
  }) {
    return MainState(
      file: file ?? this.file,
    );
  }

  MainState copyWithFile({
    File? file,
  }) {
    return MainState(
      file: file,
    );
  }

  @override
  List<Object?> get props => [
        file,
      ];
}
