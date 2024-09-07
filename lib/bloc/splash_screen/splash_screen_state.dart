import 'package:equatable/equatable.dart';

class SplashScreenState extends Equatable {
  final bool isSelectedUpdates;
  final bool isSelectedTerms;

  const SplashScreenState({
    required this.isSelectedUpdates,
    required this.isSelectedTerms,
  });
  SplashScreenState copyWith({
    bool? isSelectedUpdates,
    bool? isSelectedTerms,
  }) {
    return SplashScreenState(
      isSelectedUpdates: isSelectedUpdates ?? this.isSelectedUpdates,
      isSelectedTerms: isSelectedTerms ?? this.isSelectedTerms,
    );
  }

  @override
  List<Object?> get props => [
        isSelectedUpdates,
        isSelectedTerms,
      ];
}
