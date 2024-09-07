import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final bool loading;

  const SearchState({
    required this.loading,
  });
  SearchState copyWith({
    bool? loading,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        loading,
      ];
}
