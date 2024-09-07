import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verifeye/bloc/splash_screen/splash_screen_event.dart';
import 'package:verifeye/bloc/splash_screen/splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc()
      : super(
          const SplashScreenState(
            isSelectedUpdates: false,
            isSelectedTerms: false,
          ),
        ) {
    on<LoadSplashEvent>(loadSplash);
  }

  Future<void> loadSplash(
      LoadSplashEvent event, Emitter<SplashScreenState> emit) async {
    await Future.delayed(
      const Duration(milliseconds: 2500),
    );

    event.onDone.call();
  }
}
