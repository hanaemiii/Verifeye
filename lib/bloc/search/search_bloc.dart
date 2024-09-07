import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/bloc/search/search_event.dart';
import 'package:verifeye/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(
          const SearchState(
            loading: false,
          ),
        ) {
    on<CheckUrlEvent>(checkUrl);
  }

  Future<void> checkUrl(CheckUrlEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(loading: true),
    );
  }
}
