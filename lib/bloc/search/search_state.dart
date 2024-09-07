import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:verifeye/models/searched_link_model.dart';

class SearchState extends Equatable {
  final bool loading;
  final SearchedLink? link;
  final TextEditingController controller;

  const SearchState({
    required this.loading,
    this.link,
    required this.controller,
  });
  SearchState copyWith({
    bool? loading,
    SearchedLink? link,
    TextEditingController? controller,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      link: link ?? this.link,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        link,
        controller,
      ];
}
