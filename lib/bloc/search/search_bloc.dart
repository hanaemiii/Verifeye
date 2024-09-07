import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:verifeye/bloc/search/search_event.dart';
import 'package:verifeye/bloc/search/search_state.dart';
import 'package:verifeye/core/firebase_services/firestore_database.dart';
import 'package:verifeye/models/searched_link_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(
          SearchState(
            loading: false,
            controller: TextEditingController(),
          ),
        ) {
    on<CheckUrlEvent>(checkUrl);
    on<GetLinkEvent>(getLink);
    on<CleanStateEvent>(cleanState);
  }
  final FirestoreDatabaseService firestoreDatabaseService =
      GetIt.I<FirestoreDatabaseService>();

  void cleanState(CleanStateEvent event, Emitter<SearchState> emit) {
    emit(
      SearchState(
        loading: false,
        controller: TextEditingController(),
      ),
    );
  }

  Future<void> checkUrl(CheckUrlEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(loading: true),
    );

    SearchedLink link = SearchedLink(
      url: state.controller.text,
    );
    // set link to db
    await firestoreDatabaseService.setLink(link);
    // listen and get link model to show data changes on the screen
    firestoreDatabaseService.getLink(state.controller.text).listen(
      (link) {
        add(
          GetLinkEvent(link: link),
        );
      },
    );
  }

  getLink(GetLinkEvent event, Emitter<SearchState> emit) {
    if (event.link != null) {
      emit(
        state.copyWith(
          link: event.link,
        ),
      );
      if (event.link!.sslStatus != null) {
        emit(
          state.copyWith(
            loading: false,
          ),
        );
      }
    }
  }
}
